import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../data/model/student_model.dart';
import '../../../data/service/uploader.dart';
import '../../../view_models/students_view model.dart';

class UpdateStudentPage extends StatefulWidget {
  final StudentModel studentsModel;
  const UpdateStudentPage({super.key, required this.studentsModel});

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController updateStudentInfoCantroller =
  TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    updateStudentInfoCantroller.text = widget.studentsModel.studentName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student Info'),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Consumer<StudentsViewModel>(
            builder: ((context, categoryViewModel, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      'To update students name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: updateStudentInfoCantroller,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (category) =>
                      category != null && category.length < 2
                          ? "More than 2 characters plz"
                          : null,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
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
                    ElevatedButton(
                      onPressed: () {
                        _showPicker(context);
                      },
                      child: Text('Update Student Image',)
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: Image.network(
                        widget.studentsModel.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        StudentModel studentsModel = StudentModel(
                          studentName: updateStudentInfoCantroller.text,
                          studentId: widget.studentsModel.studentId,
                          imageUrl: widget.studentsModel.imageUrl,
                        );

                        Provider.of<StudentsViewModel>(context, listen: false)
                            .updateStudent(studentsModel);
                        Navigator.pop(context);
                      },
                      child: const Text('Update Student Info',)

                    ),
                  ],
                ),
              );
            }),
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
      widget.studentsModel.imageUrl =
      await FileUploader.imageUploader(pickedFile, 'categoryImages');
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
      widget.studentsModel.imageUrl =
      await FileUploader.imageUploader(pickedFile, 'categoryImages');
      setState(() {});
    }
  }
}