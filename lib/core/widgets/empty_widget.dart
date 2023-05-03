import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.icon = const SizedBox(),
    required this.text,
  });

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            icon,
            const SizedBox(height: 50),
            Text(
              text,
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
