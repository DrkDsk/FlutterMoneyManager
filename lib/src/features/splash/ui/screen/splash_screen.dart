import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:collection/collection.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEFDF),
      body: Center(
        child: Lottie.asset("assets/lottie/loading.lottie",
            decoder: customDecoder),
      ),
    );
  }
}

Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(bytes, filePicker: (files) {
    return files.firstWhereOrNull(
        (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
  });
}
