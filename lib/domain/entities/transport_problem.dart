import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:metodos_transporte/domain/entities/cell.dart';

part 'transport_problem.g.dart';


@collection
class Transportproblem {
  Id id = Isar.autoIncrement;
  String name = "";
  String arrayJson = "";

  @ignore
  List<List<Cell>> get array => decode(arrayJson);
  set array(List<List<Cell>> value){
    arrayJson = encode(value);
  }

  Transportproblem({required this.name, required this.arrayJson});

  static String encode(List<List<Cell>> array)=>jsonEncode(
    array.map((row)=>row.map((element)=>element.toJson()).toList()).toList()
  );

  static List<List<Cell>> decode(String json)=>(jsonDecode(json)as List).map(
    (row) => (row as List).map((element)=>Cell.fromJson(element)).toList(),).toList();
}