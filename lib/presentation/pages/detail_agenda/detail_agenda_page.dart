import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/arg_attendance_list.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/detail_agenda/detail_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/user/user_cubit.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/button_close_agenda.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_attendance_recap.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_note_class.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_detail_agenda.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_potret_kelas.dart';
import 'package:siak_mobile/presentation/widget/item_attendance_student.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class DetailAgendaPage extends StatefulWidget {
  final String idAgenda;

  const DetailAgendaPage({Key? key, required this.idAgenda}) : super(key: key);

  @override
  State<DetailAgendaPage> createState() => _DetailAgendaPageState();
}

class _DetailAgendaPageState extends State<DetailAgendaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<UserCubit>().fetchData();
      context.read<DetailAgendaCubit>().fetchData(widget.idAgenda);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionAgendaCubit, ActionAgendaState>(
      listener: (context, state) {
        if (state is ActionAgendaSuccess) {
          context.read<DetailAgendaCubit>().fetchData(widget.idAgenda);
        }
        if (state is ActionAgendaError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.textWhite),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
              elevation: 0,
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Detail Agenda'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
        ),
        body: BlocBuilder<DetailAgendaCubit, DetailAgendaState>(
          builder: (context, state) {
            if (state is DetailAgendaLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailAgendaHasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<DetailAgendaCubit>().fetchData(widget.idAgenda);
                },
                child: ListView(
                  children: [
                    ViewDetaiAgenda(
                      agenda: state.detailAgenda.agenda,
                      totalRequestJoin:
                          state.detailAgenda.totalRequestJoin ?? 0,
                      userType: state.user.type,
                      absensi: state.detailAgenda.absensi,
                    ),
                    const SizedBox(height: AppDefaults.xlSpace),
                    state.user.type == 'tutor'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ViewAttendanceRecap(
                                absensiRekap:
                                    state.detailAgenda.attendanceRecap,
                                idAgenda: state.detailAgenda.agenda.idAgenda,
                              ),
                              const SizedBox(height: AppDefaults.xlSpace),
                              ViewPotretKelas(
                                  agenda: state.detailAgenda.agenda),
                              const SizedBox(height: AppDefaults.xlSpace),
                              ViewNoteClass(
                                agenda: state.detailAgenda.agenda,
                              ),
                              if (state.detailAgenda.agenda.status == '0')
                                Column(
                                  children: [
                                    const SizedBox(height: AppDefaults.xlSpace),
                                    ButtonCloseAgenda(
                                      idAgenda:
                                          state.detailAgenda.agenda.idAgenda,
                                    ),
                                  ],
                                )
                              else
                                Container(),
                              const SizedBox(height: AppDefaults.xlSpace),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: AppDefaults.padding,
                                  top: AppDefaults.padding,
                                  bottom: 10,
                                ),
                                child: Text(
                                  'Siswa',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              state.detailAgenda.agenda.allStudent.length != 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        final absensi = state.detailAgenda
                                            .agenda.allStudent[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                            top: index == 0 ? 16 : 0,
                                            bottom: 16,
                                          ),
                                          child: ItemAttendanceStudent(
                                            absensi: absensi,
                                            showPhotoAbsensi: absensi.noSiswa ==
                                                state.detailAgenda.absensi
                                                    ?.noSiswa,
                                          ),
                                        );
                                      },
                                      itemCount: state.detailAgenda.agenda
                                          .allStudent.length,
                                    )
                                  : const ViewEmpty(
                                      title: 'No data',
                                      description:
                                          'Tidak ada siswa yang mengikuti kelas',
                                    ),
                              state.detailAgenda.agenda.allStudent.length > 5
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                          context,
                                          Routes.attendanceList,
                                          arguments: ArgAttendanceList(
                                            idAgenda: state
                                                .detailAgenda.agenda.idAgenda,
                                            absensi: state.detailAgenda.absensi,
                                          ),
                                        ),
                                        child: Text(
                                          'Load More',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  color: AppColors.textRed),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(height: AppDefaults.xlSpace),
                            ],
                          ),
                  ],
                ),
              );
            } else if (state is DetailAgendaError) {
              return ViewError(
                message: state.message,
                showRefresh: true,
                onRefresh: () {
                  context.read<DetailAgendaCubit>().fetchData(widget.idAgenda);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
