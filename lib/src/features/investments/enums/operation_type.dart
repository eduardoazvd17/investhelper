import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum OperationTypeEnum {
  purchase,
  sale,
}

extension OperationTypeEnumExtension on OperationTypeEnum {
  IconData get icon {
    return switch (this) {
      OperationTypeEnum.purchase => CupertinoIcons.arrow_up_right,
      OperationTypeEnum.sale => CupertinoIcons.arrow_down_left,
    };
  }

  Color get color {
    return switch (this) {
      OperationTypeEnum.purchase => Colors.green,
      OperationTypeEnum.sale => Colors.red,
    };
  }
}
