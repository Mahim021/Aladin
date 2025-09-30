import 'package:flutter/material.dart';
import 'package:grocery_shop/components/my_button.dart';
import 'package:grocery_shop/components/my_textField.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /* Change after themes are added */
      /* Theme.of(context).colorScheme.background */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Colors.black,

              /* Change after themes are added */
              /* Theme.of(context).colorScheme.inversePrimary, */
            ),

            const SizedBox(height: 25),

            // Message, App slogan
            Text(
              "Food Delivery App",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                /* Change after themes are added */
                /* Theme.of(context).colorScheme.inversePrimary */
              ),
            ),

            const SizedBox(height: 25),

            // Email text field
            MyTextfield(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),

            const SizedBox(height: 10),

            // password text field
            MyTextfield(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),

            const SizedBox(height: 25),

            // signin button
            MyButton(onTap: () {}, text: "SignIn"),

            // not a member, register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?", style: TextStyle(color: Colors.pink)),
                /* Change after themes are added */
                /* Theme.of(context).colorScheme.inversePrimary */
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                /* Change after themes are added */
                /* Theme.of(context).colorScheme.inversePrimary */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
