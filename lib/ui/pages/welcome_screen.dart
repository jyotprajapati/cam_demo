import 'uploadImage.dart';
import '../theme/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  final cameras = await availableCameras();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadImageScreen(
                          cameras: cameras,
                        ),
                      ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ThemeColors.primary,
                  ),
                  child: Center(
                    child: Text(
                      'Share your meal',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
