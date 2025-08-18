import 'package:flutter/material.dart';

class HomeBuilder {
  static List<BottomNavigationBarItem> get items {
    return const [
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Icon(Icons.home),
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Icon(Icons.account_balance_sharp),
        ),
        label: "Accounts",
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Icon(Icons.bar_chart_sharp),
        ),
        label: "Stats",
      ),
    ];
  }
}
