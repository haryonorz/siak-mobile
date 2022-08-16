import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/presentation/cubit/action_situation_class/action_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_situation_class/all_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/pages/situation_class/components/item_situation_class.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class SituationClassPage extends StatefulWidget {
  final String idAgenda;

  const SituationClassPage({Key? key, required this.idAgenda})
      : super(key: key);

  @override
  State<SituationClassPage> createState() => _SituationClassPageState();
}

class _SituationClassPageState extends State<SituationClassPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<AllSituationClassCubit>().fetchData(widget.idAgenda));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionSituationClassCubit, ActionSituationClassState>(
      listener: (context, state) {
        if (state is ActionSituationClassSuccess) {
          context.read<AllSituationClassCubit>().fetchData(widget.idAgenda);
        }
        if (state is ActionSituationClassError) {
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
          title: const Text('Potret Kelas'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.addSituationClass,
            arguments: widget.idAgenda,
          ),
          backgroundColor: AppColors.backgroundRed,
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<AllSituationClassCubit, AllSituationClassState>(
          builder: (context, state) {
            if (state is AllSituationClassLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AllSituationClassEmpty) {
              return ViewEmpty(
                title: 'Potret kelas tidak ada!',
                description:
                    'Tidak ada masalah dalam kelas. Anda dapat menambahkan laporan jika terdapat siswa yang bermasalah di dalam kelas',
                showRefresh: true,
                onRefresh: () {
                  context
                      .read<AllSituationClassCubit>()
                      .fetchData(widget.idAgenda);
                },
              );
            } else if (state is AllSituationClassHasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<AllSituationClassCubit>()
                      .fetchData(widget.idAgenda);
                },
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final absensi = state.absensi[index];
                    return ItemSituationClass(absensi: absensi);
                  },
                  itemCount: state.absensi.length,
                ),
              );
            } else if (state is AllSituationClassError) {
              return ViewError(
                message: state.message,
                showRefresh: true,
                onRefresh: () {
                  context
                      .read<AllSituationClassCubit>()
                      .fetchData(widget.idAgenda);
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
