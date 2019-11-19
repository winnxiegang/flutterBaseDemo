import 'package:flutter/material.dart';

import 'common_utils.dart';
import 'textstyle.dart';

class ButtonUtls {
  ///水波纹按钮
  static RaisedButton raisedButtonUtils({
    Function onClick(),
    String text,
    Color textColor,
    Color color,
    Color splashColor,
    int borderRadius,
  }) {
    return RaisedButton(
        splashColor: splashColor ?? Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25),
        ),
        textColor: textColor ?? Colors.white,
        color: color ?? CommonColors.mainColor,
        child: Text(
          text ?? '确定',
          style: TextStyleUtils.SubmitButtonTewxt,
        ),
        onPressed: () {
          onClick();
        });
  }
}
