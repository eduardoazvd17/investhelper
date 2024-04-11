import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/enums/operation_type.dart';
import 'package:investhelper/src/features/investments/models/operation_model.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investhelper/src/l10n/l10n.dart';

import '../../../core/utils/app_formatter.dart';
import '../models/investment_model.dart';

class OperationTileWidget extends StatefulWidget {
  final OperationModel operation;
  final InvestmentModel investment;
  final void Function(OperationModel)? onEdit;
  final void Function(OperationModel)? onDelete;
  final bool hideValues;
  const OperationTileWidget({
    super.key,
    required this.operation,
    required this.investment,
    this.onEdit,
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
        height: MediaQuery.of(context).textScaler.scale(225),
        width: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            max(
                                              (widget.operation.quantity *
                                                  widget.operation.unitPrice),
                                              widget.operation.totalPrice,
                                            ),
                                          ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: widget.operation.type.color),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.operation.quantity > 0 &&
                                widget.operation.unitPrice > 0) ...[
                              const SizedBox(height: 5),
                              FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!.quantityDisplay(
                                    widget.hideValues
                                        ? '••••••'
                                        : widget.operation.quantity.toString(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2.5),
                              FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .unitPriceDisplay(
                                    widget.hideValues
                                        ? '${AppFormatter.currencyPrefix} ••••••'
                                        : AppFormatter.currency(
                                            widget.operation.unitPrice,
                                          ),
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
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
                if (widget.onEdit != null && widget.onDelete != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.onEdit != null)
                          IconButton(
                            onPressed: () =>
                                widget.onEdit!.call(widget.operation),
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(CupertinoIcons.pen),
                          ),
                        if (widget.onDelete != null)
                          IconButton(
                            onPressed: () =>
                                widget.onDelete!.call(widget.operation),
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(CupertinoIcons.delete),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
