extension BoolExtension on bool {

  int get  toInt => this== true? 1:0;
}

extension IntExtension on int {

  bool get  toBool => this== 1? true:false;
}