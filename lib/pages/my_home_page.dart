import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/widget/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  static const String route = 'Home';
  final ChatRepository chatRepository = ChatRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(centerTitle: true, title: const Text('Home')),
      body: StreamBuilder(
        stream: chatRepository.getUsersStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا يوجد مستخدمون متاحون'));
          }

          return ListView(
            children:
                snapshot.data!
                    .map<Widget>(
                      (userData) => _buildUserListItem(userData, context),
                    )
                    .toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    return UserTile(
      text: userData['email'],
      onTap: () {
        Get.to(ChatScreen(receiverEmail: userData['email']));
      },
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Icon(Icons.person, size: 30),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
