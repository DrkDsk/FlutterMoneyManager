import 'package:flutter/material.dart';

class LoginFormContainer extends StatelessWidget {
  const LoginFormContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          )
        ],
      ),
    );
  }
}