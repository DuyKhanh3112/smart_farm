// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/conversation_controller.dart';
import 'package:smart_farm/objs/conversation.dart';
import 'package:smart_farm/widgets/progress.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConversationController());
    // MainController mainController = Get.find<MainController>();
    ConversationController conversationController =
        Get.find<ConversationController>();
    Rx<TextEditingController> questionController = TextEditingController().obs;
    RxString questionText = ''.obs;

    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: Get.width * 0.03,
                  bottom: Get.width * 0.02,
                  left: Get.width * 0.02,
                  right: Get.width * 0.02,
                ),
                child: TextField(
                  controller: questionController.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Nhập câu hỏi',
                    suffixIcon:
                        conversationController.isLoading.value
                            ? CircularProgress()
                            : InkWell(
                              child: Icon(
                                Icons.send,
                                color:
                                    questionText.value.isEmpty
                                        ? Colors.grey
                                        : Colors.green,
                              ),
                              onTap: () async {
                                if (questionText.value.isNotEmpty) {
                                  // questionController.value.
                                  FocusScope.of(context).unfocus();
                                  conversationController.currentConver =
                                      Conversation(
                                        created_at: DateTime.now(),
                                        question: questionText.value,
                                        answer: 'Đang xử lý...',
                                      ).obs;
                                  questionText.value = '';
                                  questionController.value.text = '';
                                  conversationController.sendQuestion();
                                }
                              },
                            ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onChanged: (value) {
                    questionText.value = value;
                    questionController.value.text = value;
                  },
                ),
              ),
              conversationController.conversations.value.isEmpty &&
                      conversationController.currentConver.value.question == ''
                  ? ConversationEmpty()
                  : Expanded(
                    child: ListView(
                      children: [
                        for (var conversation
                            in conversationController.conversations)
                          ItemConversation(conversation: conversation),
                        conversationController.currentConver.value.question ==
                                ''
                            ? SizedBox()
                            : ItemConversation(
                              conversation:
                                  conversationController.currentConver.value,
                            ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      );
    });
  }
}

class ItemConversation extends StatelessWidget {
  const ItemConversation({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Get.width * 0.75,
                  alignment: Alignment.centerRight,
                  child: Text(
                    conversation.question,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.account_circle),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.smart_toy_sharp),
                ),
                Container(
                  width: Get.width * 0.75,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    conversation.answer,
                    textAlign: TextAlign.left,
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationEmpty extends StatelessWidget {
  const ConversationEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.75,
      padding: EdgeInsets.only(bottom: Get.height * 0.1),
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/images/logo_ai.png'),
            width: Get.width * 0.2,
          ),
          Text(
            'Bạn cần tôi giúp gì?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(
            'Trợ lý ảo AI giúp bạn giải đáp các thắc mắc về nông nghiệp',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
