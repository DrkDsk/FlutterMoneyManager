import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/di/di.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_state.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/features/login/ui/screens/login_screen.dart';
import 'package:flutter_money_manager/src/features/splash/ui/screen/splash_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late HomeRedirectionCubit _homeRedirectionCubit;

  @override
  void initState() {
    super.initState();
    _homeRedirectionCubit = context.read<HomeRedirectionCubit>();
    Future.microtask(() {
      _homeRedirectionCubit.checkRedirectionStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeRedirectionCubit, HomeRedirectionState>(
      listener: (context, state) {
        if (state.status == RedirectionStatus.login) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }

        if (state.status == RedirectionStatus.home) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider(
                  create: (_) => getIt<NavigationCubit>(),
                  child: const HomeScreen())));
        }
      },
      child: const SplashScreen(),
    );
  }
}
