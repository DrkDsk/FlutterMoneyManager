import 'package:flutter/material.dart';

class StackScreen extends StatelessWidget {
  const StackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StackCardInformation(),
      ),
    );
  }
}

class StackCardInformation extends StatelessWidget {
  const StackCardInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final maxWidth = MediaQuery.of(context).size.width;
    final partialWidth = maxWidth * 0.8;
    final littleCardWidth = maxWidth / 4;

    final restWidth = (maxWidth - partialWidth) / 2;

    return Stack(
      children: [
        Positioned(
          top: 80,
          child: Container(
            width: partialWidth,
            decoration: BoxDecoration(
                color: Colors.pink.shade200.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12)),
            constraints: const BoxConstraints(
              maxHeight: 600,
            ),
            child: const SingleChildScrollView(
              child: Text(
                  "data"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "datadatadatadatadatadatadatadatadata"
                  "here here here here here here here"
                  "here here here here here here here"
                  "here here here here here here here"
                  "here here here here here here here"
                  "here here here here here here here"
                  "here here here here here here here"
                      "here here here here here here here"
                      "here here here here here here here"
                      "here here here here here here here"
                      "here here here here here here here"
                      "here here here here here here here"
                      "here here here here here here here"

              ),
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: restWidth,
          child: Container(
            height: 100,
            width: littleCardWidth,
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(12)),
            child: const SizedBox.shrink(),
          ),
        )
      ],
    );
  }
}
