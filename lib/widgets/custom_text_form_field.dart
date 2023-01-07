import 'package:flutter/material.dart';

class EmailTextArea extends StatefulWidget {
  final String labelText;
  final String hintText;
  TextEditingController controller = TextEditingController();
  final Color fontColor = Colors.black;

  EmailTextArea({
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  State<EmailTextArea> createState() => _EmailTextAreaState();
}

class _EmailTextAreaState extends State<EmailTextArea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (text) {
            if (widget.labelText == 'Password') if (text!.length < 6) {
              return 'Passwords needs to be 6 character long';
            }
          },
          controller: widget.controller,
          obscureText: (widget.labelText == 'Password') ? true : false,
          keyboardType: TextInputType.emailAddress,
          // style: bodyMedium(),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // hintStyle: bodyMedium(),
            labelText: widget.labelText,
            hintText: widget.hintText,
            // labelStyle: labelMedium(),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xFFF1F4F6), width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xFFF1F4F6), width: 2)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xFFF1F4F6), width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xFFF1F4F6), width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xFFF1F4F6), width: 2)),
          )),
    );
  }
}
