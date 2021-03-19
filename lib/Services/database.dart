import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/Models/todo.dart';

class Database {
  final FirebaseFirestore firebaseFirestore;
  Database({@required this.firebaseFirestore});

  Stream<List<TodoModel>> streamTodos({String uid}) {
    try {
      return firebaseFirestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .where("done", isEqualTo: false)
          .snapshots()
          .map((query) {
        final List<TodoModel> retVal = <TodoModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(TodoModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo({ @required String uid,@required String content}) async {
    try {
      firebaseFirestore.collection("todos").doc(uid).collection("todos").add({
        "content": content,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteTodo({@required String uid,@required String todoId})async{
    try{
      await firebaseFirestore.collection("todos").doc(uid).collection("todos").doc(todoId).delete();
    }catch(e){
      rethrow;
    }
  }

  Future<void> updateTodo({@required String uid,@required String todoId})async{
     try{
      await firebaseFirestore.collection("todos").doc(uid).collection("todos").doc(todoId).update(
        {
          "done": true
        }
      );
     }catch(e){
       rethrow;
     }
  }

}
