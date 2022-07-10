import 'package:flutter/material.dart';

abstract class Global {
  static const Color pink = Color.fromARGB(255, 248, 89, 190);

  static const List places = [
    {
      'location': 'Lugar de Interesse 1',
      'name': 'UM',
      'status': false,
      'position': [0.06, 0.06],
      'tile': 6,
    },
    {
      'location': 'Lugar de Interesse 2',
      'name': 'DOIS',
      'status': true,
      'position': [0.03, -0.1],
      'tile': 10,
    },
    {
      'location': 'Lugar de Interesse 3',
      'name': 'TRÊS',
      'status': false,
      'position': [0.08, -0.05],
      'tile': 10,
    }
  ];
}
