import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/di/di.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/router/app_router.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/screen/create_transaction_screen.dart';

class AddTransactionButton extends StatelessWidget {
  const AddTransactionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        final router = AppRouter.of(context);

        router.goToScreen(BlocProvider(
          create: (context) => getIt<CreateTransactionCubit>(),
          child: const CreateTransactionScreen(),
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.blueAccent.shade100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onPrimary.customOpacity(0.80),
                offset: const Offset(0, 3),
                blurRadius: 1,
              )
            ]),
        child: Icon(Icons.add, size: 36, color: theme.colorScheme.primary),
      ),
    );
  }
}
