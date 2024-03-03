import 'package:flutter/material.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.title,
    this.onPress,
    required this.icon,
    this.isActive = false,
  });

  final String title;
  final VoidCallback? onPress;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6792FF),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            ListTile(
              onTap: onPress,
              leading: SizedBox(
                height: 35,
                width: 35,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
