import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/bloc/all_news/all_news_bloc.dart';
import 'package:siak_mobile/presentation/widget/bottom_loader.dart';
import 'package:siak_mobile/presentation/widget/item_news.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_item_news.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AllNewsBloc>().add(const OnFetchData()));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<AllNewsBloc>().add(const OnFetchData());
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
        title: const Text('Daftar News'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: BlocBuilder<AllNewsBloc, AllNewsState>(
        builder: (context, state) {
          switch (state.status) {
            case AllNewsStatus.failure:
              return ViewError(
                message: state.errorMessage,
                showRefresh: true,
                onRefresh: () {
                  context.read<AllNewsBloc>().add(const OnFetchData());
                },
              );
            case AllNewsStatus.success:
              if (state.news.isEmpty) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: ViewEmpty(
                    title: 'News tidak ditemukan!',
                    description: 'Tidak ada berita terbaru.',
                    showRefresh: true,
                    onRefresh: () {
                      context
                          .read<AllNewsBloc>()
                          .add(const OnFetchData(isRefresh: true));
                    },
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<AllNewsBloc>()
                      .add(const OnFetchData(isRefresh: true));
                },
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.news.length
                        ? const BottomLoader()
                        : Container(
                            margin: EdgeInsets.only(
                                top: index == 0 ? AppDefaults.margin : 0,
                                bottom: index == state.news.length - 1
                                    ? AppDefaults.margin
                                    : 10),
                            child: ItemNews(news: state.news[index]),
                          );
                  },
                  itemCount: state.hasReachedMax
                      ? state.news.length
                      : state.news.length + 1,
                  controller: _scrollController,
                ),
              );
            case AllNewsStatus.initial:
              return Shimmer.fromColors(
                baseColor: AppColors.baseColor,
                highlightColor: AppColors.highlightColor,
                enabled: true,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: AppDefaults.margin),
                  itemBuilder: (_, __) => const LoadingItemNews(),
                  itemCount: 5,
                ),
              );
          }
        },
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
