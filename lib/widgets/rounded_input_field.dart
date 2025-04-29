import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/widgets/text_field_container.dart';
import 'package:flutter/material.dart';


class RoundedInputField extends StatelessWidget {
  const RoundedInputField({super.key, this.hintText, this.icon = Icons.person, required this.controller});
  final String? hintText;
  final IconData icon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'OpenSans'),
            border: InputBorder.none),
      ),
    );
  }
}