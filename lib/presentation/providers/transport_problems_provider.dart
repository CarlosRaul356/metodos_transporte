import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metodos_transporte/domain/domain.dart';
import 'package:metodos_transporte/presentation/providers/local_storage_repository_provider.dart';

final transportProblemsProvider = NotifierProvider<TransportProblemsNotifier,TransportProblemsState>((TransportProblemsNotifier.new));

class TransportProblemsNotifier extends Notifier<TransportProblemsState> {
  late final LocalStorageRepository repository;
  @override
  TransportProblemsState build() {
    repository = ref.watch(localStorageRepositoryProvider);
    return TransportProblemsState();
  }


  Future<void>loadTransportProblems()async{
    if(state.isLoading||state.isLastPage)return;
    state = state.copyWith(isLoading: true);
    final transportProblems = await repository.getTransportProblems(limit: 15,offset: state.page*15);
    if(transportProblems.length < 15){
      state = state.copyWith(isLastPage: true);
    }
    state = state.copyWith(
      transportProblems: [...state.transportProblems,...transportProblems],
      isLoading: false,
      page: state.page+1
    );
  }

  Future<CustomTransportProblem> createUpdateTransportProblem(CustomTransportProblem transportProblem)async{
    final newTransportProblem = await repository.createUpdateTransportProblem(transportProblem);
    state = state.copyWith(
      transportProblems: [
        newTransportProblem,
        ...state.transportProblems.where((element) => element.id!=newTransportProblem.id,),
      ]
    );
    return newTransportProblem;
  }

}

class TransportProblemsState{
  final List<CustomTransportProblem> transportProblems;
  final bool isLoading;
  final int page;
  final bool isLastPage;

  TransportProblemsState({
    this.transportProblems = const [],
    this.isLoading = false,
    this.page = 0,
    this.isLastPage = false,
  });

  TransportProblemsState copyWith({
    List<CustomTransportProblem>? transportProblems,
    bool? isLoading,
    int? page,
    bool? isLastPage,
  })=>TransportProblemsState(
    transportProblems:transportProblems??this.transportProblems,
    isLoading:isLoading??this.isLoading,
    page:page??this.page,
    isLastPage:isLastPage??this.isLastPage,
  );
}