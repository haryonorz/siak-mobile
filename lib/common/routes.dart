import 'package:flutter/material.dart';
import 'package:siak_mobile/presentation/pages/add_situation_class/add_situation_class_page.dart';
import 'package:siak_mobile/presentation/pages/agenda_history/agenda_history_page.dart';
import 'package:siak_mobile/presentation/pages/attandance_list/attendance_list_page.dart';
import 'package:siak_mobile/presentation/pages/change_password/change_password_page.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/detail_agenda_page.dart';
import 'package:siak_mobile/presentation/pages/photo_preview/photo_preview_page.dart';
import 'package:siak_mobile/presentation/pages/profile/profile_page.dart';
import 'package:siak_mobile/presentation/pages/request_join/request_join_page.dart';
import 'package:siak_mobile/presentation/pages/sign_in/sign_in_page.dart';
import 'package:siak_mobile/presentation/pages/situation_class/situation_class_page.dart';

abstract class Routes {
  static const signIn = '/signIn';

  static const home = '/home';
  static const detailAgenda = '/detailAgenda';
  static const requestJoin = '/requestJoin';
  static const attendanceList = '/attendanceList';
  static const situationClass = '/situationClass';
  static const addSituationClass = '/addSituationClass';

  static const photoPreview = '/photoPreview';

  static const agendaHistory = '/agendaHistory';

  static const profile = '/profile';
  static const changePassword = '/changePassword';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case Routes.detailAgenda:
        return MaterialPageRoute(
          builder: (_) => DetailAgendaPage(
            idAgenda: args as String,
          ),
        );
      case Routes.requestJoin:
        return MaterialPageRoute(
            builder: (_) => RequestJoinPage(idAgenda: args as String));
      case Routes.attendanceList:
        return MaterialPageRoute(
            builder: (_) => AttendanceListPage(idAgenda: args as String));
      case Routes.situationClass:
        return MaterialPageRoute(
            builder: (_) => SituationClassPage(idAgenda: args as String));
      case Routes.addSituationClass:
        return MaterialPageRoute(
            builder: (_) => AddSituationClassPage(idAgenda: args as String));
      case Routes.photoPreview:
        return MaterialPageRoute(
            builder: (_) => PhotoPreviewPage(url: args as String?));
      case Routes.agendaHistory:
        return MaterialPageRoute(builder: (_) => const AgendaHistoryPage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
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
