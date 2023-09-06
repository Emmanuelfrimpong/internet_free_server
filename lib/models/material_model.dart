// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MaterialModel {
  String? title;
  String? description;
  String? fileType;
  String? path;
  String? course;
  String? department;
  String? postByName;
  String? postById;
  String? classId;
  MaterialModel({
    this.title,
    this.description,
    this.fileType,
    this.path,
    this.course,
    this.department,
    this.postByName,
    this.postById,
    this.classId,
  });
  

  MaterialModel copyWith({
    String? title,
    String? description,
    String? fileType,
    String? path,
    String? course,
    String? department,
    String? postByName,
    String? postById,
    String? classId,
  }) {
    return MaterialModel(
      title: title ?? this.title,
      description: description ?? this.description,
      fileType: fileType ?? this.fileType,
      path: path ?? this.path,
      course: course ?? this.course,
      department: department ?? this.department,
      postByName: postByName ?? this.postByName,
      postById: postById ?? this.postById,
      classId: classId ?? this.classId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'fileType': fileType,
      'path': path,
      'course': course,
      'department': department,
      'postByName': postByName,
      'postById': postById,
      'classId': classId,
    };
  }

  factory MaterialModel.fromMap(Map<String, dynamic> map) {
    return MaterialModel(
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      fileType: map['fileType'] != null ? map['fileType'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      department: map['department'] != null ? map['department'] as String : null,
      postByName: map['postByName'] != null ? map['postByName'] as String : null,
      postById: map['postById'] != null ? map['postById'] as String : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterialModel.fromJson(String source) => MaterialModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MaterialModel(title: $title, description: $description, fileType: $fileType, path: $path, course: $course, department: $department, postByName: $postByName, postById: $postById, classId: $classId)';
  }

  @override
  bool operator ==(covariant MaterialModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.fileType == fileType &&
      other.path == path &&
      other.course == course &&
      other.department == department &&
      other.postByName == postByName &&
      other.postById == postById &&
      other.classId == classId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      fileType.hashCode ^
      path.hashCode ^
      course.hashCode ^
      department.hashCode ^
      postByName.hashCode ^
      postById.hashCode ^
      classId.hashCode;
  }
}
