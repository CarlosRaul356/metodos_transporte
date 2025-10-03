import 'dart:convert';
import 'package:metodos_transporte/domain/entities/cell.dart';

class CustomTransportProblem {
  int? id;
  String name = "";
  String arrayJson = "";

  List<List<Cell>> get array => decode(arrayJson);
  set array(List<List<Cell>> value){
    arrayJson = encode(value);
  }

  CustomTransportProblem({required this.name, required this.arrayJson, this.id});

  static String encode(List<List<Cell>> array)=>jsonEncode(
    array.map((row)=>row.map((element)=>element.toJson()).toList()).toList()
  );

  static List<List<Cell>> decode(String json)=>(jsonDecode(json)as List).map(
    (row) => (row as List).map((element)=>Cell.fromJson(element)).toList(),).toList();
}
