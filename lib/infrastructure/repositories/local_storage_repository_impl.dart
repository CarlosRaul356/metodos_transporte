import 'package:metodos_transporte/domain/datasources/local_storage_datasource.dart';
import 'package:metodos_transporte/domain/entities/custom_transport_problem.dart';
import 'package:metodos_transporte/domain/repositories/local_storage_repository.dart';

class TransportProblemsRepositoryImpl implements LocalStorageRepository{
  final LocalStorageDatasource datasource;

  TransportProblemsRepositoryImpl(this.datasource);

  @override
  Future<List<CustomTransportProblem>> getTransportProblems({int limit = 10, int offset = 0}) {
    return datasource.getTransportProblems(limit: limit,offset: offset);
  }

  @override
  Future<CustomTransportProblem?> createUpdateTransportProblem(CustomTransportProblem transportProblem) {
    return datasource.createUpdateTransportProblem(transportProblem);
  }

  @override
  Future<void> removeTransportProblem(int problemId) {
    return datasource.removeTransportProblem(problemId);
  }
}