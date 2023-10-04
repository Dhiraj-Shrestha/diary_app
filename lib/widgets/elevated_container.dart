import 'package:diary_app/constants/fonts.dart';
import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget content;

  const ElevatedContainer(
      {super.key, this.title, this.titleWidget, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget ??
                Text(
                  title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: normalText,
                  ),
                ),
            const SizedBox(height: 8.0),
            content,
          ],
        ),
      ),
    );
  }
}
