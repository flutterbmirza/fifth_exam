class StudentModel {
  StudentModel({
    required  this.studentId,
    required  this.studentName,
    required  this.imageUrl,
  });

  String studentId;
  String studentName;
  String imageUrl;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    studentId: json["studentId"]??"",
    studentName: json["studentName"]??"",
    imageUrl: json["imageUrl"]??"",
  );

  Map<String, dynamic> toJson() => {
    "studentId": studentId,
    "studentName": studentName,
    "imageUrl": imageUrl,
  };
}