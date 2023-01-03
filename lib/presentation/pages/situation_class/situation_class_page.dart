import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/common/utils.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/cubit/all_situation_class/all_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/pages/situation_class/components/item_situation_class.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_situation_class.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class SituationClassPage extends StatefulWidget {
  final Agenda agenda;

  const SituationClassPage({Key? key, required this.agenda}) : super(key: key);

  @override
  State<SituationClassPage> createState() => _SituationClassPageState();
}

class _SituationClassPageState extends State<SituationClassPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<AllSituationClassCubit>()
        .fetchData(widget.agenda.idAgenda));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<AllSituationClassCubit>().fetchData(widget.agenda.idAgenda);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Potret Kelas'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      floatingActionButton: widget.agenda.status == '0'
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.addSituationClass,
                arguments: widget.agenda.idAgenda,
              ),
              backgroundColor: AppColors.backgroundRed,
              child: const Icon(Icons.add),
            )
          : null,
      body: BlocBuilder<AllSituationClassCubit, AllSituationClassState>(
        builder: (context, state) {
          if (state is AllSituationClassLoading) {
            return Padding(
              padding: const EdgeInsets.only(top: AppDefaults.padding),
              child: Shimmer.fromColors(
                baseColor: AppColors.baseColor,
                highlightColor: AppColors.highlightColor,
                enabled: true,
                child: ListView.separated(
                  itemBuilder: (_, __) => const LoadingSituationClass(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: 8,
                ),
              ),
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
                    .fetchData(widget.agenda.idAgenda);
              },
            );
          } else if (state is AllSituationClassHasData) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<AllSituationClassCubit>()
                    .fetchData(widget.agenda.idAgenda);
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
                    .fetchData(widget.agenda.idAgenda);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
