import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/arg_display_camera_attandance.dart';

class CameraAttendancePage extends StatefulWidget {
  final Absensi absensi;
  final List<CameraDescription> cameras;
  final String userType;
  final bool photoReset;

  const CameraAttendancePage({
    Key? key,
    required this.absensi,
    required this.cameras,
    required this.userType,
    required this.photoReset,
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
      widget.userType == 'tutor' ? widget.cameras[0] : widget.cameras[1],
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
    return Scaffold(
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

                        final resultAbsensi =
                            widget.absensi.copyWith(foto: image.path);

                        Navigator.pushReplacementNamed(
                          context,
                          Routes.displayCameraAttendance,
                          arguments: ArgDisplayCameraAttendance(
                            absensi: resultAbsensi,
                            photoReset: widget.photoReset,
                          ),
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
    );
  }
}
