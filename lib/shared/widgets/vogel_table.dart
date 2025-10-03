import 'package:flutter/material.dart';
import 'package:metodos_transporte/domain/entities/cell.dart';

class VogelTable extends StatelessWidget {
  const VogelTable({super.key, required this.transportProblem, required this.answers});
  final List<List<Cell>> transportProblem;
  final Map<String,int> answers;


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: _PaddedIntrisincWidth(),
          columnWidths: {
            0:FixedColumnWidth(60)
          },
          border: TableBorder.all(color: const Color.fromARGB(255, 177, 216, 235), width: 1),
          children: [
            ...List.generate(transportProblem.length+1, (i) {
              return TableRow(
                children: List.generate(transportProblem.first.length+1, (j) {
                  if(i == 0 && j == 0){
                    return Container(
                      color: Color(0xFFB71C1C),
                      height: 65,
                    );
                  }
                  if(i==0){
                    if(j==transportProblem.first.length-1){
                      return _CustomContainer(
                        child: Center(child: Text("O", style: TextStyle(color: Colors.white),)),
                      );
                    }
                    if(j==transportProblem.first.length){
                      return _CustomContainer(
                        child: Center(child: Text("P", style: TextStyle(color: Colors.white),)),

                      );

                    }
                    return _CustomContainer(
                      child: Center(child: Text("D$j", style: TextStyle(color: Colors.white),)),
                    );
                  }
                  if(j==0){
                    if(i==transportProblem.length-1){
                      return _CustomContainer(
                        child: Center(child: Text("D", style: TextStyle(color: Colors.white),)),
                      );
                    }
                    if(i==transportProblem.length){
                      return _CustomContainer(
                        child: Center(child: Text("P", style: TextStyle(color: Colors.white),)),
                      );
                    }
                    return _CustomContainer(
                      child: Center(child: Text("F$i", style: TextStyle(color: Colors.white),)),
                    );
                  }
                  if(j==transportProblem.first.length &&(i==transportProblem.length|| i == transportProblem.length-1)){
                    return SizedBox();
                  }

                  if(j==transportProblem.first.length || j == transportProblem.first.length-1){
                    return SizedBox(
                      height: 65,
                      child: Center(child: Text("${transportProblem[i-1][j-1].getValue().toInt()}")),
                    );
                  }

                  if(i==transportProblem.length || i == transportProblem.length-1){
                    return SizedBox(
                      height: 65,
                      child: Center(child: Text("${transportProblem[i-1][j-1].getValue().toInt()}")),
                    );
                  }

                  return _CustomCell(
                    cost: transportProblem[i-1][j-1].getValue(),
                    answer: (answers["$i-$j"]!=null)?answers["$i-$j"]:null,
                  );
                },)
              );
            },)
          ],
        ),
      ),
    );
  }
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
  const _CustomCell({required this.cost, this.answer});
  final double cost;
  final int? answer;

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
            child: Text((answer==null)?"":"$answer"),
          )
        ],
      ),
    );
  }
}

class _PaddedIntrisincWidth extends TableColumnWidth{

  @override
  double maxIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    final intrisincWidth = IntrinsicColumnWidth().minIntrinsicWidth(cells, containerWidth);
    if(intrisincWidth<=60)return 70;
    return intrisincWidth + 10;
  }

  @override
  double minIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    final intrisincWidth = IntrinsicColumnWidth().maxIntrinsicWidth(cells, containerWidth);
    if(intrisincWidth<=60)return 70;
    return intrisincWidth + 10;
  }

}