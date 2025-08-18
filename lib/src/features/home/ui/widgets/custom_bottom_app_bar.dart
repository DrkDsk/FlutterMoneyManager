import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar(
      {super.key,
      required this.items,
      required this.pageIndex,
      required this.onTap});

  final List<BottomNavigationBarItem> items;
  final void Function(int value) onTap;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(34)),
        child: BottomNavigationBar(
            onTap: onTap,
            currentIndex: pageIndex,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onPrimary,
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
            ),
            backgroundColor: Colors.blueAccent.shade100,
            items: items),
      ),
    );
  }
}
