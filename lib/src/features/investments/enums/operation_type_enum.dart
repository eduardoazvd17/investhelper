import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

enum OperationTypeEnum {
  purchase,
  sale,
}

extension OperationTypeEnumExtension on OperationTypeEnum {
  String getTitle(BuildContext context) {
    return switch (this) {
      OperationTypeEnum.purchase => AppLocalizations.of(context)!.purchase,
      OperationTypeEnum.sale => AppLocalizations.of(context)!.sale,
    };
  }

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
