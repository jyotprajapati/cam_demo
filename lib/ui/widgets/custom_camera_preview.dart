import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CustomCameraPreview extends StatelessWidget {
  const CustomCameraPreview({
    Key? key,
    required this.capturedImages,
    required Future<void> initializeControllerFuture,
    required CameraController cameraController,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _cameraController = cameraController,
        super(key: key);

  final File? capturedImages;
  final Future<void> _initializeControllerFuture;
  final CameraController _cameraController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/corners.png",
        ),
        capturedImages == null
            ? ClipOval(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CameraPreview(_cameraController);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
              )
            : CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(capturedImages!),
              ),
      ],
    );
  }
}
