// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:farm_ai/objs/conversation.dart';
import 'package:dio/dio.dart';

class ConversationController extends GetxController {
  RxList<Conversation> conversations = <Conversation>[].obs;
  Rx<bool> isLoading = false.obs;
  Rx<Conversation> currentConver =
      Conversation(created_at: DateTime.now(), question: '', answer: '').obs;

  Future<void> sendQuestion() async {
    isLoading.value = true;

    try {
      final url =
          'https://n8n.seateklab.vn/webhook/9ff11ec9-80d1-414a-bf68-668e52729342';
      final requestBody = {
        "user_id": "12345",
        "question": currentConver.value.question,
      };
      var response = await Dio().post(url, data: requestBody);
      var data = await response.data;

      currentConver.value.answer = data['output'];
      conversations.add(currentConver.value); // final url =
      //     'https://n8n.seateklab.vn/webhook/9ff11ec9-80d1-414a-bf68-668e52729342';
      // final options = Options(
      //   responseType: ResponseType.stream,
      //   // headers: {
      //   //   'Authorization': Config.authorization,
      //   //   'Content-Type': 'application/json',
      //   // },
      // );
      // final response = await Dio().post(
      //   url,
      //   options: options,
      //   data: {
      //     'inputs': {},
      //     'response_mode': "streaming",
      //     "user_id": "12345",
      //     "question": question,
      //   },
      // );
      // String asw = '';
      // Conversation oldCoversation =
      //     conversations.firstWhereOrNull((c) => c.created_at == now) ??
      //     Conversation(created_at: now, question: question, answer: 'new');
      // print(oldCoversation.toJson());
      // (response.data as ResponseBody).stream.listen(
      //   (data) {
      //     String str = utf8.decode(data);
      //     print('data: ${str}');
      //     try {
      //       asw += str;
      //       while (asw.contains("output:")) {
      //         int startIndex = asw.indexOf("output:") + 7; // Bỏ qua "data:"
      //         int endIndex = asw.indexOf("\n", startIndex);
      //         if (endIndex == -1) {
      //           // Không có dấu kết thúc, dữ liệu không hoàn chỉnh, dừng vòng lặp
      //           break;
      //         }
      //         String jsonData = asw.substring(startIndex, endIndex).trim();
      //         try {
      //           // conversation[0].answer += jsonDecode(jsonData)['answer'] ?? '';
      //           update();
      //         } catch (e) {
      //           print("Lỗi giải mã JSON: $e");
      //         }
      //         // Loại bỏ phần đã xử lý ra khỏi asw
      //         asw = asw.substring(endIndex + 1);
      //         print("asw1: ${asw}");
      //       }
      //     } catch (e) {
      //       print("Lỗi xử lý dữ liệu: $e");
      //     }
      //   },
      //   onError: (error) {
      //     print('Lỗi: $error');
      //   },
      //   onDone: () {
      //     print('Hoàn tất nhận dữ liệu');
      //     if (asw.isNotEmpty && asw.contains("output:")) {
      //       int startIndex = asw.indexOf("output:") + 7;
      //       String strData = asw.substring(startIndex).trim();
      //       try {
      //         // conversation[0].answer += jsonDecode(jsonData)['answer'] ?? '';
      //         print('strData: ' + strData);
      //         update();
      //       } catch (e) {
      //         print("Lỗi giải mã JSON phần cuối: $e");
      //       }
      //     }
      //   },
      // );
      // Dio dio = Dio();
      // var response = await dio.post<ResponseBody>(
      //   url,
      //   data: requestBody,
      //   options: Options(
      //     responseType: ResponseType.stream, // Nhận dữ liệu dưới dạng Stream
      //   ),
      // );
      // // Đọc dữ liệu từ Stream
      // response.data?.stream.listen(
      //   (List<int> chunk) {
      //     // Chuyển đổi chunk từ bytes sang String
      //     String dataChunk = String.fromCharCodes(chunk);
      //     print("Received Chunk: $dataChunk");
      //   },
      //   onDone: () => print("Stream completed!"), // Khi Stream kết thúc
      //   onError: (e) => print("Error: $e"), // Xử lý lỗi nếu có
      // );
    } catch (e) {
      print("Lỗi khi gửi tin nhắn: ${e.toString()}");
    }
    currentConver =
        Conversation(created_at: DateTime.now(), question: '', answer: '').obs;
    isLoading.value = false;
    // try {
    //         const response = await fetch("https://n8n.seateklab.vn/webhook/9ff11ec9-80d1-414a-bf68-668e52729342", {
    //             method: "POST",
    //             headers: { "Content-Type": "application/json" },
    //             body: JSON.stringify({
    //                 user_id: "12345",
    //                 question: question,
    //             }),
    //         });
    //         const data = await response.json();
    //         setMessages((prev) => [...prev, { sender: "bot", text: data.output }]);
    //     } catch (error) {
    //         console.error("Lỗi khi gửi tin nhắn:", error);
    //     }
  }
}
