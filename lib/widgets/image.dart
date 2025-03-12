import 'package:flutter/material.dart';
import 'package:smart_farm/widgets/progress.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  const ImageNetwork({
    super.key,
    required this.url,
    this.height = 40,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error_outline_rounded);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return CircularProgress(
          value:
              loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
        );
      },
    );
  }
}
