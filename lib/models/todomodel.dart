import 'package:my_note_app/views/constants/constants.dart';

class Todo {
  String? id;
  String? header;
  String? description;
  String? date;
  int? color;
  bool? pin;

  Todo({
    this.id,
    this.header,
    this.description,
    this.date,
    this.color,
    this.pin,
  });

  Todo fromJson(Map<String, dynamic> map) {
    return Todo(
      id: map[columnid] as String?,
      color: map[columncolor] as int?,
      header: map[columnheader] as String?,
      description: map[columndescription] as String?,
      date: map[columndate] as String?,
      pin: map[columnpin] as bool?,
    );
  }

  Map<String, dynamic> toJson(Todo todo) {
    return {
      columnid: todo.id,
      columnheader: todo.header,
      columndescription: todo.description,
      columndate: todo.date,
      columncolor: todo.color,
      columnpin: todo.pin,
    };
  }
}
