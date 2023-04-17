import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  UserTextField({Key? key, this.title, this.textEditingController})
      : super(key: key);
  String? title;
  TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title ?? ''),
        TextField(
          controller: textEditingController,
        ),
      ],
    );
  }
}
