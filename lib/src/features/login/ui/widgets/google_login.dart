import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300, width: 0.7),
          color: Colors.grey.shade100
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/google_logo.svg", height: 30),
          const SizedBox(width: 10),
          const Text("Continue with Google", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}