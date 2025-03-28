import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/repository/login_repository.dart';
import 'package:chat_app/theme/app_text_theme.dart';
import 'package:chat_app/widget/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  static const String route = 'Home';
  final ChatRepository chatRepository = ChatRepository();
  final LoginRepository loginRepository = LoginRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: AppTextStyles.largeTitle22.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: chatRepository.getUsersStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ أثناء تحميل البيانات',
                style: AppTextStyles.mediumGreyTitle14.copyWith(color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xff79A3D3)));
          }

          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد مستخدمون متاحون',
                style: AppTextStyles.mediumGreyTitle14,
              ),
            );
          }

          final currentUser = loginRepository.getCurrentUser();
          if (currentUser == null) {
            return Center(
              child: Text(
                "خطأ: المستخدم غير مسجل الدخول",
                style: AppTextStyles.mediumGreyTitle14,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.map<Widget>((userData) {
              if (userData == null ||
                  !userData.containsKey("email") ||
                  !userData.containsKey("uid")) {
                return const SizedBox.shrink();
              }

              if (userData['email'] != currentUser.email) {
                return UserTile(
                  text: userData['email'],
                  onTap: () {
                    Get.to(
                      transition: Transition.leftToRightWithFade,
                      ChatScreen(
                        receiverId: userData['uid'],
                        receiverEmail: userData['email'],
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            }).toList(),
          );
        },
      ),
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
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(Icons.person, size: 30, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 20),
            Text(
              text,
              style: AppTextStyles.mediumTitleBlue14,
            ),
          ],
        ),
      ),
    );
  }
}
