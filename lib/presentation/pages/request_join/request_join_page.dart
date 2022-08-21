import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/accept_request_join/accept_request_join_cubit.dart';
import 'package:siak_mobile/presentation/cubit/all_request_join/all_request_join_cubit.dart';
import 'package:siak_mobile/presentation/pages/request_join/components/item_request_join.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class RequestJoinPage extends StatefulWidget {
  final String idAgenda;

  const RequestJoinPage({Key? key, required this.idAgenda}) : super(key: key);

  @override
  State<RequestJoinPage> createState() => _RequestJoinPageState();
}

class _RequestJoinPageState extends State<RequestJoinPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AllRequestJoinCubit>().fetchData(widget.idAgenda));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AcceptRequestJoinCubit, AcceptRequestJoinState>(
      listener: (context, state) {
        if (state is AcceptRequestJoinSuccess) {
          context.read<AllRequestJoinCubit>().fetchData(widget.idAgenda);
        }
        if (state is AcceptRequestJoinError) {
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
          title: const Text('Permintaan Ikut Kelas'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
        ),
        body: BlocBuilder<AllRequestJoinCubit, AllRequestJoinState>(
          builder: (context, state) {
            if (state is AllRequestJoinLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AllRequestJoinEmpty) {
              return ViewEmpty(
                title: 'Tidak ada permintaan!',
                description:
                    'Jika terdapat siswa tamu dikelas, silahkan memberitahukan siswa tamu yang ingin mengikuti kelas untuk ikut agenda kelas.',
                showRefresh: true,
                onRefresh: () {
                  context
                      .read<AllRequestJoinCubit>()
                      .fetchData(widget.idAgenda);
                },
              );
            } else if (state is AllRequestJoinHasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<AllRequestJoinCubit>()
                      .fetchData(widget.idAgenda);
                },
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final absensi = state.absensi[index];
                    return Container(
                      margin: EdgeInsets.only(
                        top: index == 0 ? 16 : 0,
                        bottom: 16,
                      ),
                      child: ItemRequestJoin(absensi: absensi),
                    );
                  },
                  itemCount: state.absensi.length,
                ),
              );
            } else if (state is AllRequestJoinError) {
              return ViewError(
                message: state.message,
                showRefresh: true,
                onRefresh: () {
                  context
                      .read<AllRequestJoinCubit>()
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
