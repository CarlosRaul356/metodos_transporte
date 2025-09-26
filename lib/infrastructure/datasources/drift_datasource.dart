import 'package:drift/drift.dart';
import 'package:metodos_transporte/config/database/database.dart';
import 'package:metodos_transporte/domain/datasources/local_storage_datasource.dart';
import 'package:metodos_transporte/domain/entities/custom_transport_problem.dart';

class DriftDatasource implements LocalStorageDatasource{

  final AppDatabase database;

  DriftDatasource([AppDatabase? databaseToUse]):database = databaseToUse??db;

  @override
  Future<CustomTransportProblem?> createUpdateTransportProblem(CustomTransportProblem transportProblem) async{
      if(transportProblem.id == null){
        final int id = await database.into(database.transportProblems).insert(TransportProblemsCompanion.insert(
          name: transportProblem.name,
          arrayJson: transportProblem.arrayJson
        ));
        return transportProblem..id = id;
      }
      final transportProblemCompanionToUpdate = TransportProblemsCompanion(
        name: Value(transportProblem.name),
        arrayJson: Value(transportProblem.arrayJson),
        id: Value(transportProblem.id!)
      );

      await database.update(database.transportProblems).replace(transportProblemCompanionToUpdate);
      return transportProblem;
  }

  @override
  Future<List<CustomTransportProblem>> getTransportProblems({int limit = 10, int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeTransportProblem(int problemId) async{
    final deleteQuery = database.delete(database.transportProblems)
      ..where((problem)=>problem.id.equals(problemId));
    await deleteQuery.go();
    return;
  }

}