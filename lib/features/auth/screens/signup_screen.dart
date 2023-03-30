import 'package:fcb_donate/features/auth/screens/login.dart';
import 'package:fcb_donate/features/auth/services/auth_services.dart';
import 'package:fcb_donate/common/costom_textfield.dart';
import 'package:flutter/material.dart';


import '../../../utils/button.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/signup";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();

 final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

 final  _signUpKey = GlobalKey<FormState>();

  AuthServices authServices = AuthServices();
  bool isSighup = false;
  signUpUser(name, email, password) async {


    setState(() {
      isSighup = true;
    });
    await authServices.signUpuser(
        email: email, password: password, name: name, context: context);
    setState(() {
      isSighup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(maxHeight: size.height, maxWidth: size.width),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 161, 15, 149),
              Color.fromARGB(255, 51, 40, 202)
            ], begin: Alignment.topLeft, end: Alignment.topRight),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Register Here",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset.infinite,
                          blurRadius: 2)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _signUpKey,
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            hintText: "Name", controller: _nameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            hintText: "Email", controller: _emailController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Password",
                          controller: _passwordController,
                          isPass: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if(_signUpKey.currentState!.validate()){
                              signUpUser(_nameController.text,
                                _emailController.text, _passwordController.text);
                            }
                            
                          },
                          child: CustomButton(
                            widget: isSighup
                                ? const CircularProgressIndicator(
                                    color: Colors.red,
                                  )
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text("Already have an Account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, Login.routeName, (route) => false);
                                },
                                child: const Text("Login "))
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
