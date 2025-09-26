import 'package:metodos_transporte/domain/entities/entities.dart';

abstract class TransportProblemsDatasource {
  Future<List<Transportproblem>> getTransportProblems({int limit = 10,int offset = 0});
  Future<void> insertTransportProblem(Transportproblem transportProblem);
  Future<void> removeTransportProblem(String problemId);
}
