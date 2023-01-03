import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/dashboard_menu.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 70.0,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.3,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                menuList[index].goToPage,
              ),
              child: Column(
                children: [
                  FaIcon(
                    menuList[index].icon,
                    size: 28,
                  ),
                  const SizedBox(height: AppDefaults.sSpace),
                  Text(
                    menuList[index].text,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            );
          },
          childCount: menuList.length,
        ),
      ),
    );
  }
}
