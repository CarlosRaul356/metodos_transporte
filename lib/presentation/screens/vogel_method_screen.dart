import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metodos_transporte/domain/domain.dart';
import 'package:metodos_transporte/presentation/providers/transport_problem_provider.dart';
import 'package:metodos_transporte/shared/vogel_program/vogel.dart';

class VogelMethodScreen extends ConsumerWidget {
  const VogelMethodScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problemState = ref.watch(transportProblemProvider(id));

    return (problemState.isLoading||problemState.transportProblem==null)?Center(
      child: CircularProgressIndicator(),
    ):_VogelMethodView(transportProblem: problemState.transportProblem!);
  }
}

class _VogelMethodView extends StatefulWidget {
  const _VogelMethodView({required this.transportProblem});
  final CustomTransportProblem transportProblem;

  @override
  State<_VogelMethodView> createState() => _VogelMethodViewState();
}

class _VogelMethodViewState extends State<_VogelMethodView> {

  late final Vogel myVogelMethod;
  late final List<Widget> tables;
  late final double cost;
  late final Map<String,int> answers;
  int step = 0;

  late final pageController = PageController();
  
  @override
  void initState() {
    super.initState();
    myVogelMethod = Vogel(vogelArray: widget.transportProblem.array);
    tables = myVogelMethod.calculateVogelMethod();
    cost = myVogelMethod.cost;
    answers = myVogelMethod.answers;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  _showResultsDialog(BuildContext context){
    final Map<String,int> answersSorted;
    final List<String> keysSorted = answers.keys.toList()..sort();
    answersSorted = {
      for(String key in keysSorted)key:answers[key]!
    };
    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
          child: _ResultsDialogView(answers: answersSorted, cost: cost)
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transportProblem.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: (tables.length>1)?Column(
          children: [
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  ...tables
                ],
              ),
            ),    
            ListTile(
              title: Center(child: Text("Paso $step", style: textStyles.titleSmall,)),
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    if(step!=0){
                      step--;
                    }
                    pageController.animateToPage(step, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  });
                }, icon: Icon(Icons.arrow_back)),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if(step!=tables.length-1){
                      step++;
                    }
                    pageController.animateToPage(step, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  });
                }, icon: Icon(Icons.arrow_forward)),
            ),
            SizedBox(height: 50,)
            
          ],
        ):tables.first,
      ),
      floatingActionButton: 
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                _showResultsDialog(context);
              }, label: Text("Resultados",style: textStyles.titleSmall?.copyWith(color: Colors.white),),
            ),
            SizedBox(height: 100,),
          ],
        ),
    );
  }
}



class _ResultsDialogView extends StatelessWidget {
  const _ResultsDialogView({required this.answers, required this.cost});
  final Map<String,int> answers;
  final double cost;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: SizedBox(
        height: 380,
        child: ListView(
          children: [
            Text("Resultados",style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w700,fontSize: 20),textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Costo: ",style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w700),),
                Text("\$$cost",style: textStyles.titleSmall,),
              ],
            ),
            SizedBox(height: 10,),
            Text("Asignaciones: ",style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w700),),
            ...answers.entries.map((e) {
              return Text("${e.key} : ${e.value}");
            },)
          ],
        ),
      ),
    );
  }
}