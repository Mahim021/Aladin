import 'package:flutter/material.dart';
import 'package:grocery_shop/components/my_button.dart';
import 'package:grocery_shop/components/my_textField.dart';
import 'package:grocery_shop/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/models/restaurant.dart';

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

  // login method
  void login() async {
    final _authService = AuthService();
    try {
      final credential = await _authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
      // Set user for cart persistence
  final restaurant = Provider.of<Restaurant>(context, listen: false);
  await restaurant.setUser(credential.user?.uid);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  void forgotPw() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("User tapped forgot password."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      /* Change after themes are added */
      /*  */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,

              /* Change after themes are added */
              /*  */
            ),

            const SizedBox(height: 25),

            // Message, App slogan
            Text(
              "Food Delivery App",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
                /* Change after themes are added */
                /* */
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
            MyButton(onTap: login, text: "Sign In"),

            const SizedBox(height: 25),

            // not a member, register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                /* Change after themes are added */
                /*  */
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                /* Change after themes are added */
                /*  */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
