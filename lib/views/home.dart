import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
  List<Widget> bodyitems = [ListHome(), PageScreen(), PageScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add your navigation logic here
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
  child: Icon(Icons.add),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageScreen(),
      ),
    );
  },
),

      //     bottomNavigationBar: Container(
      //       height: 80,
      //       width: double.infinity,
      //       child: ConvexAppBar(
      //         style: TabStyle.react,
      //         backgroundColor: Colors.grey[800],
      //         items: [
      //           TabItem(icon: Icons.filter_list, title: 'Filter'),
      //           TabItem(icon: Icons.add, title: 'Add'),
      //           TabItem(icon: Icons.search, title: 'Search'),
      //         ],
      //         initialActiveIndex: _selectedIndex,
      //         onTap: _onItemTapped,
      //       ),
      //     ),
      //   ),
      // ),
        )
      )
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
            Text(
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
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                AuthServices.signout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  },
  child: Icon(
    Icons.exit_to_app,
    color: Color.fromARGB(255, 225, 224, 231),
  ),
),

          ],
        ),
        SizedBox(height: 20),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("todo")
                .doc(uid)
                .collection("todos")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (!snapshot.hasData) {
                return Center(child: Text("Not available"));
              }
              final list = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 0.9, 
                ),
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
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: colorPalette[data.color ?? 0].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, 
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
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              data.description ?? "",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 231, 227, 227),
                              ),
                            ),
                          ),
                        Spacer(),
                          Text(
  DateFormat.yMMMd().add_jms().format(DateTime.parse(data.date ?? "")), 
  style: TextStyle(color: Colors.grey),
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
