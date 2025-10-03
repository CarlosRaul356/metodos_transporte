import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metodos_transporte/domain/domain.dart';
import 'package:metodos_transporte/presentation/providers/transport_problem_provider.dart';
import 'package:metodos_transporte/shared/vogel_program/vogel.dart';
import 'package:metodos_transporte/shared/widgets/widgets.dart';

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

  late final List<Widget> tables;
  late final pageController = PageController();
  int step = 1;
  
  @override
  void initState() {
    super.initState();
    tables = Vogel(vogelArray: widget.transportProblem.array).calculateVogelMethod();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
        child: (tables.length>1)?Stack(
          children: [
            PageView(
              controller: pageController,
              children: [
                ...tables
              ],
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: ListTile(
                title: Center(child: Text("Paso $step", style: textStyles.titleSmall,)),
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      step--;
                      pageController.animateToPage(step-1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    });
                  }, icon: Icon(Icons.arrow_back)),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      step++;
                      pageController.animateToPage(step-1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    });
                  }, icon: Icon(Icons.arrow_forward)),
              ),
            )
          ],
        ):tables.first,
      ),
    );
  }
}