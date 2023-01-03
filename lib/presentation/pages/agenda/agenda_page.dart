import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/utils.dart';
import 'package:siak_mobile/presentation/bloc/all_agenda/all_agenda_bloc.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:siak_mobile/presentation/widget/agenda_card.dart';
import 'package:siak_mobile/presentation/widget/bottom_loader.dart';
import 'package:siak_mobile/presentation/widget/form/search_form_field.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_agenda.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> with RouteAware {
  final searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          context.read<AllAgendaBloc>().add(const OnFetchData(isRefresh: true)),
    );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      if (searchController.text.isEmpty) {
        context.read<AllAgendaBloc>().add(const OnFetchData());
      } else {
        context
            .read<AllAgendaBloc>()
            .add(OnQueryChanged(searchController.text));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<AllAgendaBloc>().add(const OnFetchData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          context.read<AuthenticationCubit>().signOut();
        }
        if (state is SignOutError) {
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
          title: const Text('Your Agenda'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
              child: SearchFormField(
                hintText: 'Cari agenda',
                controller: searchController,
                onChanged: (query) {
                  context.read<AllAgendaBloc>().add(OnQueryChanged(
                        query,
                        isRefresh: true,
                      ));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<AllAgendaBloc, AllAgendaState>(
                builder: (context, state) {
                  switch (state.status) {
                    case AllAgendaStatus.failure:
                      return ViewError(
                        message: state.errorMessage,
                        showRefresh: true,
                        onRefresh: () {
                          if (searchController.text.isEmpty) {
                            context
                                .read<AllAgendaBloc>()
                                .add(const OnFetchData(isRefresh: true));
                          } else {
                            context.read<AllAgendaBloc>().add(OnQueryChanged(
                                  searchController.text,
                                  isRefresh: true,
                                ));
                          }
                        },
                      );
                    case AllAgendaStatus.success:
                      if (state.agendas.isEmpty) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: ViewEmpty(
                            title: searchController.text.isEmpty
                                ? 'Agenda tidak ditemukan!'
                                : 'Tidak ada agenda dengan keyword "${searchController.text}"',
                            description:
                                'Silahkan buat agenda terlebih dahulu.',
                            showRefresh: true,
                            onRefresh: () {
                              if (searchController.text.isEmpty) {
                                context
                                    .read<AllAgendaBloc>()
                                    .add(const OnFetchData(isRefresh: true));
                              } else {
                                context
                                    .read<AllAgendaBloc>()
                                    .add(OnQueryChanged(
                                      searchController.text,
                                      isRefresh: true,
                                    ));
                              }
                            },
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          if (searchController.text.isEmpty) {
                            context
                                .read<AllAgendaBloc>()
                                .add(const OnFetchData(isRefresh: true));
                          } else {
                            context.read<AllAgendaBloc>().add(OnQueryChanged(
                                  searchController.text,
                                  isRefresh: true,
                                ));
                          }
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return index >= state.agendas.length
                                ? const BottomLoader()
                                : Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            index == 0 ? AppDefaults.margin : 0,
                                        bottom:
                                            index == state.agendas.length - 1
                                                ? AppDefaults.margin
                                                : 10),
                                    child: AgendaCard(
                                      agenda: state.agendas[index],
                                    ),
                                  );
                          },
                          itemCount: state.hasReachedMax
                              ? state.agendas.length
                              : state.agendas.length + 1,
                          controller: _scrollController,
                        ),
                      );
                    case AllAgendaStatus.initial:
                      return Shimmer.fromColors(
                        baseColor: AppColors.baseColor,
                        highlightColor: AppColors.highlightColor,
                        enabled: true,
                        child: ListView.builder(
                          padding:
                              const EdgeInsets.only(top: AppDefaults.margin),
                          itemBuilder: (_, __) => const LoadingAgenda(),
                          itemCount: 3,
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
