import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/common_utils.dart';

/**
 * textView 统一封装使用
 */
class TextstyleUtils {
  static const String app_default_share_url =
      "https://github.com/CarGuo/GSYGithubAppFlutter";

  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static TextStyle appBarTitleWhiteTextStyle =
      TextStyle(fontSize: 18, color: Colors.white);

  static TextStyle appBarTitleBlackTextStyle =
      TextStyle(fontSize: 16, color: Colors.black);

  static TextStyle primaryTextStyle =
      TextStyle(fontSize: 14, color: Colors.black);

  static TextStyle searchResultItemCommentCountStyle =
      TextStyle(fontSize: 12, color: Color(0xFF999999));

  static const minText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: CommonColors.mainColor,
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: CommonColors.mainColor,
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: CommonColors.mainColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: CommonColors.mainColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: CommonColors.mainColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );
}
