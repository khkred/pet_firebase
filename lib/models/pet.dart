/**
 * Pet Model Class
 */

class Pet {
  final String name;
  final int age;
  final double weight;
  final String breed;
  final List<String> vaccinationDates = [];


  Pet({
    required this.name,
    required this.age,
    required this.weight,
    required this.breed,
});

  void addVaccination(String vaccinationDate) {
    vaccinationDates.add(vaccinationDate);
  }
}