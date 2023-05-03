import 'package:flutter/material.dart';

import 'colors.dart';
import 'strings.dart';

abstract class Style {
  const Style();

  /// Text Size 14
  static const textNormal_14 = TextStyle(color: kSecondaryColor);
  static const textMedium_14 = TextStyle(
    color: kSecondaryColor,
    fontWeight: FontWeight.w500,
  );

  static const textSemiBold_14 = TextStyle(fontWeight: FontWeight.w600);

  /// Text Size 15
  static const textBold_15 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.black,
  );

  /// Text Size 16
  static const textNormal_16 = TextStyle(fontSize: 16, color: Colors.white);
  static const textMedium_16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  /// Text Size 18
  static const textMedium_18 = TextStyle(
    color: kSecondaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static const textBold_18 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  /// Text Size 20
  static const textNormal_20 = TextStyle(fontFamily: kSectraFont, fontSize: 20);
  static const textBold_20 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  /// Text Size 30
  static const textNormal_30 = TextStyle(
    fontFamily: kSectraFont,
    fontSize: 30,
  );
}
