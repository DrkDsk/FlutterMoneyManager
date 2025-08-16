import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(34)),
      child: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: theme.colorScheme.onPrimary,
        unselectedItemColor: theme.colorScheme.surface,
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
        backgroundColor: Colors.blueAccent.shade100,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Icon(Icons.home, color: theme.colorScheme.onPrimary),
            ),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Icon(Icons.account_balance_sharp, color: theme.colorScheme.onPrimary),
              ),
              label: "Accounts"
          ),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Icon(Icons.bar_chart_sharp, color: theme.colorScheme.onPrimary),
              ),
              label: "Stats",
          ),
        ]
      ),
    );
  }
}