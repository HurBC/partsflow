import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

class RCard extends StatelessWidget {
  final Widget child;
  final Color? cardBgColor, cardBorderColor;
  final double? borderRadius, width;
  final EdgeInsetsGeometry? padding;

  const RCard({
    super.key,
    required this.child,
    this.cardBgColor,
    this.cardBorderColor,
    this.borderRadius,
    this.padding, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: cardBgColor ?? PartsflowColors.primaryLight2,
        border: BoxBorder.all(
          color: cardBorderColor ?? PartsflowColors.primaryLight3,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.0)),
      ),
      child: Padding(
        padding:
            padding ?? EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 3),
        child: child,
      ),
    );
  }
}
