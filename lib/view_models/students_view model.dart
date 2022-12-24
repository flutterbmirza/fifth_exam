import 'dart:async';
import 'package:flutter/material.dart';

import '../data/model/student_model.dart';
import '../data/repository/students_repo.dart';

class StudentsViewModel extends ChangeNotifier {
  final StudentRepository studentRepository;
  StudentsViewModel({required this.studentRepository}) {
    listenStudents();
  }

  late StreamSubscription subscription;

  List<StudentModel> students = [];

  listenStudents() async {
    subscription = studentRepository.getStudents().listen((allStudents) {
      students = allStudents;
      notifyListeners();
    });
  }

  addStudent(StudentModel studentsModel) =>
      studentRepository.addStudent(studentModel: studentsModel);

  updateStudent(StudentModel studentsModel) =>
      studentRepository.updateStudent(studentModel: studentsModel);

  deleteStudent(String docId) => studentRepository.deleteStudent(docId: docId);

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}