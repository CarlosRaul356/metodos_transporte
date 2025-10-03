import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metodos_transporte/domain/domain.dart';
import 'package:metodos_transporte/presentation/providers/local_storage_repository_provider.dart';

final transportProblemProvider = NotifierProvider.autoDispose.family<TransportProblemNotifier,TransportProblemState,int>(TransportProblemNotifier.new);

class TransportProblemNotifier extends AutoDisposeFamilyNotifier<TransportProblemState,int>{
  late final LocalStorageRepository transportProblemRepository;
  late final int id;
  
  @override
  TransportProblemState build(int arg) {
    transportProblemRepository = ref.watch(localStorageRepositoryProvider);
    id = arg;
    Future.microtask(() => loadProblem(),);
    return TransportProblemState();
  }
  

  Future<void> loadProblem()async{
    state = state.copyWith(isLoading: true);
    final problem = await transportProblemRepository.getTransportProblemById(id);
    if(problem != null){
      state = state.copyWith(
        isLoading: false,
        transportProblem: problem
      );
    }
  }

}

class TransportProblemState{
  final bool isLoading;
  final CustomTransportProblem? transportProblem;

  TransportProblemState({
    this.isLoading = false,
    this.transportProblem,
  });
  
  TransportProblemState copyWith({
    bool? isLoading,
    CustomTransportProblem? transportProblem,
  })=>TransportProblemState(
    isLoading: isLoading??this.isLoading,
    transportProblem: transportProblem??this.transportProblem,
  );

}