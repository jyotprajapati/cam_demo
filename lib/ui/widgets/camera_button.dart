import '../theme/colors.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({Key? key, required this.onPressed}) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeColors.primary,
        ),
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
