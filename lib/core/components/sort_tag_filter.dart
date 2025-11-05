import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

enum SortTagSortingType { ascendant, descendant, none }

class SortTagFilter extends StatefulWidget {
  const SortTagFilter({super.key, required this.name, required this.onSortTypeChange});

  final String name;
  final void Function(SortTagSortingType sortType) onSortTypeChange; 

  @override
  State<SortTagFilter> createState() => _SortTagFilterState();
}

class _SortTagFilterState extends State<SortTagFilter> {
  late final String _name;
  late IconData _iconData = Icons.remove;
  late void Function(SortTagSortingType sortType) _onSortTypeChange;

  SortTagSortingType _sortType = SortTagSortingType.none;

  @override
  void initState() {
    super.initState();

    _name = widget.name;
    _onSortTypeChange = widget.onSortTypeChange;
  }

  void _handleOnTap(BuildContext context) {
    SortTagSortingType currentIsSorted = _sortType;
    IconData currentIconData = _iconData;
    String snackbarMessage = "";

    final messenger = ScaffoldMessenger.of(context);

    switch (currentIsSorted) {
      case SortTagSortingType.none:
        currentIsSorted = SortTagSortingType.ascendant;
        currentIconData = Icons.arrow_upward_rounded;
        snackbarMessage = "Ordenando por $_name de forma ascendiente";
        break;
      case SortTagSortingType.ascendant:
        currentIsSorted = SortTagSortingType.descendant;
        currentIconData = Icons.arrow_downward_outlined;
        snackbarMessage = "Ordenando por $_name de forma descendiente";
        break;
      case SortTagSortingType.descendant:
        currentIsSorted = SortTagSortingType.none;
        currentIconData = Icons.remove;
        snackbarMessage = "Sin ordernar por $_name";
        break;
    }

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: PartsflowColors.primaryLight2,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        content: Row(
          children: [
            const Icon(Icons.info, color: PartsflowColors.info),
            const SizedBox(width: 12),
            Text(
              snackbarMessage,
              style: const TextStyle(color: PartsflowColors.backgroundDark),
            ),
          ],
        ),
      ),
    );

    setState(() {
      _sortType = currentIsSorted;
      _iconData = currentIconData;
    });

    _onSortTypeChange(currentIsSorted);
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icon(_iconData, color: PartsflowColors.primaryLight);

    return GestureDetector(
      onTap: () => _handleOnTap(context),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: PartsflowColors.primaryLight2,
          borderRadius: BorderRadius.circular(2),
          border: BoxBorder.all(color: PartsflowColors.primaryLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text(_name), icon],
        ),
      ),
    );
  }
}
