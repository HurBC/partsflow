import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

class ClientImage extends StatelessWidget {
  final String? profilePictureUrl;
  final double? imageSize;

  const ClientImage({
    super.key,
    this.profilePictureUrl,
    this.imageSize
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: BoxBorder.all(
          color: PartsflowColors.backgroundSemiDark2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Image.network(
          "$profilePictureUrl",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            "assets/images/default_pfp.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
