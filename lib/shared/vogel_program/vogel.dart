import 'package:flutter/material.dart';
import 'package:metodos_transporte/domain/entities/cell.dart';
import 'package:metodos_transporte/shared/widgets/widgets.dart';

class Vogel {
	List<List<Cell>> vogelArray;
	late int sources;
	late int destinations;
	Map<int,double> rowsSmallest =  {};
	Map<int,double> columnsSmallest = {};
	Map<String,int> answers = {};
	double cost = 0;
	
	Vogel({required this.vogelArray,}){
    sources = vogelArray.length-1;
    destinations = vogelArray.first.length-1;
  }
	
	
	List<Widget> calculateVogelMethod() {
    List<VogelTable> tables = [];
    if(itsSolvable()){
      addPenalColumnsAndRows();
		  while(!isVogelCompleted()) {
		  	calculateSourcesPenal();
		  	calculateDestinationsPenal();
		  	assignResources(identifyGreaterPenal());
        final arrayCopy = vogelArray.map(
          (e)=>e.map((e) => e.copy(),).toList()).toList();
        final Map<String,int> answersCopy = Map.from(answers);

		  	tables.add(VogelTable(transportProblem: arrayCopy, answers: answersCopy));
		  }
      return tables;
    }else{
      return [
        SizedBox(
          child: Center(
            child: Text("No se puede resolver"),
          ),
        )
      ];
    }
	}

  bool itsSolvable(){
		int demandsSum = 0;
		int offerSum = 0;
		
		for(int i = 0; i<sources;i++) {
			offerSum +=vogelArray[i][destinations].getValue().toInt();
		}
		
		for(int i = 0; i<destinations;i++) {
			demandsSum += vogelArray[sources][i].getValue().toInt();
		}
    return (demandsSum == offerSum)?true:false;
  }

	bool isVogelCompleted() {
		int demandsSum = 0;
		int offerSum = 0;
		
		for(int i = 0; i<sources;i++) {
			offerSum +=vogelArray[i][destinations].getValue().toInt();
		}
		
		for(int i = 0; i<destinations;i++) {
			demandsSum += vogelArray[sources][i].getValue().toInt();
		}
		if(offerSum == 0 && demandsSum == 0 )return true;
		return false;
	}
	

  void addPenalColumnsAndRows(){
    for(List<Cell> row in vogelArray){
      row.add(Cell(value: 0));
    }
    vogelArray.add(List.generate(destinations+2, (index) => Cell(value: 0),));
  }

	void calculateSourcesPenal() {
		for(int i = 0; i<sources;i++) {
			if(isRowActive(i)) {
				double major = 0;
				for(int k = 0; k<destinations;k++) {
					Cell actual = vogelArray[i][k];
					if(actual.getValue() > major && actual.getIsActive()) {
						major = actual.getValue();
					}
				}
				double minor1 = major;
				double minor2 = major;
				for(int k = 0; k<destinations; k++) {
					Cell actual = vogelArray[i][k];
					if(actual.getValue() < minor1 && actual.getIsActive()) {
						minor2 = minor1;
						minor1 = actual.getValue();
					}
					if(actual.getValue()<minor2 && actual.getValue()>minor1 && actual.getIsActive()) {
						minor2= actual.getValue();
					}
				}
				rowsSmallest.addAll({i:minor1});
				vogelArray[i][destinations+1].setValue(minor2 - minor1); 				
			}else {
				vogelArray[i][destinations+1].setValue(0); 								
			}

			
		}
	}
	
	void calculateDestinationsPenal() {
		for(int i = 0; i<destinations;i++) {
			if(isColumnActive(i)) {
				double major = 0;
				for(int k = 0; k<sources;k++) {
					Cell actual = vogelArray[k][i];
					if(actual.getValue()>major && actual.getIsActive()) {
						major = actual.getValue();
					}
				}
				double minor1 = major;
				double minor2 = major;
				for(int k = 0; k<sources;k++) {
					Cell actual = vogelArray[k][i];
					if(actual.getValue() < minor1 && actual.getIsActive()) {
						minor2 = minor1;
						minor1 = actual.getValue();
					}
					if(actual.getValue()<minor2 && actual.getValue()>minor1 && actual.getIsActive()) {
						minor2= actual.getValue();
					}
				}
				columnsSmallest.addAll({i:minor1});
				vogelArray[sources+1][i].setValue(minor2-minor1); 				
			}else {
				vogelArray[sources+1][i].setValue(0); 				
				
			}
		}
	}
	
