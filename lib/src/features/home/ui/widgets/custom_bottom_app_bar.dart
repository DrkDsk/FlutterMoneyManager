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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
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
      ),
    );
  }
}
