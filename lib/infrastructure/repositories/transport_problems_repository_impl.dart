import 'package:metodos_transporte/domain/datasources/transport_problems_datasource.dart';
import 'package:metodos_transporte/domain/entities/transport_problem.dart';
import 'package:metodos_transporte/domain/repositories/transport_problems_repository.dart';

class TransportProblemsRepositoryImpl implements TransportProblemsRepository{
  final TransportProblemsDatasource datasource;

  TransportProblemsRepositoryImpl(this.datasource);

  @override
  Future<List<Transportproblem>> getTransportProblems({int limit = 10, int offset = 0}) {
    return datasource.getTransportProblems(limit: limit,offset: offset);
  }

  @override
  Future<void> insertTransportProblem(Transportproblem transportProblem) {
    return datasource.insertTransportProblem(transportProblem);
  }

  @override
  Future<void> removeTransportProblem(String problemId) {
    return datasource.removeTransportProblem(problemId);
  }
}