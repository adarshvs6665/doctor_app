import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key? key,
    required this.text,
    required this.text2,
  }) : super(key: key);

  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: textTheme.headline5
                  ?.copyWith(color: Colors.grey, fontSize: 16)),
          Text(
            text2,
          )
        ],
      ),
    );
  }
}
