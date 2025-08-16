import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.blue.shade600),
                  child: const Icon(Icons.home)),
              const SizedBox(height: 5),
              const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.blue.shade600),
                  child: const Icon(Icons.home)),
              const SizedBox(height: 5),
              const Text(
                "Accounts",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}