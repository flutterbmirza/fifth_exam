import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/student_model.dart';


class StudentRepository {
  final FirebaseFirestore _firestore;

  StudentRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addStudent({required StudentModel studentModel}) async {
    try {
      DocumentReference newStudent =
      await _firestore.collection("students").add(studentModel.toJson());
      await _firestore.collection("students").doc(newStudent.id).update({
        "studentId": newStudent.id,
      });
      getMyToast(message: "Students added successfully");
    } on FirebaseException catch (er) {
      getMyToast(message: er.message.toString());
    }
  }

  Future<void> deleteStudent({required String docId}) async {
    try {
      await _firestore.collection("students").doc(docId).delete();
      getMyToast(message: "Students Deleted successfully!");
    } on FirebaseException catch (er) {
      getMyToast(message: er.message.toString());
    }
  }

  Future<void> updateStudent({required StudentModel studentModel}) async {
    try {
      await _firestore
          .collection("students")
          .doc(studentModel.studentId)
          .update(studentModel.toJson());

      getMyToast(message: "Students updated successfully");
    } on FirebaseException catch (er) {
      getMyToast(message: er.message.toString());
    }
  }

  Stream<List<StudentModel>> getStudents() =>
      _firestore.collection("students").snapshots().map(
            (event1) => event1.docs
            .map((doc) => StudentModel.fromJson(doc.data()))
            .toList(),
      );

  Future<bool?> getMyToast({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade300,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}


