import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/bloc/student_in_class/student_in_class_bloc.dart';
import 'package:siak_mobile/presentation/pages/all_selected_student/components/item_selected_student.dart';
import 'package:siak_mobile/presentation/widget/form/search_form_field.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_selected_student.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class AllSelectedStudentPage extends StatefulWidget {
  final String idAgenda;
  final String? selectedNoStudent;

  const AllSelectedStudentPage({
    Key? key,
    required this.idAgenda,
    this.selectedNoStudent,
  }) : super(key: key);

  @override
  State<AllSelectedStudentPage> createState() => _AllSelectedStudentPageState();
}

class _AllSelectedStudentPageState extends State<AllSelectedStudentPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<StudentInClassBloc>().add(OnFetchData(widget.idAgenda)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Daftar Siswa'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
            child: SearchFormField(
              hintText: 'Cari siswa',
              controller: searchController,
              onChanged: (query) {
                context.read<StudentInClassBloc>().add(OnQueryChanged(
                      widget.idAgenda,
                      query,
                    ));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<StudentInClassBloc, StudentInClassState>(
              builder: (context, state) {
                if (state is StudentInClassLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(top: AppDefaults.padding),
                    child: Shimmer.fromColors(
                      baseColor: AppColors.baseColor,
                      highlightColor: AppColors.highlightColor,
                      enabled: true,
                      child: ListView.separated(
                        itemBuilder: (_, __) => const LoadingSelectedStudent(),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: 8,
                      ),
                    ),
                  );
                } else if (state is StudentInClassEmpty) {
                  return ViewEmpty(
                    title: searchController.text.isEmpty
                        ? 'Siswa tidak ada!'
                        : 'Tidak ada siswa dengan nama "${searchController.text}"',
                    description: 'Tidak terdapat siswa yang mengikuti kelas.',
                    showRefresh: true,
                    onRefresh: () {
                      if (searchController.text.isEmpty) {
                        context
                            .read<StudentInClassBloc>()
                            .add(OnFetchData(widget.idAgenda));
                      } else {
                        context.read<StudentInClassBloc>().add(OnQueryChanged(
                              widget.idAgenda,
                              searchController.text,
                            ));
                      }
                    },
                  );
                } else if (state is StudentInClassHasData) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      if (searchController.text.isEmpty) {
                        context
                            .read<StudentInClassBloc>()
                            .add(OnFetchData(widget.idAgenda));
                      } else {
                        context.read<StudentInClassBloc>().add(OnQueryChanged(
                              widget.idAgenda,
                              searchController.text,
                            ));
                      }
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final absensi = state.absensi[index];
                        return Container(
                          margin: EdgeInsets.only(
                              top: index == 0 ? 8 : 0,
                              bottom:
                                  index == state.absensi.length - 1 ? 8 : 0),
                          child: ItemSelectedStudent(
                            absensi: absensi,
                            selected:
                                absensi.noSiswa == widget.selectedNoStudent,
                            onTap: () => Navigator.pop(context, absensi),
                          ),
                        );
                      },
                      itemCount: state.absensi.length,
                    ),
                  );
                } else if (state is StudentInClassError) {
                  return ViewError(
                    message: state.message,
                    showRefresh: true,
                    onRefresh: () {
                      if (searchController.text.isEmpty) {
                        context
                            .read<StudentInClassBloc>()
                            .add(OnFetchData(widget.idAgenda));
                      } else {
                        context.read<StudentInClassBloc>().add(OnQueryChanged(
                              widget.idAgenda,
                              searchController.text,
                            ));
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
