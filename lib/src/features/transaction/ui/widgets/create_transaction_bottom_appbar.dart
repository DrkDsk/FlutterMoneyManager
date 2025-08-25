import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionBottomAppBar extends StatelessWidget {
  const CreateTransactionBottomAppBar({super.key, required this.onTap});

  final void Function()? onTap;

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
              Expanded(
                child: GestureDetector(
                  onTap: formValidated ? onTap : null,
                  child: Container(
                    decoration: BoxDecoration(
                        color: formValidated
                            ? AppColors.turquoise
                            : AppColors.onPrimary.customOpacity(0.3),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text("Save",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: theme.colorScheme.primary))),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.secondary)),
                child: Center(
                    child: Text("Continue",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.secondary))),
              )
            ],
          );
        },
      ),
    );
  }
}
