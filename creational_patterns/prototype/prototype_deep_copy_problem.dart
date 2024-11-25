// Creational Design Patterns: Prototype - Problem

// Die Klasse Cloneable repräsentiert ein Objekt, das geklont werden kann.
abstract class Cloneable {
  Cloneable clone();
}

// Die Klasse Car repräsentiert ein Auto.
class Car implements Cloneable {
  String model;
  String color;
  int year;
  Engine engine;

  // Konstruktor für die Klasse Car
  Car(this.model, this.color, this.year, this.engine);

  // Konstruktor zum Klonen eines Autos
  Car.from(Car car)
      : model = car.model,
        color = car.color,
        year = car.year,
        engine = car.engine;

  // Methode zum Klonen des Autos
  @override
  Car clone() {
    return Car.from(this);
  }

  // Methode, um das Auto als String darzustellen
  @override
  String toString() {
    return 'Modell: $model, Farbe: $color, Baujahr: $year, Motor: ($engine)';
  }
}

class Engine {
  String type;
  int power;

  Engine(this.type, this.power);

  @override
  String toString() {
    return 'Typ: $type, Leistung: $power PS';
  }
}

void main() {
  // Erstellen eines Originalautos
  Car originalCar = Car('BMW X3', 'Rot', 2024, Engine('Diesel', 150));
  print('Original Auto: $originalCar'); // Original Auto: Modell: BMW X3, Farbe: Rot, Baujahr: 2024

  // Klonen des Autos
  Car clonedCar = originalCar.clone();
  print('Klon-Auto: $clonedCar'); // Klon-Auto: Modell: BMW X3, Farbe: Rot, Baujahr: 2024

  print('\nIs originalCar and clonedCar the same object? ${originalCar == clonedCar}'); // false

  // Ändern der Farbe des geklonten Autos
  clonedCar.color = 'Blau';
  clonedCar.engine.type = 'Benzin';
  print('\nNach der Änderung:');
  print(
      'Original Auto: $originalCar'); // Original Auto: Modell: BMW X3, Farbe: Rot, Baujahr: 2024, Motor: (Typ: Benzin, Leistung: 150 PS)
  print(
      'Klon-Auto: $clonedCar'); // Klon-Auto: Modell: BMW X3, Farbe: Blau, Baujahr: 2024, Motor: (Typ: Benzin, Leistung: 150 PS)
}
