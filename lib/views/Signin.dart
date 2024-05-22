import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_note_app/controller/auth_services.dart';
import 'package:my_note_app/views/SignUp.dart';
import 'package:my_note_app/views/home.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key});

  @override
  State<SigninScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SigninScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 
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
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Noteify",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 40),
                        Text("LOG IN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Enter you user name and password",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
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
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              hintText: "email",
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
                            controller: _passwordController,
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
                        
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final name = _usernameController.text.trim();
                            final password = _passwordController.text.trim();
                            final value =await validate(context, name, password);
                            if (value == true) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),(route) => false,
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
                              "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Color.fromARGB(255, 250, 194, 109),
                              ),
                            )),
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
                                        builder: (context) =>
                                            LoginScreen()));
                              },
                              child: const Text(
                                "Having No Account Please Tap Here",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
}

Future<bool> validate(
  BuildContext context,
  String name,
  String password,
) async {
  if (name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("please enter a valid username"),
    ));
    return false;
  } else if (password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Please enter a valid password "),
      ),
    );
    return false;
  } else {
    final value = await AuthServices.signIn(
      name,
      password,
    );
    if (value == AuthResults.logInSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
