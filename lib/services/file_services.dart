

import 'dart:async';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internet_free_server/models/students_model.dart';

class FileServices{
   static Future<(Exception?, Uint8List?)> pickExcelFIle() async {
    try {
      FilePickerResult? result =await FilePickerWeb.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx'],
        allowMultiple: false,
      );
      return Future.value((null, result!.files.single.bytes));
    } catch (e) {
      print(e.toString());
      return Future.value((Exception(e.toString()), null));
    }
  }

  static   Future<(Exception?, Excel?)> readExcelData(Uint8List? data) {
    try {
      if (data != null) {
        return Future.value((null, Excel.decodeBytes(data)));
      } else {
        return Future.value((Exception('No file selected'), null));
      }
    } catch (e) {
      return Future.value((Exception(e.toString()), null));
    }
  }

  static Future<(Exception?, List<StudentsModel>?)>getStudentsFromExcel(Excel? data) {
    try{
      if (data == null) {
        return Future.value((Exception('No file selected'), null));
      }
      //get rows
      var rows = data.tables[data.getDefaultSheet()]!.rows;

       //remove header row
      List<StudentsModel> students = rows
          .skip(2)
          .map<StudentsModel>((row) {       
            return StudentsModel(
             indexNumber: row[0]!.value.toString(),
             name: "${row[1]!.value.toString()} ${row[2]!.value.toString()}",
             email: '',
             password: row[0]!.value.toString(),
              department:'',
              phoneNumber: '',
              gender: '',
              profileUrl: '',
              dob: '',
              about: '',
              status: 'active'
            );
          })
          .where((element) => element.indexNumber!.isNotEmpty)
          .toList();
      return Future.value((null, students));
    }catch(e){
      return Future.value((Exception(e.toString()), null) );
    }
  }

}