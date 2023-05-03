import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'button_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.title = 'Error',
    this.subTitle = 'Something Went Wrong !!',
    this.onPressed,
    this.image = Assets.error404,
  });

  final String title, subTitle, image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 4),
              Text(title, style: Style.textNormal_30),
              const SizedBox(height: 20),
              Text(
                subTitle,
                style: Style.textNormal_16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ButtonWidget(
                  text: 'Retry'.toUpperCase(),
                  textStyle: Style.textBold_20,
                  backgroundColor: kOrangeColor,
                  onPressed: onPressed,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
