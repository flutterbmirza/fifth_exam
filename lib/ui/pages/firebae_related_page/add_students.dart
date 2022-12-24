import 'package:fifth_exam/data/model/student_model.dart';
import 'package:fifth_exam/data/service/uploader.dart';
import 'package:fifth_exam/view_models/students_view%20model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController addStudentNameCantroller =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Consumer<StudentsViewModel>(
              builder: ((context, categoryViewModel, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),
                      Text(
                        'Talaba ismi',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: addStudentNameCantroller,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (category) =>
                            category != null && category.length < 2
                                ? "more than 2 characters"
                                : null,
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'name...',
                          labelStyle: TextStyle(
                              color: Colors.grey[400], fontSize: 16.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            borderSide: const BorderSide(
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        onPressed: () {
                          _showPicker(context);
                        },
                        child: const Text('Upload Student Image'),
                      ),
                      SizedBox(height: 8.h),
                      imageUrl.isEmpty
                          ? SizedBox(height: 1.h)
                          : SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: Image.network(imageUrl),
                            ),
                      ElevatedButton(
                        onPressed: () {
                          if (imageUrl.isNotEmpty) {
                            StudentModel studentmodel = StudentModel(
                              studentId: "",
                              studentName: addStudentNameCantroller.text,
                              imageUrl: imageUrl,
                            );

                            Provider.of<StudentsViewModel>(context,
                                    listen: false)
                                .addStudent(studentmodel);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Add Student"),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploader(pickedFile, 'studentImages');
      setState(() {});
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploader(pickedFile, 'studentImages');
      setState(() {});
    }
  }
}
