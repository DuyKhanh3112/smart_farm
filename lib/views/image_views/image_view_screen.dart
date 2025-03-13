import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/utils/config.dart';
import 'package:smart_farm/widgets/progress.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final image = Get.arguments['image'];
    final url = Get.arguments['url'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Xem hình ảnh',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_appbar.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _Body(image: image, url: url),
    );
  }
}

class _Body extends StatelessWidget {
  final File? image;
  final String? url;
  const _Body({required this.image, required this.url});

  @override
  Widget build(BuildContext context) {
    return image == null
        ? url == null
            ? const SizedBox()
            : PhotoView(
              imageProvider: NetworkImage("${Config.urlAPI}${url!}"),
              loadingBuilder: (context, event) {
                double value =
                    ((event?.cumulativeBytesLoaded ?? 1) /
                        (event?.expectedTotalBytes ?? 1));
                return CircularProgress(strokeWidth: 1, size: 30, value: value);
              },
            )
        : PhotoView(imageProvider: FileImage(image!));
  }
}

// dialogShowImage(File image) {
//   Get.dialog(AlertDialog(
//     content: Container(
//       margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
//       child: ,
//     ),
//     actions: [
//       TextButton(
//         onPressed: () => Get.back(),
//         child: const Text("OK"),
//       ),
//     ],
//   ));
// }
