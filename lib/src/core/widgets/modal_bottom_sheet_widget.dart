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
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: GestureDetector(
                onTap: _hideKeyboard,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    color: Theme.of(context).bottomSheetTheme.backgroundColor,
                  ),
                  child: ModalBottomSheetWidget(
                    title: title,
                    actions: actions,
                    children: children,
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
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom -
                  MediaQuery.of(context).viewPadding.top -
                  MediaQuery.of(context).padding.bottom -
                  199,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: widget.children),
                ),
              ),
            ),
          ),
          if (widget.actions != null && widget.actions!.isNotEmpty) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.actions!,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
