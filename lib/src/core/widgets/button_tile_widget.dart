import 'package:flutter/material.dart';

class ButtonTileWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? color;
  final bool showBorder;
  final Color? backgroundColor;
  final IconData? icon;
  const ButtonTileWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.showBorder = true,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = onTap == null
        ? Colors.grey
        : this.color ??
            Theme.of(context)
                .elevatedButtonTheme
                .style
                ?.backgroundColor
                ?.resolve(MaterialState.values.toSet()) ??
            Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.5),
        child: Container(
          decoration: BoxDecoration(
            color: onTap == null ? null : backgroundColor,
            border: showBorder ? Border.all(color: color) : null,
            borderRadius: BorderRadius.circular(12.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22.5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(icon ?? Icons.arrow_forward_ios, color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
