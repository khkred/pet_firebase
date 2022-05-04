import 'package:flutter/material.dart';
import 'package:pet_firebase/models/pet.dart';
import 'package:pet_firebase/screens/pet_ui.dart';

class ListPets extends StatefulWidget {

  List<Pet> petList;

  ListPets(this.petList);

  @override
  State<ListPets> createState() => _ListPetsState();
}

class _ListPetsState extends State<ListPets> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
          widget.petList.map((e) => PetUi(e)).toList()
        ,
      ),
    );
  }
}
