import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/cubit/display_camera_attendance_cubit/display_camera_attendance_cubit.dart';
import 'package:siak_mobile/presentation/widget/dialog_late_reason.dart';
import 'package:siak_mobile/presentation/widget/dialog_loading.dart';
import 'package:siak_mobile/presentation/widget/dialog_permission.dart';

class DisplayCameraAttendance extends StatefulWidget {
  final Agenda agenda;
  final Absensi absensi;
  final bool photoReset;

  const DisplayCameraAttendance({
    Key? key,
    required this.agenda,
    required this.absensi,
    required this.photoReset,
  }) : super(key: key);

  @override
  State<DisplayCameraAttendance> createState() =>
      _DisplayCameraAttendanceState();
}

class _DisplayCameraAttendanceState extends State<DisplayCameraAttendance> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (widget.photoReset) {
        context.read<DisplayCameraAttendanceCubit>().dophotoResetTutor(
              widget.absensi.idAgenda,
              File(widget.absensi.foto.toString()),
              widget.absensi.noSiswa,
            );
      } else {
        if (Platform.isAndroid) {
          context
              .read<DisplayCameraAttendanceCubit>()
              .checkPermissionLocation();
        } else {
          context
              .read<DisplayCameraAttendanceCubit>()
              .checkLate(widget.agenda.date, widget.agenda.jamIn);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisplayCameraAttendanceCubit,
        DisplayCameraAttendanceState>(
      listener: (context, state) {
        if (state is DisplayCameraAttendanceCheckLate) {
          Navigator.pop(context);
          if (state.showReason) {
            showDialog(
              context: context,
              builder: (context) => DialogLateReason(onTap: (lateReason) {
                context.read<DisplayCameraAttendanceCubit>().doAttendance(
                      widget.absensi.idAgenda,
                      File(widget.absensi.foto.toString()),
                      widget.absensi.noSiswa,
                      late: state.isLated ? 'X' : '',
                      lateReason: lateReason,
                    );
              }),
            );
          } else {
            context.read<DisplayCameraAttendanceCubit>().doAttendance(
                  widget.absensi.idAgenda,
                  File(widget.absensi.foto.toString()),
                  widget.absensi.noSiswa,
                  late: state.isLated ? 'X' : '',
                );
          }
        }
        if (state is DisplayCameraAttendanceSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is DisplayCameraAttendanceLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const DialogLoading(title: 'Uploading...'),
          );
        }
        if (state is DisplayCameraAttendanceDialogPermission) {
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => DialogPermission(
              onTap: () {
                context
                    .read<DisplayCameraAttendanceCubit>()
                    .permissionLocationRequest();
              },
            ),
          );
        }
        if (state is DisplayCameraAttendancePermissionApproved) {
          Navigator.pop(context);
          context
              .read<DisplayCameraAttendanceCubit>()
              .checkLate(widget.agenda.date, widget.agenda.jamIn);
        }
        if (state is DisplayCameraAttendanceError) {
          Navigator.pop(context);
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
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: AppDefaults.statusBarBlack,
        ),
        body: Center(
          child: Image.file(File(widget.absensi.foto.toString())),
        ),
      ),
    );
  }
}
