import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_ai/objs/plant.dart';
import 'package:farm_ai/controller/green_capture/home_controller.dart';
import 'package:farm_ai/theme.dart';
import 'package:farm_ai/widgets/dialog/dialog_date_picker_range.dart';
import 'package:intl/intl.dart';

dialogFilterImages() async {
  HomeController homeController = Get.find<HomeController>();
  return Get.bottomSheet(
    Container(
      color: Get.theme.colorScheme.surface,
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Lọc hình ảnh",
                    style: ThemeApp.textStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async => await homeController.deleteFilter(),
                    child: const Text("Xóa"),
                  ),
                  TextButton(
                    onPressed: () async => await homeController.filter(),
                    child: const Text("Lọc"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Column(
                    children: [
                      _SelectDate(),
                      _SelectPlant(),
                      _SelectPlantType(),
                      _SelectPlantCondition(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: false,
  );
}

class _SelectDate extends StatelessWidget {
  const _SelectDate();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Column(
      children: [
        Obx(() {
          DateTime? start = homeController.dateStartFilter.value;
          DateTime? end = homeController.dateEndFilter.value;
          String date = "Ngày";
          if (start != null) {
            date += ": ${DateFormat("dd/MM/yyyy").format(start)}";
          }
          if (end != null) {
            date += " - ${DateFormat("dd/MM/yyyy").format(end)}";
          }
          return ListTile(
            title: Text(date),
            subtitle: const Text("Nhấn để chọn ngày"),
            onTap: () async {
              Map<String, DateTime?> data = await dialogDatePickerRange();
              homeController.dateStartFilter.value = data["start"];
              homeController.dateEndFilter.value = data["end"];
            },
          );
        }),
      ],
    );
  }
}

class _SelectPlant extends StatelessWidget {
  const _SelectPlant();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    List<Plant> items = homeController.plantViews;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: homeController.plantSelectedFilter.value,
        items: [
          const DropdownMenuItem(value: null, child: Text("Không")),
          ...items.map((e) => DropdownMenuItem(value: e, child: Text(e.name))),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Giống"),
        ),
        onChanged: (value) => homeController.plantSelectedFilter.value = value,
      ),
    );
  }
}

class _SelectPlantType extends StatelessWidget {
  const _SelectPlantType();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    List<PlantType> items = homeController.plantTypeViews;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: homeController.plantTypeSelectedFilter.value,
        items: [
          const DropdownMenuItem(value: null, child: Text("Không")),
          ...items.map((e) => DropdownMenuItem(value: e, child: Text(e.name))),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Loại hình ảnh"),
        ),
        onChanged:
            (value) => homeController.plantTypeSelectedFilter.value = value,
      ),
    );
  }
}

class _SelectPlantCondition extends StatelessWidget {
  const _SelectPlantCondition();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    List<PlantCondition> items = homeController.plantConditionViews;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: homeController.plantConditionSelectedFilter.value,
        items: [
          const DropdownMenuItem(value: null, child: Text("Không")),
          ...items.map((e) => DropdownMenuItem(value: e, child: Text(e.name))),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Sinh trưởng"),
        ),
        onChanged:
            (value) =>
                homeController.plantConditionSelectedFilter.value = value,
      ),
    );
  }
}
