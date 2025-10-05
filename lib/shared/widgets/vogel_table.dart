import 'package:flutter/material.dart';
import 'package:metodos_transporte/domain/entities/cell.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class VogelTable extends StatelessWidget {
  const VogelTable({super.key, required this.transportProblem, required this.answers});
  final List<List<Cell>> transportProblem;
  final Map<String,int> answers;


  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: TableView.builder(
        rowCount: transportProblem.length+1,
        columnCount: transportProblem.first.length+1,
        diagonalDragBehavior: DiagonalDragBehavior.free,
        columnBuilder: (index) {
          return TableSpan(
            extent: FixedSpanExtent(70),
            backgroundDecoration: TableSpanDecoration(
              border: SpanBorder(trailing: BorderSide(color: const Color.fromARGB(255, 177, 216, 235),width: 1))
            )
          );
        },
        rowBuilder: (index){
          return TableSpan(
            extent: FixedSpanExtent(65),
            backgroundDecoration: TableSpanDecoration(
              border: SpanBorder(trailing: BorderSide(color: const Color.fromARGB(255, 177, 216, 235),width: 1))
            )
          );
        },
        cellBuilder: (context, vicinity) => _buildCell(vicinity.row, vicinity.column, transportProblem, answers),
      ),
    );
      
    
  }
}


TableViewCell _buildCell(int i, int j, List<List<Cell>> transportProblem, Map<String,int> answers){
  if(i == 0 && j == 0){
    return TableViewCell(
      child: Container(
        color: Color(0xFFB71C1C),
        height: 65,
      ),
    );
  }
  if(i==0){
    if(j==transportProblem.first.length-1){
      return TableViewCell(
        child: _CustomContainer(
          child: Center(child: Text("O", style: TextStyle(color: Colors.white),)),
        ),
      );
    }
    if(j==transportProblem.first.length){
      return TableViewCell(
        child: _CustomContainer(
          child: Center(child: Text("P", style: TextStyle(color: Colors.white),)),
        
        ),
      );

    }
    return TableViewCell(
      child: _CustomContainer(
        child: Center(child: Text("D$j", style: TextStyle(color: Colors.white),)),
      ),
    );
  }
  if(j==0){
    if(i==transportProblem.length-1){
      return TableViewCell(
        child: _CustomContainer(
          child: Center(child: Text("D", style: TextStyle(color: Colors.white),)),
        ),
      );
    }
    if(i==transportProblem.length){
      return TableViewCell(
        child: _CustomContainer(
          child: Center(child: Text("P", style: TextStyle(color: Colors.white),)),
        ),
      );
    }
    return TableViewCell(
      child: _CustomContainer(
        child: Center(child: Text("F$i", style: TextStyle(color: Colors.white),)),
      ),
    );
  }
  if((j==transportProblem.first.length||j==transportProblem.first.length-1) &&(i==transportProblem.length|| i == transportProblem.length-1)){
    return TableViewCell(child: SizedBox());
  }

  if(j==transportProblem.first.length || j == transportProblem.first.length-1){
    final isOff = !transportProblem[transportProblem.length-2][j-1].getIsActive()|| 
      !transportProblem[i-1][transportProblem.first.length-2].getIsActive();
    return TableViewCell(
      child: Stack(
        children: [
          SizedBox(
            height: 65,
            child: Center(child: Text("${transportProblem[i-1][j-1].getValue().toInt()}")),
          ),
          if(isOff)Container(
            color: Colors.blueGrey.withOpacity(0.3),
          )
        ],
      ),
    );
  }

  if(i==transportProblem.length || i == transportProblem.length-1){
    final isOff = !transportProblem[transportProblem.length-2][j-1].getIsActive()|| 
      !transportProblem[i-1][transportProblem.first.length-2].getIsActive();

    return TableViewCell(
      child: Stack(
        children: [
          SizedBox(
            height: 65,
            child: Center(child: Text("${transportProblem[i-1][j-1].getValue().toInt()}")),
          ),
          if(isOff)Container(
            color: Colors.blueGrey.withOpacity(0.3),
          )
        ],
      ),
    );
  }

  return TableViewCell(
    child: _CustomCell(
      cost: transportProblem[i-1][j-1].getValue(),
      answer: (answers["$i-$j"]!=null)?answers["$i-$j"]:null,
      isOff: !transportProblem[transportProblem.length-2][j-1].getIsActive()
      || !transportProblem[i-1][transportProblem.first.length-2].getIsActive(),
    ),
  );
}


class _CustomContainer extends StatelessWidget {
  const _CustomContainer({required this.child });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Color(0xFFB71C1C),
      height: 65,
      child: child,
    );
  }
}

class _CustomCell extends StatelessWidget {
  const _CustomCell({required this.cost, this.answer,this.isOff = false});
  final double cost;
  final int? answer;
  final bool isOff;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentGeometry.topRight,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              child: Text((cost%1==0)?"${cost.toInt()}":"$cost"),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.xy(0, 0.65),
            child: (answer == null)?SizedBox():CircleAvatar(
              backgroundColor: Color.fromARGB(255, 235, 2, 2),
              child: Text("$answer", style: TextStyle(color: Colors.white),),
            ),
          ),
          if(isOff)Container(
            color: Colors.blueGrey.withOpacity(0.3),
          )
        ],
      ),
    );
  }
}