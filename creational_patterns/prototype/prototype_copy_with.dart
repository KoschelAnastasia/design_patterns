// Creational Design Patterns: Prototype
// CopyWith-Methode

abstract class Cloneable {
  Cloneable copyWith();
}

// Die Klasse Car repräsentiert ein Auto.
class Car implements Cloneable {
  final String model;
  final String color;
  final int year;
  final Engine engine;

  // Konstruktor für die Klasse Car
  Car(this.model, this.color, this.year, this.engine);

  // Methode zum Kopieren eines Autos mit oder ohne Änderungen
  @override
  Car copyWith({
    String? model,
    String? color,
    int? year,
    Engine? engine,
  }) {
    return Car(
      model ?? this.model,
      color ?? this.color,
      year ?? this.year,
      engine ?? this.engine,
    );
  }

  // Methode, um das Auto als String darzustellen
  @override
  String toString() {
    return 'Modell: $model, Farbe: $color, Baujahr: $year, Motor: ($engine)';
  }
}

// Die Klasse Engine repräsentiert einen Motor.
class Engine implements Cloneable {
  final String type;
  final int power;

  Engine(this.type, this.power);

  @override
  Engine copyWith({
    String? type,
    int? power,
  }) {
    return Engine(
      type ?? this.type,
      power ?? this.power,
    );
  }

  @override
  String toString() {
    return 'Typ: $type, Leistung: $power PS';
  }
}

void main() {
  // Erstellen eines Originalautos
  Car originalCar = Car('BMW X3', 'Rot', 2024, Engine('Diesel', 150));

  // Klonen des Autos und Ändern der Farbe und des Motortyps
  Car clonedCar = originalCar.copyWith(color: 'Blau', engine: Engine('Benzin', 150));

  print(
      'Original Auto: $originalCar'); // Original Auto: Modell: BMW X3, Farbe: Rot, Baujahr: 2024, Motor: (Typ: Diesel, Leistung: 150 PS)
  print(
      'Klon-Auto: $clonedCar'); // Klon-Auto: Modell: BMW X3, Farbe: Blau, Baujahr: 2024, Motor: (Typ: Benzin, Leistung: 150 PS)
}
