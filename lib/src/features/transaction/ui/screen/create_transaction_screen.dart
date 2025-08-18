import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/widgets/custom_app_bar.dart';
import 'package:flutter_money_manager/src/core/theme/styles.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() => _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {

  final FocusNode _focusNode = FocusNode();
  late TextEditingController _noteController;

  @override
  void initState() {
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final largeStyle = theme.textTheme.bodyLarge
        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400);
    final smallStyle = theme.textTheme.bodyMedium?.copyWith(fontSize: 20);

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.turquoise,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Center(child: Text("Save", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary))),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.secondary)
              ),
              child: Center(child: Text("Continue", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary))),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: defaultBorder,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date", style: smallStyle),
                        GestureDetector(
                            onTap: () {
                              final today = DateTime.now();
                              const defaultDuration = Duration(days: 30);

                              final firstDate = today.subtract(defaultDuration);
                              final lastDate = today.add(defaultDuration);

                              showDatePicker(
                                  context: context,
                                  firstDate: firstDate,
                                  lastDate: lastDate);
                            },
                            child: Text("Aug 18, 2025", style: largeStyle))
                      ],
                    ),
                  ),
                  const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount", style: smallStyle),
                        Text("\$ 0.00",
                            style:
                                largeStyle?.copyWith(color: AppColors.expenseColor))
                      ],
                    ),
                  ),
                  const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category", style: smallStyle),
                        Text("Uncategorized", style: largeStyle)
                      ],
                    ),
                  ),
                  const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payment Source", style: smallStyle),
                        Text("None", style: largeStyle)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: defaultBorder,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _noteController,
                autofocus: true,
                focusNode: _focusNode,
                style: theme.textTheme.bodySmall,
                decoration: InputDecoration(
                  hintText: "Enter a note",
                  hintStyle: TextStyle(
                    color: AppColors.onPrimary.withOpacity(0.5)
                  ),
                    filled: true,
                  fillColor: Colors.grey.withOpacity(0.05),
                  border: InputBorder.none
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
