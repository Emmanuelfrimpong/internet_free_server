// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentsModel {
  String? indexNumber;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? dob;
  String? password;
  String? profileUrl;
  String? department;
  String? about;
  bool? isOnline;
  String? status;
  StudentsModel({
    this.indexNumber,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.dob,
    this.password,
    this.profileUrl,
    this.department,
    this.about,
    this.isOnline,
    this.status,
  });
  

  StudentsModel copyWith({
    String? indexNumber,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? dob,
    String? password,
    String? profileUrl,
    String? department,
    String? about,
    bool? isOnline,
    String? status,
  }) {
    return StudentsModel(
      indexNumber: indexNumber ?? this.indexNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      password: password ?? this.password,
      profileUrl: profileUrl ?? this.profileUrl,
      department: department ?? this.department,
      about: about ?? this.about,
      isOnline: isOnline ?? this.isOnline,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'indexNumber': indexNumber,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dob': dob,
      'password': password,
      'profileUrl': profileUrl,
      'department': department,
      'about': about,
      'isOnline': isOnline,
      'status': status,
    };
  }

  factory StudentsModel.fromMap(Map<String, dynamic> map) {
    return StudentsModel(
      indexNumber: map['indexNumber'] != null ? map['indexNumber'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profileUrl: map['profileUrl'] != null ? map['profileUrl'] as String : null,
      department: map['department'] != null ? map['department'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  // from JsonMap
  


  String toJson() => json.encode(toMap());

  factory StudentsModel.fromJson(String source) => StudentsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentsModel(indexNumber: $indexNumber, name: $name, email: $email, phoneNumber: $phoneNumber, gender: $gender, dob: $dob, password: $password, profileUrl: $profileUrl, department: $department, about: $about, isOnline: $isOnline, status: $status)';
  }

  @override
  bool operator ==(covariant StudentsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.indexNumber == indexNumber &&
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.gender == gender &&
      other.dob == dob &&
      other.password == password &&
      other.profileUrl == profileUrl &&
      other.department == department &&
      other.about == about &&
      other.isOnline == isOnline &&
      other.status == status;
  }

  @override
  int get hashCode {
    return indexNumber.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      gender.hashCode ^
      dob.hashCode ^
      password.hashCode ^
      profileUrl.hashCode ^
      department.hashCode ^
      about.hashCode ^
      isOnline.hashCode ^
      status.hashCode;
  }
}
