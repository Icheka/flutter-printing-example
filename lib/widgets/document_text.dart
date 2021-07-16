import 'package:flutter/material.dart';

class DocumentText extends StatelessWidget {
  const DocumentText({
    @required this.text,
    this.color,
    this.fontSize,
  });

  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.brown,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.brown.shade100,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 14.0,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
