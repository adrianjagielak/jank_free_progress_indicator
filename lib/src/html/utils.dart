import 'dart:ui';

String colorToCssColor(Color color) {
  return 'rgba(${_floatToInt8(color.r)},${_floatToInt8(color.g)},${_floatToInt8(color.b)},${color.a})';
}

int _floatToInt8(double x) {
  return (x * 255.0).round() & 0xff;
}
