import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyViewUtils {
  static Widget emptyViewWidget(
      {String text, String imageAddress, Function click()}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              click();
            },
            child: Image.asset(
              imageAddress ??
                  'https://resources.ninghao.org/images/candy-shop.jpg',
              height: 150,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(text ?? '哎呦喂，列表暂时没数据呢...')
        ],
      ),

    );

  }
}
