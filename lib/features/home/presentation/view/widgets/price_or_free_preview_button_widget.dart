import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_styles.dart';
import '../../../../../core/functions/url_launcher.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../data/model/books/book.dart';

class PriceOrFreePreviewButtonWidget extends StatelessWidget {
  const PriceOrFreePreviewButtonWidget({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          children: [
            Expanded(
              child: ButtonWidget(
                text: book.saleability,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                textStyle: Style.textBold_15,
                onPressed: () => urlLauncher(book.buyLink),
              ),
            ),
            const Divider(indent: 1),
            Expanded(
              child: ButtonWidget(
                text: 'Free preview',
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                backgroundColor: kOrangeColor,
                textStyle: Style.textNormal_16,
                onPressed: () => urlLauncher(book.previewLink),
              ),
            ),
          ],
        ),
      );
}
