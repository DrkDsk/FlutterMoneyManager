import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';

class DailyBalanceWidget extends StatelessWidget {
  const DailyBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Transaction on August",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.50,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: theme.colorScheme.onSecondary.withOpacity(0.10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Aug 15",
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.onSecondary.withOpacity(0.20),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text("Friday",
                                    style: theme.textTheme.bodyMedium),
                              )
                            ],
                          ),
                          Text(
                            "\$ 40.00",
                            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.incomeColor),
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$ 40.00",
                                style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.incomeColor),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Debit Card",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            splashColor: theme.colorScheme.secondary,
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.40),
            child: const Icon(Icons.add, size: 30),
            onPressed: () {

            }
          )
        ],
      ),
    );
  }
}