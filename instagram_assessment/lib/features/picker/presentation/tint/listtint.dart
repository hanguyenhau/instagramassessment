import 'package:flutter/material.dart';
import 'package:instagram_assessment/features/picker/presentation/tint/tint.dart';

class Tints{
  List<Tint> list(){
    return [
      Tint(color: Colors.orange),
      Tint(color: Colors.green),
      Tint(color: Colors.yellow),
      Tint(color: Colors.blue),
      Tint(color: Colors.pink),
      Tint(color: Colors.red),
      Tint(color: Colors.purple),
    ];
  }
}