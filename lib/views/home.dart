import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_note_app/controller/auth_services.dart';
import 'package:my_note_app/models/todomodel.dart';
import 'package:my_note_app/views/SignUp.dart';
import 'package:my_note_app/views/constants/addpage.dart';
import 'package:my_note_app/views/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> bodyitems = [const ListHome(), const PageScreen(), const PageScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: bodyitems[_selectedIndex],
          floatingActionButton: FloatingActionButton(
            elevation: 8,
            backgroundColor: const Color.fromARGB(255, 121, 118, 111),
            hoverColor: Colors.amberAccent,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListHome extends StatelessWidget {
  const ListHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Mr.Note",
              style: TextStyle(
                
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            AuthServices.signout();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text("Logout"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(
                Icons.exit_to_app,
                color: Color.fromARGB(255, 225, 224, 231),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("todo")
                .doc(uid)
                .collection("todos")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return const Center(child: Text("Not available"));
              }
              final list = snapshot.data!.docs;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final data = Todo().fromJson(list[index].data());
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageScreen(todo: data),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: colorPalette[data.color ?? 0].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.header ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data.description ?? "",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 231, 227, 227),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            DateFormat.yMMMd().add_jms().format(
                                DateTime.parse(data.date ?? "")),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
