import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_note_app/models/todomodel.dart';

class FireStoreServices {
  static saveUser(String name, email, password, uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'name': name, 'email': email, 'Id': uid});
  }

  static Future<bool> saveTodo({
    required Todo todo,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final instance = FirebaseFirestore.instance
          .collection("todo")
          .doc(user!.uid)
          .collection("todos")
          .doc();
      todo.id = instance.id;
      await instance.set(todo.toJson(todo));
      return true;
    } catch (e) {
      // print("Error saving todo: $e");
      return false;
    }
  }

  static Future<bool> updateTodo({
    required Todo todo,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final instance = FirebaseFirestore.instance
          .collection("todo")
          .doc(user!.uid)
          .collection("todos")
          .doc(todo.id);
      await instance.update(todo.toJson(todo));
      return true;
    } catch (e) {
      // print("Error updating todo: $e");
      return false;
    }
  }
}
