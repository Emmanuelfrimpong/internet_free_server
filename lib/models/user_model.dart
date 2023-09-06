// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? token;
  String? createdAt;
  String? role;
  String? department;
  String? program;
  String? gender;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
    this.token,
    this.createdAt,
    this.role,
    this.department,
    this.program,
    this.gender,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? image,
    String? token,
    String? createdAt,
    String? role,
    String? department,
    String? program,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      role: role ?? this.role,
      department: department ?? this.department,
      program: program ?? this.program,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'token': token,
      'createdAt': createdAt,
      'role': role,
      'department': department,
      'program': program,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      department: map['department'] != null ? map['department'] as String : null,
      program: map['program'] != null ? map['program'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, password: $password, phone: $phone, image: $image, token: $token, createdAt: $createdAt, role: $role, department: $department, program: $program, gender: $gender)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.phone == phone &&
      other.image == image &&
      other.token == token &&
      other.createdAt == createdAt &&
      other.role == role &&
      other.department == department &&
      other.program == program &&
      other.gender == gender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      image.hashCode ^
      token.hashCode ^
      createdAt.hashCode ^
      role.hashCode ^
      department.hashCode ^
      program.hashCode ^
      gender.hashCode;
  }
}
