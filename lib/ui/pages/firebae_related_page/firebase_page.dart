import 'package:fifth_exam/data/model/student_model.dart';
import 'package:fifth_exam/ui/pages/firebae_related_page/add_students.dart';
import 'package:fifth_exam/ui/pages/firebae_related_page/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/students_view model.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AddStudentPage()),);
          }, icon: Icon(Icons.add))
        ],
        title: const Text('Students', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Consumer<StudentsViewModel>(
        builder: ((context, studentViewModel, child) {
          return Column(
            children: [
              SizedBox(
                height: 650.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: studentViewModel.students.length,
                  itemBuilder: (context, index) {
                    return studentItem(
                      studentViewModel.students[index],
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget studentItem(StudentModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6).r,
      child: Container(
        height: 110.h,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(width: 8.w),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(model.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 80.h,
              width: 80.w,
            ),
            SizedBox(width: 12.w),
            SizedBox(
              width: 150.w,
              child: Text(
                model.studentName,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateStudentPage(studentsModel: model)));
              },
              child: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 28,
              ),
            ),
            SizedBox(width: 22.w),
            InkWell(
              onTap: () {
                Provider.of<StudentsViewModel>(
                  context,
                  listen: false,
                ).deleteStudent(model.studentId);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.black,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}