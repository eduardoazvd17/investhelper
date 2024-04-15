import 'package:flutter/material.dart';

class FiltersIndicatorBarWidget extends StatelessWidget {
  final List<FiltersIndicatorBarItem> filters;
  final void Function()? onOpenFilters;
  const FiltersIndicatorBarWidget(this.filters,
      {super.key, this.onOpenFilters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: filters.map((filter) {
            return InkWell(
              onTap: onOpenFilters,
              borderRadius: BorderRadius.circular(10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (filter.icon != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SizedBox(
                            height: 20,
                            child: FittedBox(child: filter.icon!),
                          ),
                        ),
                      Text(filter.title),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FiltersIndicatorBarItem {
  final String title;
  final Icon? icon;
  FiltersIndicatorBarItem({required this.title, this.icon});
}
