import 'package:flutter/material.dart';

class ButtonTileWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color? backgroundColor;
  final Color? color;
  final IconData? icon;
  const ButtonTileWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = this.color ??
        Theme.of(context)
            .elevatedButtonTheme
            .style
            ?.backgroundColor
            ?.resolve(MaterialState.values.toSet()) ??
        Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
