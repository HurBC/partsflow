import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

class Tag extends StatelessWidget {
  final String title;
  Color? color;

  Tag({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color ?? PartsflowColors.background,
        border: Border.all(color: PartsflowColors.secondaryDark),
      ),
      child: Text(
        title,
        style: TextStyle(color: PartsflowColors.secondaryDark),
      ),
    );
  }
}
