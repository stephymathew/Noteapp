

import 'package:flutter/material.dart';

import 'package:my_note_app/controller/firestore_services.dart';
import 'package:my_note_app/models/todomodel.dart';
import 'package:my_note_app/views/constants/constants.dart';
import 'package:my_note_app/views/home.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key, this.todo});
  final Todo? todo;

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  int _selectedColor = 0;
  DateTime _selectedDate = DateTime.now();
  bool isPinned = false;
  final TextEditingController _headcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final FocusNode _headerFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    if (widget.todo != null) {
      _headcontroller.text = widget.todo!.header ?? "";
      _descriptioncontroller.text = widget.todo!.description ?? "";
      _selectedDate = DateTime.parse(widget.todo!.date!);
      _selectedColor = widget.todo!.color ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 119, 109, 109),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 180),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            if (_headcontroller.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please enter header")));
                            } else if (_descriptioncontroller.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please enter description")));
                            } else if (widget.todo != null) {
                              final value = await FireStoreServices.updateTodo(
                                  todo: Todo(
                                      id: widget.todo!.id,
                                      header: _headcontroller.text,
                                      description: _descriptioncontroller.text,
                                      color: _selectedColor,
                                      date: _selectedDate.toString(),
                                      pin: isPinned));
                              if (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Note Updated ")));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Failed to update Note")));
                              }
                            } else {
                              print("save todo ontap ");
                              final value = await FireStoreServices.saveTodo(
                                  todo: Todo(
                                      header: _headcontroller.text,
                                      description: _descriptioncontroller.text,
                                      color: _selectedColor,
                                      date: _selectedDate.toString(),
                                      pin: isPinned));
                              if (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Note Added ")));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Failed to add Note")));
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 119, 109, 109),
                            ),
                            child: const Icon(
                              Icons.file_download_done_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      focusNode: _headerFocusNode,
                      controller: _headcontroller,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: "Header",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide()),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            children: [
                              const Text(
                                "Due date",
                                style: TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: _selectedDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null &&
                                      pickedDate != _selectedDate) {
                                    setState(() {
                                      _selectedDate = pickedDate;
                                    });
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 104, 92, 92),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              "${_selectedDate.toLocal()}".split(' ')[0],
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_downward_rounded,
                                              color: Colors.white,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _descriptioncontroller,
                            focusNode: _descriptionFocusNode,
                            maxLines: 8,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Description",
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: colorPalette[_selectedColor],
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 60,
            width: 60,
            color: Colors.transparent,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: colorPalette.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = colorPalette.indexWhere((element) => element == color);
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: _selectedColor == color ? Colors.white : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
