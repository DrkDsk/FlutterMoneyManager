import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/shared/theme/styles.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/create_transaction_item.dart';

class CreateTransactionTabview extends StatelessWidget {
  const CreateTransactionTabview(
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
          final sourceName = state.transaction.sourceType;
          final categoryName = state.transaction.categoryType;
          TransactionSource? transactionSource;
          TransactionCategory? transactionCategory;

          if (sourceName != null && sourceName.isNotEmpty) {
            transactionSource = TransactionSource.fromString(sourceName);
          }

          if (categoryName != null && categoryName.isNotEmpty) {
            transactionCategory = TransactionCategory.fromString(categoryName);
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: CreateTransactionItem(
                    label: "Date",
                    value: state.transaction.transactionDate.dateFormat(),
                    onTap: onSelectTransactionDate,
                  ),
                ),
                const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                SizedBox(
                  height: 100,
                  child: CreateTransactionItem(
                      mediumStyle: TextStyle(color: amountLabelColor),
                      label: "Amount",
                      value: "\$ ${state.transaction.amount}",
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
                      child: transactionSource == null
                          ? null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(transactionSource.name),
                                const SizedBox(width: 5),
                                Image.asset(
                                  transactionSource.icon,
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
