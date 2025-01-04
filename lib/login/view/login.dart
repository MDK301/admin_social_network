import 'package:admin_social_network/login/controller/login_firebase.dart';
import 'package:admin_social_network/login/view/component/custom_button.dart';
import 'package:admin_social_network/login/view/component/custom_text_field.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =TextEditingController();
    TextEditingController pwController =TextEditingController();

    Future<void> login() async {
// prepare email & pw
      final String email = emailController.text;
      final String pw = pwController.text;


// ensure that the email & pw fields are not empty
      if (email.isNotEmpty && pw.isNotEmpty) {
        // login!
        if(await loginWithEmailAndPassword(email, pw)){

        }
      }
// display error if some fields are empty
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter both email and password'),
        ));
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ), // Icon

                // welcome back msg
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                  ), // TextStyle
                ),
                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 25),

                // pw textfield
                MyTextField(
                  controller: pwController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                // login button
                MyButton(onTap:login
                    , text: "Login"),
                const SizedBox(height: 50),

              ],
            ),
          ),
        ),
      ),
    );
  }

}
