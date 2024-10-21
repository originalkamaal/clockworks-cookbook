import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final String? hintText;
  final bool isTextArea;
  const KTextField({super.key, this.hintText, this.isTextArea = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      height: isTextArea ? 150 : 60,
      child: TextField(
        maxLines: isTextArea ? null : 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
