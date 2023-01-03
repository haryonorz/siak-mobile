import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/presentation/cubit/dashboard/dashboard_cubit.dart';
import 'package:siak_mobile/presentation/pages/home/components/home_ads.dart';
import 'package:siak_mobile/presentation/pages/home/components/home_menu.dart';
import 'package:siak_mobile/presentation/widget/header_list.dart';
import 'package:siak_mobile/presentation/widget/item_news.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<DashboardCubit>().fetchData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppDefaults.statusBarRed,
      child: Scaffold(
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const LoadingHome();
            } else if (state is DashboardHasData) {
              return CustomScrollView(
                slivers: [
                  HomeAds(
                    adList: state.dashboard.dataIklan,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  const HomeMenu(),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: HeaderList(
                      title: 'News',
                      isShowMore: state.dashboard.totalNews > 5,
                      onMoreTap: () =>
                          Navigator.pushNamed(context, Routes.newsList),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final news = state.dashboard.dataNews[index];

                        return ItemNews(news: news);
                      },
                      childCount: state.dashboard.totalNews <= 5
                          ? state.dashboard.dataNews.length
                          : 5,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
