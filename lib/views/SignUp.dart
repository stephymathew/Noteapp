import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_note_app/controller/auth_services.dart';
import 'package:my_note_app/views/Signin.dart';
import 'package:my_note_app/views/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _conformpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 194, 109),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Noteify",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                            child: Text("Create Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30))),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Seamlessly jot, sort, and access notes",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 171, 74),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 65, 24, 10),
                                  width: 2.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            controller: _namecontroller,
                            decoration: const InputDecoration(
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 171, 74),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 65, 24, 10),
                                  width: 2.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            controller: _emailcontroller,
                            decoration: const InputDecoration(
                              // labelText: "Email",
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 171, 74),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 65, 24, 10),
                                  width: 2.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            controller: _passwordcontroller,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            obscureText: true,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 171, 74),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 65, 24, 10),
                                  width: 2.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            controller: _conformpasswordcontroller,
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            obscureText: true,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final name = _namecontroller.text.trim();
                            final email = _emailcontroller.text.trim();
                            final password = _passwordcontroller.text.trim();
                            final conformpassword =
                                _conformpasswordcontroller.text.trim();
                            final value =await validate(context, email, password,
                                conformpassword, name);
                            if (value == true) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),

                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Something went wrong "),
                              ));
                            }

                           
                          },
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 77, 26, 7),
                            ),
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Color.fromARGB(255, 250, 194, 109),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SigninScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Having an Account",
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: FaIcon(FontAwesomeIcons.google),
                              color: Colors.black,
                              iconSize: 50,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> validate(BuildContext context, String email, String password,
      String conformpassword, String name) async {
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("please enter a valid username"),
      ));
      return false;
    } else if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid email "),
      ));
      return false;
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid password "),
      ));
      return false;
    } else if (conformpassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid confirmpassword "),
      ));
      return false;
    } else if (password != conformpassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("password is not match")));
      return false;
    } else {
      final value = await AuthServices.signupUser(
        name,
        email,
        password,
      );
      if (value == AuthResults.accountCreatedSuccess) {
        return true;
      } else {
        return false;
      }
    }
  }
}
