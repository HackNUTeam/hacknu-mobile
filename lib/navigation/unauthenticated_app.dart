import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hacknu_mobile/core/component.dart';
import 'package:hacknu_mobile/feature/auth/bloc/auth_bloc.dart';
import 'package:hacknu_mobile/feature/auth/model/user_data.dart';

class UnauthenticatedApp extends StatefulWidget {
  const UnauthenticatedApp({super.key});

  @override
  State<UnauthenticatedApp> createState() => _UnauthenticatedAppState();
}

class _UnauthenticatedAppState extends State<UnauthenticatedApp> {
  final UserData user = UserData();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController workController = TextEditingController();

  bool loading = false;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
                color: bcolor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    "FireUpp",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.4,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    hintText: "Username",
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: workController,
                                  decoration: const InputDecoration(
                                    hintText: "Occupation",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 55),
                          roundbutton(
                              title: "Login",
                              color: bcolor,
                              tapfun: () {
                                user.email = emailController.text;
                                user.username = usernameController.text;
                                user.work = workController.text;
                                BlocProvider.of<AuthBloc>(context)
                                    .add(LoginAuthEvent(user: user));
                              }),
                          SizedBox(height: 10.0),
                          roundbutton(
                              title: "Anonymous login",
                              color: Colors.red,
                              tapfun: () {
                                user.email = "anonymous";
                                user.username = "anonymous username";
                                user.work = "anonymous";
                                BlocProvider.of<AuthBloc>(context)
                                    .add(LoginAuthEvent(user: user));
                              }),
                          const SizedBox(height: 10),
                          const Text("- OR -"),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 37,
                              width: 49,
                              decoration: const BoxDecoration(
                                color: bcolor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
