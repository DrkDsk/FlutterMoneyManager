import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionBottomAppBar extends StatelessWidget {
  const CreateTransactionBottomAppBar(
      {super.key,
      this.onTapSaveButton,
      this.onTapDeleteButton,
      this.onTapCancelButton});

  final void Function()? onTapSaveButton;
  final void Function()? onTapDeleteButton;
  final void Function()? onTapCancelButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomAppBar(
      child: BlocSelector<CreateTransactionCubit, CreateTransactionState, bool>(
        selector: (state) {
          return state.formIsValidated;
        },
        builder: (context, formValidated) {
          return Row(
            children: [
              if (onTapDeleteButton != null) ...[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTapDeleteButton,
                  child: SizedBox(
                    child: Image.asset(
                      "assets/icons/delete_icon.png",
                      color: AppColors.expenseColor,
                      width: 50,
                    ),
                  ),
                )
              ],
              const SizedBox(width: 10),
              if (onTapSaveButton != null) ...[
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: formValidated ? onTapSaveButton : null,
                    child: Container(
                      decoration: BoxDecoration(
                          color: formValidated
                              ? AppColors.turquoise
                              : AppColors.onPrimary.customOpacity(0.3),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text("Save",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary))),
                    ),
                  ),
                )
              ]
            ],
          );
        },
      ),
    );
  }
}
