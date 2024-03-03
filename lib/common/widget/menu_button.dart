import 'package:flutter/material.dart';

class MenuButtonScreen extends StatelessWidget {
  const MenuButtonScreen({
    super.key,
    required this.onPress,
    this.isMenu = false,
  });

  final VoidCallback onPress;
  final bool isMenu;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(
          top: 50,
          left: 15,
        ),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 3),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          isMenu ? Icons.menu : Icons.close,
        ),
      ),
    );
  }
}
