import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/ui/blocs/home_cubit.dart';
import 'package:flutter_money_manager/src/features/ui/blocs/home_state.dart';
import 'package:flutter_money_manager/src/features/ui/pages/daily_home_page.dart';
import 'package:flutter_money_manager/src/features/ui/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late PageController _pageController;
  late NavigationCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _homeCubit = context.read<NavigationCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onTapBottomNavigationBar(int value) {
    _pageController.jumpToPage(value);
    _homeCubit.setPageIndex(value);
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      bottomNavigationBar: CustomBottomAppBar(onTap: onTapBottomNavigationBar),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  DailyHomePage(),
                  Text("Acounts"),
                  Text("Stats")
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
