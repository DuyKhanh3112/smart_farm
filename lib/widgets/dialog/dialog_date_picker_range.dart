import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<Map<String, DateTime?>> dialogDatePickerRange({
  DateTime? start,
  DateTime? end,
}) async {
  Map<String, DateTime?> values = {
    "start": null,
    "end": null,
  };

  List<DateTime> init = [];
  if (start != null) {
    init.add(start);
  }
  if (end != null) {
    init.add(end);
  }

  await Get.bottomSheet(
    Container(
      height: 380,
      color: Get.theme.colorScheme.surface,
      child: Column(
        children: [
          SfDateRangePicker(
            initialSelectedDates: init,
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
              values["start"] =
                  dateRangePickerSelectionChangedArgs.value.startDate;
              values["end"] = dateRangePickerSelectionChangedArgs.value.endDate;
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Đồng ý"),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
  return values;
}
