import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metodos_transporte/presentation/dialogs/create_transport_problem_dialog.dart';
import 'package:metodos_transporte/presentation/providers/transport_problems_provider.dart';

class SelectTransportProblemScreen extends StatelessWidget {
  const SelectTransportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Mis problemas"),
      ),
      body: _SelectTransportProblemView(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              CreateTransportProblemDialog.showTransportProblemDialog(context);
            },
            label: Text("Nuevo Problema", style: textStyles.titleSmall?.copyWith(color: Colors.white),),
            icon: Icon(Icons.add_circle_rounded,color: Colors.white,),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}

class _SelectTransportProblemView extends ConsumerStatefulWidget {
  const _SelectTransportProblemView();

  @override
  ConsumerState<_SelectTransportProblemView> createState() => _SelectTransportProblemViewState();
}

class _SelectTransportProblemViewState extends ConsumerState<_SelectTransportProblemView> {
  late final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => ref.read(transportProblemsProvider.notifier).loadTransportProblems(),);
    scrollController.addListener(() {
      if(scrollController.position.pixels+500>=scrollController.position.maxScrollExtent){
        ref.read(transportProblemsProvider.notifier).loadTransportProblems();
      }
    },);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transportProblems = ref.watch(transportProblemsProvider).transportProblems;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        controller: scrollController,
        children: [
          ...transportProblems.map(
            (problem)=>Text(problem.name)
          )
        ],
      ),
    );
  }
}