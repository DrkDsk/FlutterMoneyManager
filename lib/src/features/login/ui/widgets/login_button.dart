import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/di/di.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/blocs/account_bloc.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/screens/home_screen.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
                BlocProvider(
                  create: (_) => getIt<NavigationCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<TransactionsBloc>(),
                ),
                BlocProvider(
                  create: (context) => getIt<CalendarBloc>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AccountBloc>(),
                ),
              ], child: const HomeScreen()))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.blueAccent.shade700,
        ),
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
