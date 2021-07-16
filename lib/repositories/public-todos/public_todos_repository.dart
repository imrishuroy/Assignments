import 'package:assignments/config/paths.dart';
import 'package:assignments/models/failure_model.dart';
import 'package:assignments/models/public_todos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PublicTodosRepository {
  final CollectionReference _publicTodos =
      FirebaseFirestore.instance.collection(Paths.public);

  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;

//  Stream<List todos()  {
//     final usersRef = await publicTodos.get();
//     usersRef.docs.forEach((element) {
//       element.data();
//     });
//   }

  Stream<List<PublicTodo>> allTodos() {
    try {
      return _publicTodos
          .orderBy('dateTime', descending: true)
          .snapshots()
          .map((snaps) {
        return snaps.docs
            .map(
                (doc) => PublicTodo.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      print(error.toString());
      throw Failure(message: 'Something went wrong :(');
    }
  }

  Future<bool> checkPublicTodoAlreadyExists(String? publicTodoId) async {
    bool _exists = false;
    try {
      final todo = await _publicTodos.doc(publicTodoId).get();
      print('----todo $todo');
      if (todo.exists) {
        print('this exists ');
        _exists = true;
      }

      return _exists;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> addPublicTodo(PublicTodo todo) async {
    try {
      await _publicTodos.doc(todo.todoId).set(todo.toMap());
    } catch (error) {
      print(error.toString());
      throw Failure(message: 'Something went wrong try again :(');
    }
  }

  Future<void> deleteTodo(PublicTodo todoToDelete) async {
    try {
      if (todoToDelete.authorId == _currentUserId) {
        await _publicTodos.doc(todoToDelete.todoId).delete();
      }
    } catch (error) {
      print(error.toString());
      throw Failure(message: 'Something went wrong');
    }
  }

  Future<void> deleteTodoById(String? publicTodoId) async {
    try {
      await _publicTodos.doc(publicTodoId).delete();
    } catch (error) {
      print(error.toString());
      throw Failure(message: 'Something went wrong');
    }
  }

  Future<void> updatePublicTodo(PublicTodo todoToUpdate) async {
    try {
      if (todoToUpdate.authorId == _currentUserId) {
        await _publicTodos
            .doc(todoToUpdate.todoId)
            .update(todoToUpdate.toMap());
      }
    } catch (error) {
      throw Failure(message: error.toString());
    }
  }
}
