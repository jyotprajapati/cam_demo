import '../theme/colors.dart';
import 'package:flutter/material.dart';

class CompletionPage extends StatelessWidget {
  const CompletionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'GOOD JOB',
          style: TextStyle(
            fontSize: 40,
            color: ThemeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
