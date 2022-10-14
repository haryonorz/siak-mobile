import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/utils.dart';
import 'package:siak_mobile/presentation/bloc/all_agenda/all_agenda_bloc.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:siak_mobile/presentation/pages/home/components/home_drawer.dart';
import 'package:siak_mobile/presentation/widget/agenda_card.dart';
import 'package:siak_mobile/presentation/widget/bottom_loader.dart';
import 'package:siak_mobile/presentation/widget/form/search_form_field.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final searchController = TextEditingController();
  final _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const FaIcon(
              FontAwesomeIcons.bars,
              size: 20,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: AppColors.backgroundRed,
          systemOverlayStyle: AppDefaults.statusBarRed,
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const FaIcon(
            //     FontAwesomeIcons.bell,
            //     size: 20,
            //   ),
            //   splashColor: Colors.transparent,
            //   highlightColor: Colors.transparent,
            // )
          ],
        ),
        drawer: const HomeDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 48),
              child: Stack(
                children: [
                  Image.asset(
                    AppImages.backgroundHomeTop,
                    width: double.infinity,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: AppDefaults.margin,
                          right: AppDefaults.margin * 6,
                        ),
                        child: SearchFormField(
                          hintText: 'Agenda Hari Ini',
                          controller: searchController,
                          onChanged: (query) {
                            context.read<AllAgendaBloc>().add(OnQueryChanged(
                                  query,
                                  isRefresh: true,
                                ));
                          },
                        ),
                      ),
                    ),
                  )
                ],
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
                      return const Center(child: CircularProgressIndicator());
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
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
