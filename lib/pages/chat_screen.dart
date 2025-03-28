import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/repository/login_repository.dart';
import 'package:chat_app/widget/chat_bubble.dart';
import 'package:chat_app/widget/my_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });

  final String receiverEmail;
  final String receiverId;
  final TextEditingController _messageController = TextEditingController();
  final LoginRepository _loginRepository = LoginRepository();
  final ChatRepository _chatRepository = ChatRepository();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatRepository.sendMessage(receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(receiverEmail)),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildMessageInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    final currentUser = _loginRepository.getCurrentUser();
    if (currentUser == null) {
      return const Center(child: Text("خطأ: المستخدم غير مسجل الدخول"));
    }
    String senderId = currentUser.uid;

    return StreamBuilder(
      stream: _chatRepository.getMessage(receiverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('حدث خطأ أثناء تحميل الرسائل.'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("لا توجد رسائل بعد."));
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    bool isCurrentUser =
        data?['senderId'] == _loginRepository.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    if (data == null || !data.containsKey("message")) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: alignment,
      child: ChatBubble(
          message: data["message"],
          isCurrentUser: isCurrentUser,
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: _messageController,
              hintText: 'اكتب رسالة...',
              obscureText: false,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
