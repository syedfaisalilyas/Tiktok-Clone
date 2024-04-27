import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen_with_email.dart';
import 'package:tiktok_clone/views/screens/widgets/textinputfield.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tiktok',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w900,
                  color: buttonColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailcontroller,
                  label: 'Email',
                  prefixicon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _passwordcontroller,
                  label: 'Password',
                  prefixicon: Icons.lock,
                  isobscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    )),
                child: InkWell(
                  onTap: () => authcontroller.loginUser(
                      _emailcontroller.text, _passwordcontroller.text),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have a account? ",
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => SignUpWithEmail()),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
