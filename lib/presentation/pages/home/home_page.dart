import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siak_mobile/common/app/app_colors.dart';
import 'package:siak_mobile/common/app/app_defaults.dart';
import 'package:siak_mobile/common/app/app_images.dart';
import 'package:siak_mobile/presentation/cubit/auth/authentication_cubit.dart';
import 'package:siak_mobile/presentation/cubit/sign_out/sign_out_cubit.dart';
import 'package:siak_mobile/presentation/pages/home/components/home_drawer.dart';
import 'package:siak_mobile/presentation/pages/home/components/home_search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.bell,
                size: 20,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          ],
        ),
        drawer: const HomeDrawer(),
        body: Column(
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
                        child: const HomeSearchField(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Center(
              child: Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}
