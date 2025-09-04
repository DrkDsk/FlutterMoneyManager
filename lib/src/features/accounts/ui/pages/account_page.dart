import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_divider.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/widgets/info_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.cyan.shade800.customOpacity(0.70)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InfoBloc(
                      title: "Net Worth",
                      value: "\$ 0.00",
                      titleStyle: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoBloc(
                      title: "Total Assets",
                      value: "\$ 0.00",
                    ),
                    InfoBloc(
                      title: "Debt",
                      value: "\$ 0.00",
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) => const CustomDivider(),
            itemBuilder: (context, index) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.rocket),
                        const SizedBox(width: 10),
                        Text("Car Loan",
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 20))
                      ],
                    ),
                    Text("\$ 0.00",
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.expenseColor, fontSize: 20))
                  ]);
            },
          )
        ],
      ),
    );
  }
}
