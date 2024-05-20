import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_formatter.dart';
import '../../../l10n/l10n.dart';
import '../enums/category_enum.dart';
import '../enums/operation_type_enum.dart';
import '../models/investment_model.dart';
import '../models/operation_model.dart';
import 'category_indicator_widget.dart';

class OperationTileWidget extends StatefulWidget {
  final OperationModel operation;
  final InvestmentModel investment;
  final void Function(OperationModel)? onDelete;
  final bool hideValues;
  const OperationTileWidget({
    super.key,
    required this.operation,
    required this.investment,
    this.onDelete,
    this.hideValues = false,
  });

  @override
  State<OperationTileWidget> createState() => _OperationTileWidgetState();
}

class _OperationTileWidgetState extends State<OperationTileWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: SizedBox(
        height: MediaQuery.of(context).textScaler.scale(237),
        width: 300,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            widget.operation.type.icon,
                            color: widget.operation.type.color,
                            size: 30,
                          ),
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                widget.hideValues
                                    ? '${AppFormatter.currencyPrefix} ••••••'
                                    : AppFormatter.currency(
                                        widget.operation.value),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: widget.operation.type.color),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.investment.category.hasQuotas ||
                          widget.investment.category.isCrypto)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  widget.hideValues
                                      ? '••••••••'
                                      : widget.investment.category.isCrypto
                                          ? '${widget.operation.cryptoQuantity}'
                                          : '${widget.operation.quantity}x ${AppFormatter.currency(widget.operation.unitPrice)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.operation.type ==
                                OperationTypeEnum.sale) ...[
                              if (widget.investment.category.hasQuotas)
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .averagePriceDisplay(
                                        AppFormatter.currency(
                                          widget.operation.lastAveragePrice,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (widget.investment.category.hasQuotas ||
                                  widget.investment.category.isCrypto)
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      widget.hideValues
                                          ? '••••••••'
                                          : AppLocalizations.of(context)!
                                              .profitDisplay(
                                              AppFormatter.currency(
                                                widget.operation.profit,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                            ],
                            if (widget.investment.category.hasQuotas &&
                                widget.operation.type ==
                                    OperationTypeEnum.purchase)
                              Flexible(
                                child: FittedBox(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .averagePriceVariationDisplay(
                                      widget.operation.averagePriceVariation
                                                  .abs() <
                                              0.01
                                          ? AppFormatter.currency(0)
                                          : ((widget
                                                      .operation
                                                      .averagePriceVariation
                                                      .isNegative
                                                  ? ''
                                                  : '+') +
                                              AppFormatter.currency(
                                                widget.operation
                                                    .averagePriceVariation,
                                              )),
                                    ),
                                  ),
                                ),
                              ),
                            FittedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  AppFormatter.dateWithDay(
                                    context,
                                    widget.operation.date,
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.investment.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      FittedBox(
                        child: CategoryIndicatorWidget(
                          category: widget.investment.category,
                          textColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.onDelete != null &&
                  !widget.operation.date
                      .isBefore(widget.investment.lastOperationDate!))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () =>
                            widget.onDelete!.call(widget.operation),
                        icon: const Icon(CupertinoIcons.delete),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
