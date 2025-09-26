class Cell {
  double _value = 0;
  bool _isActive = false;
  Cell({required double value, bool isActive = false}){
    setValue(value);
    setIsActive(isActive);
  }

  double getValue()=>_value;

  void setValue(double value){
    _value = (value>0)?value:0;
  }

  bool getIsActive()=>_isActive;

  void setIsActive(bool isActive){
    _isActive = isActive;
  }


  Map<String,dynamic> toJson()=>{
    "value":_value,
    "isActive":_isActive
  };

  factory Cell.fromJson(Map<String,dynamic> json){
    return Cell(
      value: double.tryParse(json["value"])??0.0,
      isActive: json["isActive"]
    );
  }

} 