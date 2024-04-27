import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/widgets/textinputfield.dart';

class SignUpWithEmail extends StatelessWidget {
  SignUpWithEmail({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _Usernamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
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
                'Resister',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: authcontroller.profilePhoto != null
                        ? FileImage(authcontroller.profilePhoto!)
                            as ImageProvider<Object>
                        : const AssetImage('assets/user.png'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () => authcontroller.pickImage(),
                        icon: const Icon(Icons.add_a_photo)),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _Usernamecontroller,
                  label: 'Username',
                  prefixicon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 15,
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
                height: 15,
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
                  onTap: () => authcontroller.register_user(
                    _Usernamecontroller.text,
                    _emailcontroller.text,
                    _passwordcontroller.text,
                    authcontroller.profilePhoto,
                  ),
                  child: const Center(
                    child: Text(
                      'Register',
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
                    "Already have a account? ",
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => Login_Screen()),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
