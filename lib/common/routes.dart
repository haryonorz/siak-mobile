import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/entities/arg_attandance.dart';
import 'package:siak_mobile/domain/entities/arg_attendance_list.dart';
import 'package:siak_mobile/domain/entities/arg_selected_student.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/presentation/pages/add_activity_class/add_activity_class_page.dart';
import 'package:siak_mobile/presentation/pages/add_situation_class/add_situation_class_page.dart';
import 'package:siak_mobile/presentation/pages/agenda_history/agenda_history_page.dart';
import 'package:siak_mobile/presentation/pages/all_selected_student/all_selected_student_page.dart';
import 'package:siak_mobile/presentation/pages/attandance_list/attendance_list_page.dart';
import 'package:siak_mobile/presentation/pages/camera_attendance/camera_attendance_page.dart';
import 'package:siak_mobile/presentation/pages/change_password/change_password_page.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/detail_agenda_page.dart';
import 'package:siak_mobile/presentation/pages/edit_profile/edit_profile.dart';
import 'package:siak_mobile/presentation/pages/photo_preview/photo_preview_page.dart';
import 'package:siak_mobile/presentation/pages/profile/profile_page.dart';
import 'package:siak_mobile/presentation/pages/request_join/request_join_page.dart';
import 'package:siak_mobile/presentation/pages/sign_in/sign_in_page.dart';
import 'package:siak_mobile/presentation/pages/situation_class/situation_class_page.dart';

abstract class Routes {
  static const signIn = '/signIn';

  static const home = '/home';
  static const detailAgenda = '/detailAgenda';
  static const addActivityClass = '/dailyActivity';
  static const requestJoin = '/requestJoin';
  static const attendanceList = '/attendanceList';
  static const situationClass = '/situationClass';
  static const addSituationClass = '/addSituationClass';
  static const listSelectedStudent = '/listSelectedStudent';

  static const cameraAttendance = '/cameraAttendance';

  static const photoPreview = '/photoPreview';

  static const agendaHistory = '/agendaHistory';

  static const profile = '/profile';
  static const editProfile = '/editProfile';
  static const changePassword = '/changePassword';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
    List<CameraDescription> cameras,
  ) {
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
      case Routes.addActivityClass:
        return MaterialPageRoute(
            builder: (_) => AddActivityClassPage(agenda: args as Agenda));
      case Routes.requestJoin:
        return MaterialPageRoute(
            builder: (_) => RequestJoinPage(idAgenda: args as String));
      case Routes.attendanceList:
        final data = args as ArgAttendanceList;
        return MaterialPageRoute(
            builder: (_) => AttendanceListPage(
                  idAgenda: data.idAgenda,
                  absensi: data.absensi,
                ));
      case Routes.situationClass:
        return MaterialPageRoute(
            builder: (_) => SituationClassPage(agenda: args as Agenda));
      case Routes.addSituationClass:
        return MaterialPageRoute(
            builder: (_) => AddSituationClassPage(idAgenda: args as String));
      case Routes.listSelectedStudent:
        final data = args as ArgSelectedStudent;
        return MaterialPageRoute(
            builder: (_) => AllSelectedStudentPage(
                  idAgenda: data.idAgenda,
                  selectedNoStudent: data.nosiswa,
                ));
      case Routes.photoPreview:
        return MaterialPageRoute(
            builder: (_) => PhotoPreviewPage(url: args as String?));
      case Routes.cameraAttendance:
        final data = args as ArgCameraAttendance;
        return MaterialPageRoute(
            builder: (_) => CameraAttendancePage(
                  cameras: cameras,
                  absensi: data.absensi,
                  frontCamera: data.userType == 'turor',
                ));
      case Routes.agendaHistory:
        return MaterialPageRoute(builder: (_) => const AgendaHistoryPage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => EditProfilePage(
            user: args as User,
          ),
        );
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
