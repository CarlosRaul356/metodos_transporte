import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metodos_transporte/domain/domain.dart';
import 'package:metodos_transporte/presentation/providers/transport_problems_provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

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

  _showSnackBar(BuildContext context, String content){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 2),
      ),
    );
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
          child: Column(
            children: [
              Text("Costos",style: textStyles.titleMedium,textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                    child: Form(
                      key: _formKey,
                      child: TableView.builder(
                        diagonalDragBehavior: DiagonalDragBehavior.free,
                        columnCount: widget.destinations+2,
                        rowCount: widget.sources+3,
                        columnBuilder: (index) {
                          return TableSpan(
                            extent: FixedSpanExtent(70),
                          );
                        },
                        rowBuilder: (index) {
                          return TableSpan(
                            extent: FixedSpanExtent(65),
                          );
                        },
                        cellBuilder: (context, vicinity) {
                          return _buildCell(i: vicinity.row, j: vicinity.column, destinations: widget.destinations, sources: widget.sources, controllers: _controllers);
                        },
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
                _showSnackBar(context, "¡Problema Guardado Correctamente!");
                context.pop();
                transportProblem.arrayJson = CustomTransportProblem.encode(values);
                final newTransportProblem = await ref.read(transportProblemsProvider.notifier).createUpdateTransportProblem(transportProblem);
                transportProblem = newTransportProblem;
              }else{
                _showSnackBar(context, "Los valores ingresados contienen errores");
              }
          },
          icon: Icon(Icons.save,color: Colors.white,),
          label: Text("Guardar",style: textStyles.titleSmall?.copyWith(color: Colors.white),),
        ),
      ),
    );
  }
}

TableViewCell _buildCell({required int i, required int j, required int destinations,required int sources, required List<List<TextEditingController>> controllers}){
  if (i == 0 && j == 0) {
    return TableViewCell(
      child: Container(
        height: 50,
        color: Color(0xFFB71C1C),
        alignment: Alignment.center, 
      ),
    );
  }
  else if (i == 0) {
    return TableViewCell(
      child: Container(
        height: 50,
        color: Color(0xFFB71C1C),
        alignment: Alignment.center,
        child: (j == destinations+1)
            ? Text(
                "O",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                textAlign: TextAlign.center,
              )
            : Text(
                "D$j",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ),
      ),
    );
  }else if(i==sources+2){
    return TableViewCell(child: SizedBox());
  }
  else if (j == 0) {
    return TableViewCell(
      child: Container(
        height: 50,
        color: Color(0xFFB71C1C),
        alignment: Alignment.center,
        child: (i == sources+1)
            ? Text(
                "D",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              )
            : Text(
                "F$i",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
      ),
    );
  }else if(j==destinations+1 && i == sources+1){
    return TableViewCell(child: SizedBox());
  }
  else {
    return TableViewCell(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        child: TextFormField(
          controller: controllers[i-1 ][j-1],
          validator: (value) {
            if(value?.isEmpty??false)return "";
            if(int.tryParse(value??"") == null)return "";
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
      ),
    );
  }
}