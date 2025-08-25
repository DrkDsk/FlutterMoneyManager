import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/shared/theme/styles.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/create_transaction_item.dart';

class ExpenseTransactionTabview extends StatelessWidget {
  const ExpenseTransactionTabview(
      {super.key,
      required this.transactionTypeSource,
      this.onSelectTransactionDate,
      this.onTapAmount,
      this.onTapCategory,
      this.amountLabelColor,
      this.onTapTransactionSource});

  final void Function()? onSelectTransactionDate;
  final void Function()? onTapAmount;
  final void Function()? onTapCategory;
  final void Function()? onTapTransactionSource;
  final String transactionTypeSource;
  final Color? amountLabelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: defaultBorder,
      child: BlocBuilder<CreateTransactionCubit, CreateTransactionState>(
        builder: (context, state) {
          final paymentSource = state.transactionEntity.source;
          final transactionCategory = state.transactionEntity.category;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: CreateTransactionItem(
                    label: "Date",
                    value: state.transactionEntity.transactionDate.dateFormat(),
                    onTap: onSelectTransactionDate,
                  ),
                ),
                const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                SizedBox(
                  height: 100,
                  child: CreateTransactionItem(
                      mediumStyle: TextStyle(color: amountLabelColor),
                      label: "Amount",
                      value: state.transactionEntity.amount,
                      onTap: onTapAmount),
                ),
                const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                SizedBox(
                  height: 100,
                  child: CreateTransactionItem(
                      label: "Category",
                      onTap: onTapCategory,
                      value: "Uncategorized",
                      child: transactionCategory == null
                          ? null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(transactionCategory.name),
                                const SizedBox(width: 5),
                                Image.asset(
                                  transactionCategory.icon,
                                  width: 30,
                                )
                              ],
                            )),
                ),
                const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                SizedBox(
                  height: 100,
                  child: CreateTransactionItem(
                      label: transactionTypeSource,
                      onTap: onTapTransactionSource,
                      value: "Uncategorized",
                      child: paymentSource == null
                          ? null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(paymentSource.name),
                                const SizedBox(width: 5),
                                Image.asset(
                                  paymentSource.icon,
                                  width: 30,
                                ),
                              ],
                            )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
