import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investhelper/src/l10n/l10n.dart';

import '../../../core/utils/app_formatter.dart';
import '../models/investment_model.dart';

class InvestmentTileWidget extends StatefulWidget {
  final InvestmentModel investment;
  final void Function(InvestmentModel)? onEdit;
  final void Function(InvestmentModel)? onDelete;
  const InvestmentTileWidget({
    super.key,
    required this.investment,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<InvestmentTileWidget> createState() => _InvestmentTileWidgetState();
}

class _InvestmentTileWidgetState extends State<InvestmentTileWidget> {
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
    return SizedBox(
      height: MediaQuery.of(context).textScaler.scale(190),
      width: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 12.5),
                    if (widget.investment.isEmpty ||
                        (widget.investment.custodialPosition > 0 &&
                            widget.investment.averagePrice > 0)) ...[
                      FittedBox(
                        child: Text(AppLocalizations.of(context)!
                            .custodialPositionDisplay(widget
                                .investment.custodialPosition
                                .toString())),
                      ),
                      const SizedBox(height: 2.5),
                      FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.averagePriceDisplay(
                            AppFormatter.currency(
                                widget.investment.averagePrice),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2.5),
                    ],
                    FittedBox(
                      child: Text(
                        AppLocalizations.of(context)!.amountInvestedDisplay(
                          AppFormatter.currency(
                            widget.investment.amountInvested,
                          ),
                        ),
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
                              widget.onEdit!.call(widget.investment),
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(CupertinoIcons.pen),
                        ),
                      if (widget.onDelete != null)
                        IconButton(
                          onPressed: () =>
                              widget.onDelete!.call(widget.investment),
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
    );
  }
}
