import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/objs/image.dart';
import 'package:smart_farm/objs/plant.dart';
import 'package:smart_farm/controller/green_capture/edit_image_detail_controller.dart';
import 'package:smart_farm/widgets/progress.dart';

class EditImageDetailScreen extends StatelessWidget {
  const EditImageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ImageDetail imageDetail = Get.arguments['image-detail'];
    EditImageDetailController editImageDetailController = Get.put(
      EditImageDetailController(imageDetail: imageDetail),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chỉnh sửa thông tin ảnh',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
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
      body: const _Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await editImageDetailController.save(),
        child: const Icon(Icons.save_rounded),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    EditImageDetailController editImageDetailController =
        Get.find<EditImageDetailController>();
    return Obx(() {
      bool loading = editImageDetailController.loading.value;
      return loading
          ? const CircularProgress()
          : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: editImageDetailController.formKey,
                child: const Column(
                  children: [
                    _SelectPlant(),
                    _SelectPlantType(),
                    _SelectPlantCondition(),
                    _EditDescription(),
                  ],
                ),
              ),
            ),
          );
    });
  }
}

class _SelectPlant extends StatelessWidget {
  const _SelectPlant();

  @override
  Widget build(BuildContext context) {
    EditImageDetailController editImageDetailController =
        Get.find<EditImageDetailController>();
    List<Plant> items = editImageDetailController.plantViews;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: editImageDetailController.plantSelected.value,
        items:
            items
                .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                .toList(),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Giống"),
        ),
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null) {
            return "Không được để trống";
          }
          return null;
        },
        onChanged:
            (value) => editImageDetailController.plantSelected.value = value,
      ),
    );
  }
}

class _SelectPlantType extends StatelessWidget {
  const _SelectPlantType();

  @override
  Widget build(BuildContext context) {
    EditImageDetailController editImageDetailController =
        Get.find<EditImageDetailController>();
    List<PlantType> items = editImageDetailController.plantTypeViews;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: editImageDetailController.plantTypeSelected.value,
        items:
            items
                .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                .toList(),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Loại hình ảnh"),
        ),
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null) {
            return "Không được để trống";
          }
          return null;
        },
        onChanged:
            (value) =>
                editImageDetailController.plantTypeSelected.value = value,
      ),
    );
  }
}

class _SelectPlantCondition extends StatelessWidget {
  const _SelectPlantCondition();

  @override
  Widget build(BuildContext context) {
    EditImageDetailController editImageDetailController =
        Get.find<EditImageDetailController>();
    List<PlantCondition> items = editImageDetailController.plantConditionViews;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: editImageDetailController.plantConditionSelected.value,
        items:
            items
                .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                .toList(),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Sinh trưởng"),
        ),
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null) {
            return "Không được để trống";
          }
          return null;
        },
        onChanged:
            (value) =>
                editImageDetailController.plantConditionSelected.value = value,
      ),
    );
  }
}

class _EditDescription extends StatelessWidget {
  const _EditDescription();

  @override
  Widget build(BuildContext context) {
    EditImageDetailController editImageDetailController =
        Get.find<EditImageDetailController>();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: editImageDetailController.controllerDescription,
        keyboardType: TextInputType.multiline,
        minLines: 10,
        maxLines: 15,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Mô tả hình ảnh (nếu có)"),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
