import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Text("Hi, Welcome Back! 👋",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.black, fontSize: 25)),
              const SizedBox(height: 10,),
              Text(
                "We happy to see you. Sign in to your account",
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email"),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none
                      ),
                      filled: true,
                      hintText: "email@gmail.com",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500
                      ),
                      fillColor: Colors.pink.shade200.withOpacity(0.10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Password"),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none
                      ),
                      filled: true,
                      hintStyle:TextStyle(
                        color: Colors.grey.shade500
                      ),
                      hintText: "Ingresar contraseña",
                      fillColor: Colors.pink.shade200.withOpacity(0.10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password?",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
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
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Create here",
                    style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Or Sign In with",
                    style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
