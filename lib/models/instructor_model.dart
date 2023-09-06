// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InstructorsModel {
  String? name;
  String? email;
  String? department;
  String? status;
  String? id;
  bool? isOnline;
  String? profileUrl;
  String? gender;
  String? phoneNumber;
  String? about;
  String? password;
  InstructorsModel({
    this.name,
    this.email,
    this.department,
    this.status,
    this.id,
    this.isOnline,
    this.profileUrl,
    this.gender,
    this.phoneNumber,
    this.about,
    this.password,
  });

  InstructorsModel copyWith({
    String? name,
    String? email,
    String? department,
    String? status,
    String? id,
    bool? isOnline,
    String? profileUrl,
    String? gender,
    String? phoneNumber,
    String? about,
    String? password,
  }) {
    return InstructorsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      status: status ?? this.status,
      id: id ?? this.id,
      isOnline: isOnline ?? this.isOnline,
      profileUrl: profileUrl ?? this.profileUrl,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      about: about ?? this.about,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'department': department,
      'status': status,
      'id': id,
      'isOnline': isOnline,
      'profileUrl': profileUrl,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'about': about,
      'password': password,
    };
  }

  factory InstructorsModel.fromMap(Map<String, dynamic> map) {
    return InstructorsModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      department: map['department'] != null ? map['department'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      profileUrl: map['profileUrl'] != null ? map['profileUrl'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstructorsModel.fromJson(String source) => InstructorsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InstructorsModel(name: $name, email: $email, department: $department, status: $status, id: $id, isOnline: $isOnline, profileUrl: $profileUrl, gender: $gender, phoneNumber: $phoneNumber, about: $about, password: $password)';
  }

  @override
  bool operator ==(covariant InstructorsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.department == department &&
      other.status == status &&
      other.id == id &&
      other.isOnline == isOnline &&
      other.profileUrl == profileUrl &&
      other.gender == gender &&
      other.phoneNumber == phoneNumber &&
      other.about == about &&
      other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      department.hashCode ^
      status.hashCode ^
      id.hashCode ^
      isOnline.hashCode ^
      profileUrl.hashCode ^
      gender.hashCode ^
      phoneNumber.hashCode ^
      about.hashCode ^
      password.hashCode;
  }
}
