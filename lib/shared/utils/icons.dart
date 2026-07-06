import 'package:flutter/widgets.dart';

/// Создаёт IconData из кода символа, хранящегося в БД.
/// Коды иконок динамические (из данных), поэтому отключаем tree-shaking иконок
/// при сборке: `flutter build ... --no-tree-shake-icons`.
IconData materialIcon(int codePoint) =>
    // ignore: non_const_argument_for_const_parameter
    IconData(codePoint, fontFamily: 'MaterialIcons');
