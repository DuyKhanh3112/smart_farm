import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_ai/objs/conversation.dart';
import 'package:farm_ai/objs/image_detect.dart';
import 'package:farm_ai/views/ai_page.dart';
import 'package:farm_ai/views/data_page.dart';
import 'package:farm_ai/views/home_page.dart';
import 'package:farm_ai/views/newspaper_page.dart';
import 'package:farm_ai/views/picture_page.dart';
import 'package:image_picker/image_picker.dart';

class MainController extends GetxController {
  // loading state variants
  RxBool detecting = false.obs;
  // data variants
  Rx<XFile> image = XFile('').obs;
  RxList<Map<String, dynamic>> result = <Map<String, dynamic>>[].obs;
  RxList<ImageDetect> listImageDetect = <ImageDetect>[].obs;
  RxBool clickDetect = false.obs;

  RxBool isLoading = false.obs;

  List<Widget> pages = [
    const HomePage(),
    const DataPage(),
    const PicturePage(),
    const NewsPaperPage(),
    const AiPage(),
  ];
  List<String> titles = [
    'Trang chủ',
    'Dữ liệu',
    'Chuẩn đoán',
    'Tin tức',
    'Hỏi AI',
  ];
  RxInt numPage = 0.obs;

  RxList<Conversation> conversations = <Conversation>[].obs;
}
