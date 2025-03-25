import 'package:flutter/material.dart';

class FilledButtomEdit extends StatelessWidget {
  final String text;
  final Color color, color1;
  final double size;
  final FocusNode? focusNodes;
  final void Function()? onClick;
  const FilledButtomEdit(
      {super.key,
      required this.text,
      required this.color,
      required this.size,
      required this.color1,
      required this.onClick,
      this.focusNodes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        focusNode: focusNodes,
        onPressed: onClick,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(330, 50),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color1,
              fontSize: size,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
