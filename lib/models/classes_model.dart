// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClassModel {
  String? id;
  String? title;
  String? description;
  String? code;
  bool? isOpen;
  List<dynamic>? instructors;
  ClassModel({
    this.id,
    this.title,
    this.description,
    this.code,
    this.isOpen,
    this.instructors,
  });

  ClassModel copyWith({
    String? id,
    String? title,
    String? description,
    String? code,
    bool? isOpen,
    List<dynamic>? instructors,
  }) {
    return ClassModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      code: code ?? this.code,
      isOpen: isOpen ?? this.isOpen,
      instructors: instructors ?? this.instructors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'code': code,
      'isOpen': isOpen,
      'instructors': instructors,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      isOpen: map['isOpen'] != null ? map['isOpen'] as bool : null,
      instructors: map['instructors'] != null ? List<dynamic>.from((map['instructors'] as List<dynamic>) ): null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) => ClassModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassModel(id: $id, title: $title, description: $description, code: $code, isOpen: $isOpen, instructors: $instructors)';
  }

  @override
  bool operator ==(covariant ClassModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.code == code &&
      other.isOpen == isOpen &&
      listEquals(other.instructors, instructors);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      code.hashCode ^
      isOpen.hashCode ^
      instructors.hashCode;
  }
}
