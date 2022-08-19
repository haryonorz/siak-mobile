import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/presentation/cubit/action_agenda/action_agenda_cubit.dart';

class CameraAttendancePage extends StatefulWidget {
  final Absensi absensi;
  final List<CameraDescription> cameras;
  final bool frontCamera;

  const CameraAttendancePage({
    Key? key,
    required this.absensi,
    required this.cameras,
    this.frontCamera = true,
  }) : super(key: key);

  @override
  State<CameraAttendancePage> createState() => _CameraAttendancePageState();
}

class _CameraAttendancePageState extends State<CameraAttendancePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.frontCamera ? widget.cameras[1] : widget.cameras[0],
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionAgendaCubit, ActionAgendaState>(
      listener: (context, state) {
        if (state is ActionAgendaSuccess) {
          Navigator.pop(context);
        }
        if (state is ActionAgendaError) {
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
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Center(
                    child: CameraPreview(_controller),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          await _initializeControllerFuture;

                          final image = await _controller.takePicture();

                          if (!mounted) return;

                          var now = DateTime.now();

                          context.read<ActionAgendaCubit>().doAttendance(
                                widget.absensi.idAgenda,
                                File(image.path),
                                widget.absensi.noSiswa,
                                DateFormat('yyyy-MM-dd').format(now),
                                DateFormat('HH:mm').format(now),
                                '-6.2852617',
                                '107.0945438',
                              );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.only(bottom: 28),
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
