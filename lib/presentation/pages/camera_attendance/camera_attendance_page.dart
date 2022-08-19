import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';

class CameraAttendancePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final bool frontCamera;

  const CameraAttendancePage({
    Key? key,
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
                        try {
                          await _initializeControllerFuture;

                          final image = await _controller.takePicture();

                          if (!mounted) return;

                          // If the picture was taken, display it on a new screen.
                          // await Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => DisplayPictureScreen(
                          //       // Pass the automatically generated path to
                          //       // the DisplayPictureScreen widget.
                          //       imagePath: image.path,
                          //     ),
                          //   ),
                          // );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        margin:
                            const EdgeInsets.only(bottom: AppDefaults.margin),
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
