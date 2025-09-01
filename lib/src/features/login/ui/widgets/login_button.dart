import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/di/di.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/screens/home_screen.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/get_transactions/get_transactions_list_cubit.dart';

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
                  create: (context) => getIt<GetTransactionsListCubit>(),
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
