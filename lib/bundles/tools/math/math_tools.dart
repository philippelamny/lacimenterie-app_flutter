class MathTools {
  static double calcPourcentage(total, value) {
    if (total == 0) return 1;

    var pourcent = (value * 100 / total).round().abs() ;
    return pourcent / 100;
  }
}