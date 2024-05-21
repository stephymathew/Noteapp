import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_note_app/views/SignUp.dart';
import 'package:my_note_app/views/Signin.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(30),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage("assets/image/Screenshot 2024-05-19 160122.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90,
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 230, 143, 29),
                  ),
                ),
                Text(
                  'Noteify',
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 247, 214, 192),
                  ),
                ),
                //  SizedBox(height: 00,),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
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
                      "Get start with Us",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Color.fromARGB(255, 250, 194, 109),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
