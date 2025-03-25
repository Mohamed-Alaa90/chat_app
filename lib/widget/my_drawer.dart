import 'package:chat_app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            //decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                "Welcome!",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ItemDrawer(icon: Icons.home, text: 'Home', onTap: () {}),
          Divider(),
          ItemDrawer(icon: Icons.settings, text: 'Settings', onTap: () {}),
          Divider(),
          ItemDrawer(icon: Icons.logout, text: 'Logout', onTap: () {}),
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
      //  splashColor: Colors.blue.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 10),
            Text(text, style: AppTextStyles.largeTitle22),
          ],
        ),
      ),
    );
  }
}
