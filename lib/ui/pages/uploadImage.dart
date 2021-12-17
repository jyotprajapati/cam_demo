import 'dart:io';

import 'package:alemeno/ui/widgets/custom_camera_preview.dart';

import '../../services/firebasestorage_service.dart';
import 'completion_page.dart';
import 'upload_fail.dart';
import '../theme/colors.dart';
import '../widgets/camera_button.dart';
import '../widgets/confirm_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class UploadImageScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const UploadImageScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  void initState() {
    initializeCamera(selectedCamera); //Initially selectedCamera = 0
    super.initState();
  }

  late CameraController _cameraController; //To control the camera
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;
  File? capturedImages = null;

  initializeCamera(int cameraIndex) async {
    _cameraController = CameraController(
      widget.cameras[cameraIndex],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _cameraController.initialize();
    _cameraController.setFlashMode(FlashMode.off);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              if (capturedImages == null) {
                Navigator.pop(context);
              } else {
                setState(() {
                  capturedImages = null;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColors.primary,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Image.asset(
                "assets/images/char.png",
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/fork.png"),
                      ),
                      Center(
                        child: CustomCameraPreview(
                            capturedImages: capturedImages,
                            initializeControllerFuture:
                                _initializeControllerFuture,
                            cameraController: _cameraController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/Spoon.png"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      capturedImages == null
                          ? "Click your meal"
                          : "Will you eat this?",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: capturedImages == null
                        ? CameraButton(
                            onPressed: () async {
                              await _initializeControllerFuture;

                              var xFile = await _cameraController.takePicture();
                              setState(() {
                                capturedImages = (File(xFile.path));
                              });
                            },
                          )
                        : ConfirmButton(
                            onPressed: () async {
                              try {
                                await FirebaseStorageService()
                                    .upload(file: capturedImages!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CompletionPage(),
                                    ));
                              } catch (e) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UploadFailPage(),
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
