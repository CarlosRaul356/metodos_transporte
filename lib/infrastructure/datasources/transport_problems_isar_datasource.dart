// import 'package:isar/isar.dart';
// import 'package:metodos_transporte/domain/datasources/transport_problems_datasource.dart';
// import 'package:metodos_transporte/domain/entities/transport_problem.dart';
// import 'package:path_provider/path_provider.dart';

// class TransportproblemsIsarDatasource implements TransportProblemsDatasource {
//   late Future<Isar> db;

//   TransportproblemsIsarDatasource(){
//     db= openDb();
//   }

//   Future<Isar> openDb()async{
//     if(Isar.instanceNames.isEmpty){
//       final dir = await getApplicationDocumentsDirectory();
//       return await Isar.open([TransportProblemSchema], 
//         directory: dir.path,
//         name: "transportProblems",
//         inspector: true
//       );
//     }
//     return Future.value(Isar.getInstance("transportProblems"));
//   }

//   @override
//   Future<List<TransportProblem>> getTransportProblems({int limit = 10, int offset = 0}) async{
//     final isar = await db;
//     final problems = isar.transportProblems.where(sort: Sort.desc).offset(offset).limit(limit).findAll();
//     return problems;
//   }

//   @override
//   Future<TransportProblem?> createUpdateTransportProblem(TransportProblem transportProblem) async{
//     final isar = await db;
//     int id = 0;
//     isar.writeTxn(() async{
//       id = await isar.transportProblems.put(transportProblem);
//     },);
//     return isar.transportProblems.get(id);
    
//   }

//   @override
//   Future<void> removeTransportProblem(String problemId) async{
//     final isar = await db;
//     isar.writeTxn(() async{
//       isar.transportProblems.delete(int.tryParse(problemId)??-1);
//     },);
//   } 

// }