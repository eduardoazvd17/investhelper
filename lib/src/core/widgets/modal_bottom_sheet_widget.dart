import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetWidget extends StatefulWidget {
  final String title;
  final List<Widget>? actions;
  final List<Widget> children;
  const ModalBottomSheetWidget({
    super.key,
    required this.title,
    required this.children,
    this.actions,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    required List<Widget> children,
  }) async {
    return await showModalBottomSheet<T>(
      elevation: 0,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final double paddingTop;
        if (kIsWeb) {
          paddingTop = kToolbarHeight;
        } else if (Platform.isAndroid) {
          paddingTop = kToolbarHeight + 31.5;
        } else {
          paddingTop = kToolbarHeight + 62.5;
        }

        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: paddingTop),
                child: GestureDetector(
                  onTap: _hideKeyboard,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12.5),
                      ),
                      color: Theme.of(context).bottomSheetTheme.backgroundColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.5),
                      child: ModalBottomSheetWidget(
                        title: title,
                        actions: actions,
                        children: children,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  State<ModalBottomSheetWidget> createState() => _ModalBottomSheetWidgetState();
}

class _ModalBottomSheetWidgetState extends State<ModalBottomSheetWidget> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            _getHeaderWidget,
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(children: widget.children),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _getActionsWidget,
    );
  }

  Widget get _getHeaderWidget {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Container(
                width: 80,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Divider(height: 0),
        ),
      ],
    );
  }

  Widget? get _getActionsWidget {
    if (widget.actions == null || widget.actions!.isEmpty) return null;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.actions!,
            ),
          ),
        ],
      ),
    );
  }
}
