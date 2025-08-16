import 'package:flutter/material.dart';

class DailyBalanceWidget extends StatelessWidget {
  const DailyBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Transaction on August",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withOpacity(0.20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Aug 15",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text("Friday",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  Text(
                    "\$ 40.00",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade600),
                        child: const Icon(Icons.money),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Salary",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "\$ 40.00",
                        style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Debit Card",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withOpacity(0.20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Aug 15",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text("Friday",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  Text(
                    "\$ 40.00",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade600),
                        child: const Icon(Icons.money),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Salary",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "\$ 40.00",
                        style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Debit Card",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}