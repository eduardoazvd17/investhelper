import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/enums/operation_type.dart';
import 'package:investhelper/src/features/investments/models/operation_model.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';

import '../../../core/utils/app_formatter.dart';
import '../../../l10n/l10n.dart';
import '../models/investment_model.dart';

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
        height: MediaQuery.of(context).textScaler.scale(214),
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
                          FittedBox(
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
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            if (widget.operation.quantity > 0 &&
                                widget.operation.unitPrice > 0) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      widget.hideValues
                                          ? '••••••••'
                                          : '${widget.operation.quantity}x ${AppFormatter.currency(widget.operation.unitPrice)} ',
                                    ),
                                  ),
                                  if (widget.operation.type ==
                                      OperationTypeEnum.sale)
                                    FittedBox(
                                      child: Text(
                                        widget.hideValues
                                            ? '••••••••'
                                            : ' ${AppLocalizations.of(context)!.profitDisplay(AppFormatter.currency(widget.operation.profit))}',
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 5),
                            ],
                            FittedBox(
                              child: Text(
                                AppFormatter.dateWithDay(
                                  context,
                                  widget.operation.date,
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 10),
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
              if (widget.onDelete != null)
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
