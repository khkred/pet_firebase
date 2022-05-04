import 'package:flutter/material.dart';
import 'package:pet_firebase/models/pet.dart';

class PetUi extends StatefulWidget {
  final Pet singlePet;

  PetUi(this.singlePet);

  @override
  State<PetUi> createState() => _PetUiState();
}

class _PetUiState extends State<PetUi> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
        Container(height: 200, width: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(
            100)),
        child: Image.asset("assets/dogs.jpg")),
    Text(widget.singlePet.name),
    ]
    ,
    );
  }
}
