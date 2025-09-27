import 'package:metodos_transporte/domain/entities/entities.dart';

abstract class LocalStorageRepository {
  Future<List<CustomTransportProblem>> getTransportProblems({int limit = 10 ,int offset = 0});
  Future<CustomTransportProblem> createUpdateTransportProblem(CustomTransportProblem transportProblem);
  Future<void> removeTransportProblem(int problemId);
}