	double identifyGreaterPenal(){
		double greaterPenal = 0;
		for(int i = 0; i<destinations;i++) {
			Cell actual = vogelArray[sources+1][i];
			if(actual.getValue()>greaterPenal && actual.getIsActive()) {
				greaterPenal = actual.getValue();
			}
		}
		for(int i = 0; i<sources;i++) {
			Cell actual = vogelArray[i][destinations+1];
			if(actual.getValue()>greaterPenal && actual.getIsActive()) {
				greaterPenal = actual.getValue();
			}
		}
		return greaterPenal;
	}
	
	void assignResources(double greaterPenal) {
		bool founded = false;
		for(int i = 0;i<sources && !founded;i++) {
			Cell actual = vogelArray[i][destinations+1];
			if(actual.getIsActive() && actual.getValue() == greaterPenal) {
				founded = true;
				bool assigned = false;
				for(int k = 0; k < destinations && !assigned;k++) {
					Cell current = vogelArray[i][k];
					if(current.getValue() == rowsSmallest[i] && current.getIsActive()) {
						Cell offer = vogelArray[i][destinations];
						Cell demand = vogelArray[sources][k];
						if(demand.getValue()>offer.getValue()) {
							answers.addAll({"${i+1}-${k+1}": offer.getValue().toInt()});
							demand.setValue(demand.getValue() - offer.getValue());
							offer.setValue(0);
							turnOffRow(i);
							assigned = true;
						}
						if(offer.getValue()> demand.getValue()) {
							answers.addAll({"${i+1}-${k+1}": demand.getValue().toInt()});
							offer.setValue(offer.getValue()-demand.getValue());
							demand.setValue(0);
							turnOffColumn(k);
							assigned = true;
						}
						if(offer.getValue() == demand.getValue()) {
							answers.addAll({"${i+1}-${k+1}": demand.getValue().toInt()});
							offer.setValue(0);
							demand.setValue(0);
							turnOffColumn(k);
							turnOffRow(i);
							assigned = true;
						}
					}
				}
				
			}
		}
		
		for(int i = 0; i<destinations && !founded;i++) {
			Cell actual = vogelArray[sources+1][i];
			if(actual.getIsActive() && actual.getValue() == greaterPenal) {
				founded = true;
				bool assigned = false;
				for(int k = 0; k< sources && !assigned;k++) {
					Cell current = vogelArray[k][i];
					if(current.getValue() == columnsSmallest[i] && current.getIsActive()) {
						Cell offer = vogelArray[k][destinations];
						Cell demand = vogelArray[sources][i];
						if(demand.getValue()>offer.getValue()) {
							answers.addAll({"${k+1}-${i+1}": offer.getValue().toInt()});
							demand.setValue(demand.getValue() - offer.getValue());
							offer.setValue(0);
							turnOffRow(k);
							assigned = true;
						}
						if(offer.getValue()> demand.getValue()) {
							answers.addAll({"${k+1}-${i+1}": demand.getValue().toInt()});
							offer.setValue(offer.getValue()-demand.getValue());
							demand.setValue(0);
							turnOffColumn(i);
							assigned = true;
						}
						if(offer.getValue() == demand.getValue()) {
							answers.addAll({"${k+1}-${i+1}": demand.getValue().toInt()});
							offer.setValue(0);
							demand.setValue(0);
							turnOffColumn(i);
							turnOffRow(k);
							assigned = true;
						}
					}
				}
			}
		}
	}
	
	void turnOffColumn(int column) {
		for(int i = 0; i<sources+2; i++) {
			vogelArray[i][column].setIsActive(false);
		}
	}
	
	void turnOffRow(int row) {
		for(int i = 0; i<destinations+2; i++) {
			vogelArray[row][i].setIsActive(false);
		}
	}
	
	bool isRowActive(int rowNumber) {
		if(!vogelArray[rowNumber][destinations].getIsActive())return false;
		return true;
	}
	
	bool isColumnActive(int columnNumber) {
		if(!vogelArray[sources][columnNumber].getIsActive())return false;
		return true;
	}
		
	void showArray() {
		for(int i = 0; i<vogelArray.length;i++) {
			for(int k = 0; k<vogelArray[i].length;k++) {
			  print("${vogelArray[i][k].getValue()} ");
			}
			  print("");
		}
		print("Respuestas");
		answers.forEach((key,value){
			print("${key} - ${value}");
    });
	}
	
}
