import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/bloc/all_agenda_history/all_agenda_history_bloc.dart';
import 'package:siak_mobile/presentation/widget/agenda_card.dart';
import 'package:siak_mobile/presentation/widget/bottom_loader.dart';
import 'package:siak_mobile/presentation/widget/form/search_form_field.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_agenda.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class AgendaHistoryPage extends StatefulWidget {
  const AgendaHistoryPage({Key? key}) : super(key: key);

  @override
  State<AgendaHistoryPage> createState() => _AgendaHistoryPageState();
}

class _AgendaHistoryPageState extends State<AgendaHistoryPage> {
  final searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AllAgendaHistoryBloc>().add(const OnFetchData()));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      if (searchController.text.isEmpty) {
        context.read<AllAgendaHistoryBloc>().add(const OnFetchData());
      } else {
        context
            .read<AllAgendaHistoryBloc>()
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Riwayat Agenda'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
            child: SearchFormField(
              hintText: 'Cari agenda',
              controller: searchController,
              onChanged: (query) {
                context.read<AllAgendaHistoryBloc>().add(OnQueryChanged(
                      query,
                      isRefresh: true,
                    ));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<AllAgendaHistoryBloc, AllAgendaHistoryState>(
              builder: (context, state) {
                switch (state.status) {
                  case AllAgendaHistoryStatus.failure:
                    return ViewError(
                      message: state.errorMessage,
                      showRefresh: true,
                      onRefresh: () {
                        if (searchController.text.isEmpty) {
                          context
                              .read<AllAgendaHistoryBloc>()
                              .add(const OnFetchData());
                        } else {
                          context
                              .read<AllAgendaHistoryBloc>()
                              .add(OnQueryChanged(
                                searchController.text,
                                isRefresh: true,
                              ));
                        }
                      },
                    );
                  case AllAgendaHistoryStatus.success:
                    if (state.agendas.isEmpty) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: ViewEmpty(
                          title: searchController.text.isEmpty
                              ? 'Agenda tidak ditemukan!'
                              : 'Tidak ada agenda dengan keyword "${searchController.text}"',
                          description: 'Silahkan buat agenda terlebih dahulu.',
                          showRefresh: true,
                          onRefresh: () {
                            if (searchController.text.isEmpty) {
                              context
                                  .read<AllAgendaHistoryBloc>()
                                  .add(const OnFetchData(isRefresh: true));
                            } else {
                              context
                                  .read<AllAgendaHistoryBloc>()
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
                              .read<AllAgendaHistoryBloc>()
                              .add(const OnFetchData(isRefresh: true));
                        } else {
                          context
                              .read<AllAgendaHistoryBloc>()
                              .add(OnQueryChanged(
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
                                      top: index == 0 ? AppDefaults.margin : 0,
                                      bottom: index == state.agendas.length - 1
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
                  case AllAgendaHistoryStatus.initial:
                    return Shimmer.fromColors(
                      baseColor: AppColors.baseColor,
                      highlightColor: AppColors.highlightColor,
                      enabled: true,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: AppDefaults.margin),
                        itemBuilder: (_, __) => const LoadingAgenda(),
                        itemCount: 3,
                      ),
                    );
                }
              },
            ),
          )
        ],
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
