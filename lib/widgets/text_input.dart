import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    Key key,
    @required this.text,
    this.width = 300.0,
    this.height,
    this.hint,
    this.lines = 1,
  }) : super(key: key);

  final TextEditingController text;
  final double width;
  final double height;
  final String hint;
  final int lines;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height ?? widget.lines * 40.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 1.0,
      ),
      child: TextFormField(
        maxLines: widget.lines,
        style: const TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
          fontSize: 14.0,
        ),
        onChanged: (String e) {
          setState(() {
            widget.text.text = e;
          });
        },
        decoration: InputDecoration(
          hintText: widget.hint ?? '',
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          fillColor: Colors.grey.shade300,
        ),
      ),
    );
  }
}
