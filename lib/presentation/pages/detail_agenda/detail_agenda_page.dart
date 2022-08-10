import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';
import 'package:siak_mobile/presentation/cubit/detail_agenda/detail_agenda_cubit.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/button_close_agenda.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_attendance_recap.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_note_class.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_detail_agenda.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/view_potret_kelas.dart';

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
    Future.microtask(
        () => context.read<DetailAgendaCubit>().fetchData(widget.idAgenda));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionAgendaCubit, ActionAgendaState>(
      listener: (context, state) {
        if (state is ActionAgendaSuccess) {
          context.read<DetailAgendaCubit>().fetchData(widget.idAgenda);
        }
        if (state is ActionAgendaMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message ?? "-",
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
                    ),
                    const SizedBox(height: AppDefaults.xlSpace),
                    ViewAttendanceRecap(
                      absensiRekap: state.detailAgenda.attendanceRecap,
                      idAgenda: state.detailAgenda.agenda.idAgenda,
                    ),
                    const SizedBox(height: AppDefaults.xlSpace),
                    ViewPotretKelas(
                        idAgenda: state.detailAgenda.agenda.idAgenda),
                    const SizedBox(height: AppDefaults.xlSpace),
                    ViewNoteClass(
                      agenda: state.detailAgenda.agenda,
                    ),
                    if (state.detailAgenda.agenda.status == '0')
                      Column(
                        children: [
                          const SizedBox(height: AppDefaults.xlSpace),
                          ButtonCloseAgenda(
                            idAgenda: state.detailAgenda.agenda.idAgenda,
                          ),
                        ],
                      )
                    else
                      Container(),
                    const SizedBox(height: AppDefaults.xlSpace),
                  ],
                ),
              );
            } else if (state is DetailAgendaError) {
              return Center(
                child: Text(state.message),
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
