import 'package:chat_app/cubit/auth_cubit/signout/signout_cubit.dart';
import 'package:chat_app/pages/setting_screen.dart';
import 'package:chat_app/theme/app_text_theme.dart';
import 'package:chat_app/widget/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey, // إضافة خلفية واضحة
            ),
            child: Center(
              child: Text(
                "Welcome!",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ItemDrawer(icon: Icons.home, text: 'Home', onTap: () {}),
          const CustomDivider(),
          ItemDrawer(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              Navigator.pop(context);

              Get.to(
                transition: Transition.leftToRightWithFade,
                SettingScreen(),
              );
            },
          ),
          const CustomDivider(),
          BlocListener<SignoutCubit, SignoutState>(
            listener: (context, state) {
              if (state is SignOutError) {
                showErrorDialog(context, state.errorMessage);
              }
            },
            child: ItemDrawer(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                context.read<SignoutCubit>().signOut();
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue.withOpacity(0.2), // تحسين التفاعل
      borderRadius: BorderRadius.circular(10), // تحسين التصميم
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.blueGrey), // تحسين الأيقونة
            const SizedBox(width: 12),
            Text(text, style: AppTextStyles.largeTitle22),
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.2,
      color: Colors.grey,
      indent: 20,
      endIndent: 20,
    );
  }
}
