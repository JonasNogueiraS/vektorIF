import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class CustomBackButtom extends StatelessWidget {
  final Color? color;

  const CustomBackButtom({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(0xffCADFE8),
      radius: 20,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: color ?? AppTheme.colorBlackText,
          size: 20,
        ),
        onPressed: () {
            Navigator.pop(context);
        },
        // onTap ?? () {
        //   Navigator.pop(context);
        // },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
