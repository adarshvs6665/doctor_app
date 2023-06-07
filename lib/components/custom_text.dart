import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.inputText});

  final String inputText;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        style: textTheme.titleSmall?.copyWith(
          fontSize: 21,
          color: kDarkBlue,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: inputText.toString(),
            style: textTheme.subtitle2?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
