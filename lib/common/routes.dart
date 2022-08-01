import 'package:flutter/material.dart';
import 'package:siak_mobile/presentation/pages/sign_in/sign_in_page.dart';

abstract class Routes {
  static const signIn = '/signIn';

  static const entryPoint = '/entryPoint';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('Page not found :('),
              ),
            );
          },
        );
    }
  }
}
