import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/router/app_router.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => AppRouter.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.only(left: 10, bottom: 2),
          decoration: ContainerStyles.defaultBorder,
          child: const Center(
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
