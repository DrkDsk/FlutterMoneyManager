import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/shared/home/home_builder.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/pages/daily_home_page.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/custom_bottom_app_bar.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      bottomNavigationBar: BlocSelector<NavigationCubit, int, int>(
        selector: (state) {
          return state;
        },
        builder: (context, pageIndex) {
          return CustomBottomAppBar(
            pageIndex: pageIndex,
            onTap: onTapBottomNavigationBar,
            items: HomeBuilder.items,
          );
        },
      ),
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
            )),
          ],
        ),
      ),
    );
  }
}
