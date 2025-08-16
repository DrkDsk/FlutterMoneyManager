import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/di/di.dart';
import 'package:flutter_money_manager/src/core/theme/theme__helper.dart';
import 'package:flutter_money_manager/src/features/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<NavigationCubit>(),
          )
        ],
        child: const HomeScreen()
      ),
    );
  }
}