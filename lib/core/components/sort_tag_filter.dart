import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

class SortTagFilter extends StatefulWidget {
  const SortTagFilter({super.key, required this.name});

  final String name;

  @override
  State<SortTagFilter> createState() => _SortTagFilterState();
}

class _SortTagFilterState extends State<SortTagFilter> {
  late String _name;
  bool? _sorted = null;

  @override
  void initState() {
    super.initState();

    _name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: PartsflowColors.primaryLight2,
        borderRadius: BorderRadius.circular(2),
        border: BoxBorder.all(color: PartsflowColors.primaryLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.remove, color: PartsflowColors.primaryLight),
          Text(_name),
          Icon(
            Icons.remove,
            color: PartsflowColors.primaryLight,
          ),
        ],
      ),
    );
  }
}
