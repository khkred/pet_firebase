import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_firebase/models/pet.dart';

class AddPetScreen extends StatefulWidget {

  Function addPets;

  AddPetScreen(this.addPets);

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  DateTime selectedDate = DateTime.now();

  String petName = "";
  int petAge = 0;
  double petWeight = 0;
  String petBreed = "";
  String vaccinationDate = "";

  _selectDate(BuildContext context) async {

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                //Name
                TextFormField(
                  decoration: InputDecoration(hintText: "Pet's Name"),
                  onChanged: (name) {
                    setState(() {
                      petName = name;
                    });
                  },
                ),
                //Age
                TextFormField(
                  decoration: InputDecoration(hintText: "Pet's Age"),
                  keyboardType: TextInputType.number,
                  onChanged: (age) {
                    setState(() {
                      petAge = int.parse(age);
                    });
                  },
                ),
                //Weight
                TextFormField(
                  decoration: InputDecoration(hintText: "Pet's Weight"),
                  keyboardType: TextInputType.number,
                  onChanged: (weight) {
                    setState(() {
                      petWeight = double.parse(weight);
                    });
                  },
                ),
                //Breed
                TextFormField(
                  decoration: InputDecoration(hintText: "Pet's Breed"),
                  onChanged: (breed) {
                    setState(() {
                      petBreed = breed;
                    });
                  },
                ),
                //Vaccination we'll use a date Picker
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Pick Date"),
                      ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text("Date Picker"))
                    ],
                  ),
                ),

                Container(

                    margin: const EdgeInsets.only(top: 90),
                    child: ElevatedButton(
                        onPressed: () {
                          if (petName.isEmpty ||
                              petAge == 0 ||
                              petWeight == 0 ||
                              petBreed.isEmpty) {
                            const snackBar = SnackBar(
                              content: Text("One of these fields is empty"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            vaccinationDate =
                            "${selectedDate.day}-${selectedDate
                                .month}-${selectedDate.year}";
                            Pet addedPet = Pet(
                                name: petName,
                                age: petAge,
                                weight: petWeight,
                                breed: petBreed);
                            addedPet.addVaccination(vaccinationDate);

                            var pet = Pet(name: petName, age: petAge, weight: petWeight, breed: petBreed);

                            widget.addPets(pet);

                            addPetToFireStore(addedPet);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Upload Pet")))
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<DocumentReference> addPetToFireStore(Pet addedPet) {
    return FirebaseFirestore.instance
        .collection('petsDetails')
        .add(<String, dynamic>{
      "petName": addedPet.name,
      "petAge": addedPet.age,
      "petWeight": addedPet.weight,
      "petBreed": addedPet.breed,
      "vaccination": addedPet.vaccinationDates
    });
  }
}
