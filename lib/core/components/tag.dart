import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

class Tag extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? padding;
  final double? borderRadius;

  const Tag({
    super.key,
    required this.title,
    this.color,
    this.borderColor,
    this.textStyle,
    this.padding,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 2),
        color: color ?? PartsflowColors.background,
        border: Border.all(color: borderColor ?? PartsflowColors.secondaryDark),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? 3),
        child: Text(
          title,
          style: textStyle ?? TextStyle(color: PartsflowColors.secondaryDark),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
