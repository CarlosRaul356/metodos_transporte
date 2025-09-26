import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metodos_transporte/infrastructure/datasources/drift_datasource.dart';
import 'package:metodos_transporte/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) => TransportProblemsRepositoryImpl(DriftDatasource()),);