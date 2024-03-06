import 'package:flutter/material.dart';

class SideMenuTile extends StatefulWidget {
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
  State<SideMenuTile> createState() => _SideMenuTileState();
}

class _SideMenuTileState extends State<SideMenuTile> {
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
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: widget.isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6792FF),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            ListTile(
              onTap: widget.onPress,
              leading: SizedBox(
                height: 35,
                width: 35,
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                ),
              ),
              title: Text(
                widget.title,
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
