import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siak_mobile/domain/usecases/do_attendance.dart';
import 'package:siak_mobile/domain/usecases/do_photo_reset_tutor.dart';

part 'display_camera_attendance_state.dart';

class DisplayCameraAttendanceCubit extends Cubit<DisplayCameraAttendanceState> {
  final DoAttendance _doAttendance;
  final DoPhotoResetTutor _doPhotoResetTutor;

  DisplayCameraAttendanceCubit(
    this._doAttendance,
    this._doPhotoResetTutor,
  ) : super(DisplayCameraAttendanceInitial());

  void checkLate(String dateAgenda, String startTime) {
    emit(DisplayCameraAttendanceLoading());

    var now = DateTime.now();
    var agendaTime = DateTime.parse('$dateAgenda $startTime');

    var differenceTime = now.difference(agendaTime).inMinutes;

    bool isLated = false;
    bool showReason = false;

    if (differenceTime > 0 && differenceTime <= 30) {
      isLated = true;
    } else if (differenceTime > 30 && differenceTime <= 60) {
      isLated = true;
      showReason = true;
    }

    emit(DisplayCameraAttendanceCheckLate(isLated, showReason));
  }

  void doAttendance(
    String idAgenda,
    File photo,
    String noStudent, {
    String late = '',
    String lateReason = '',
  }) async {
    emit(DisplayCameraAttendanceLoading());

    var now = DateTime.now();

    // final compressImage = await compressAndGetFile(photo);
    // print(compressImage?.path);

    final position = await _determinePosition();

    final result = await _doAttendance.execute(
      idAgenda,
      photo,
      noStudent,
      DateFormat('yyyy-MM-dd').format(now),
      DateFormat('HH:mm').format(now),
      position.latitude.toString(),
      position.latitude.toString(),
      late,
      lateReason,
    );

    result.fold(
      (failure) {
        emit(DisplayCameraAttendanceError(failure.message));
      },
      (_) {
        emit(DisplayCameraAttendanceSuccess());
      },
    );
  }

  void dophotoResetTutor(
    String idAgenda,
    File photo,
    String noStudent,
  ) async {
    emit(DisplayCameraAttendanceLoading());

    var now = DateTime.now();

    // final compressImage = await compressAndGetFile(photo);
    // print(compressImage?.path);

    final result = await _doPhotoResetTutor.execute(
      idAgenda,
      photo,
      noStudent,
      DateFormat('yyyy-MM-dd').format(now),
      DateFormat('HH:mm').format(now),
    );

    result.fold(
      (failure) {
        emit(DisplayCameraAttendanceError(failure.message));
      },
      (_) {
        emit(DisplayCameraAttendanceSuccess());
      },
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<File?> compressAndGetFile(File file) async {
  String? dir = await getStorageDirectory();

  var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, dir ?? '',
      quality: 80, format: CompressFormat.jpeg);

  return result;
}

Future<String?> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())?.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
