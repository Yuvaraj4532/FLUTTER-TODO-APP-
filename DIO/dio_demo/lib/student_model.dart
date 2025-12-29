import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Student {
  final String id;
  final String name;
  final String rollno;
  final String className;
  final String year;

  Student({
    required this.id,
    required this.name,
    required this.rollno,
    required this.className,
    required this.year,
  });

  // Convert JSON → Dart Object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rollno: json['rollno'] ?? '',
      className: json['className'] ?? '',
      year: json['year'] ?? '',
    );
  }

  // Convert Dart Object → JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "rollno": rollno,
      "className": className,
      "year": year,
    };
  }
}
