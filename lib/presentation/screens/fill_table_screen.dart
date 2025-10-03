import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metodos_transporte/domain/domain.dart';
import 'package:metodos_transporte/presentation/providers/transport_problems_provider.dart';

class FillTableScreen extends ConsumerStatefulWidget {
  const FillTableScreen({
    super.key,
    required this.name,
    required this.sources,
    required this.destinations,
  });

  final String name;
  final int sources;
  final int destinations;

  @override
  ConsumerState<FillTableScreen> createState() => _FillTableScreenState();
}

class _FillTableScreenState extends ConsumerState<FillTableScreen> {
  late final List<List<TextEditingController>> _controllers;
  late CustomTransportProblem transportProblem;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    transportProblem = CustomTransportProblem(name: widget.name, arrayJson: "");
    _controllers = List.generate(
      widget.sources+1,
      (i) => List.generate(
        widget.destinations+1,
        (j) => TextEditingController(),
      ),
    );
  }

  @override
  void dispose() {
    for (var row in _controllers) {
      for (TextEditingController controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name, overflow: TextOverflow.ellipsis),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: ListView(
            children: [
              Text("Costos",style: textStyles.titleMedium,textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Form(
                        key: _formKey,
                        child: Table(
                          border: TableBorder.all(color: Colors.white70, width: 1),
                          defaultColumnWidth: FixedColumnWidth(70),
                          children: List.generate(widget.sources + 2, (i) {
                            return TableRow(
                              children: List.generate(widget.destinations + 2, (j) {
                                if (i == 0 && j == 0) {
                                  return Container(
                                    height: 50,
                                    color: Color(0xFFB71C1C),
                                    alignment: Alignment.center, 
                                  );
                                }
                                else if (i == 0) {
                                  return Container(
                                    height: 50,
                                    color: Color(0xFFB71C1C),
                                    alignment: Alignment.center,
                                    child: (j == widget.destinations+1)
                                        ? Text(
                                            "O",
                                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                            textAlign: TextAlign.center,
                                          )
                                        : Text(
                                            "D$j",
                                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                          ),
                                  );
                                }
                                else if (j == 0) {
                                  return Container(
                                    height: 50,
                                    color: Color(0xFFB71C1C),
                                    alignment: Alignment.center,
                                    child: (i == widget.sources+1)
                                        ? Text(
                                            "D",
                                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                          )
                                        : Text(
                                            "F$i",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                  );
                                }else if(j==widget.destinations+1 && i == widget.sources+1){
                                  return SizedBox();
                                }
                                else {
                                  return Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(4),
                                    child: TextFormField(
                                      controller: _controllers[i-1 ][j-1 ],
                                      validator: (value) {
                                        if(value?.isEmpty??false)return "";
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(fontSize: 0,height: 0),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
            if(_formKey.currentState?.validate()??false){
            List<List<Cell>> values = _controllers
                .map((row) => row.map((c) => Cell(
                  value: double.tryParse(c.text)??0
                )).toList())
                .toList();
              transportProblem.arrayJson = CustomTransportProblem.encode(values);
              final newTransportProblem = await ref.read(transportProblemsProvider.notifier).createUpdateTransportProblem(transportProblem);
              transportProblem = newTransportProblem;
            }
          },
          icon: Icon(Icons.save,color: Colors.white,),
          label: Text("Guardar",style: textStyles.titleSmall?.copyWith(color: Colors.white),),
        ),
      ),
    );
  }
}
