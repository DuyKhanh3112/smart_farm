import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_ai/main_page.dart';
import 'package:farm_ai/utils/bindings.dart';
import 'package:farm_ai/views/ai_page.dart';
import 'package:farm_ai/views/image_views/add_image_page.dart';
import 'package:farm_ai/views/image_views/edit_image_detail_screen.dart';
import 'package:farm_ai/views/image_views/image_view_screen.dart';
import 'package:farm_ai/theme.dart';
import 'package:farm_ai/utils/init.dart';
import 'package:farm_ai/views/home_page.dart';
import 'package:farm_ai/views/news_view/news_details_page.dart';
import 'package:farm_ai/views/picture_page.dart';
import 'package:farm_ai/widgets/start_page.dart';

void main() async {
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeApp.themeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/start",
      initialBinding: InitialBindings(),
      getPages: [
        GetPage(
          name: "/start",
          // page: () => const HomeScreen(),
          page: () => const StartPage(),
        ),
        GetPage(
          name: "/picture",
          page: () => const PicturePage(),
          transition: Transition.noTransition,
        ),
        GetPage(name: '/', page: () => const MainPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        // GetPage(name: '/smart_farm', page: () => const GreenCapturePage()),
        GetPage(name: "/add-image", page: () => const AddImageScreen()),
        // GetPage(
        //   name: "/image-management",
        //   page: () => const ImageManagementScreen(),
        // ),
        GetPage(name: "/image-view", page: () => const ImageViewScreen()),
        GetPage(
          name: "/edit-image-detail",
          page: () => const EditImageDetailScreen(),
        ),

        GetPage(name: '/new-detail', page: () => NewsDetailPage()),
        GetPage(name: '/chat-ai', page: () => AiPage()),
      ],
    );
  }
}
