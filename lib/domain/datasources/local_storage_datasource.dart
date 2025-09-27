import 'package:metodos_transporte/domain/entities/custom_transport_problem.dart';

abstract class LocalStorageDatasource {
    Future<List<CustomTransportProblem>> getTransportProblems({int limit = 10,int offset = 0});
    Future<CustomTransportProblem> createUpdateTransportProblem(CustomTransportProblem transportProblem);
    Future<void> removeTransportProblem(int problemId);
}