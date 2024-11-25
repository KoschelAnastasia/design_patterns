// Creational Design Patterns: Builder

// Die Hauptklasse House repräsentiert ein Haus mit verschiedenen Eigenschaften.
class House {
  int rooms;
  int floors;
  bool hasGarage;
  bool hasPool;

  // Konstruktor für die House-Klasse
  House({
    required this.rooms,
    required this.floors,
    this.hasGarage = false,
    this.hasPool = false,
  });

  // Methode, um das Haus als String darzustellen
  @override
  String toString() {
    return 'Haus: $rooms Zimmer, $floors Etagen, '
        'Garage: ${hasGarage ? "ja" : "nein"}, '
        'Schwimmbad: ${hasPool ? "ja" : "nein"}';
  }
}

// Die HouseBuilder-Klasse implementiert den "Builder"-Entwurfsmuster.
// Sie dient dazu, ein Haus schrittweise zu erstellen.
class HouseBuilder {
  int _rooms = 0;
  int _floors = 0;
  bool _hasGarage = false;
  bool _hasPool = false;

  // Methode, um die Anzahl der Zimmer zu setzen
  HouseBuilder setRooms(int rooms) {
    _rooms = rooms;
    return this;
  }

  // Methode, um die Anzahl der Etagen zu setzen
  HouseBuilder setFloors(int floors) {
    _floors = floors;
    return this;
  }

  // Methode, um eine Garage hinzuzufügen
  HouseBuilder addGarage() {
    _hasGarage = true;
    return this;
  }

  // Methode, um einen Pool hinzuzufügen
  HouseBuilder addPool() {
    _hasPool = true;
    return this;
  }

  // Methode, die das fertige House-Objekt erstellt und zurückgibt
  House build() {
    return House(
      rooms: _rooms,
      floors: _floors,
      hasGarage: _hasGarage,
      hasPool: _hasPool,
    );
  }

  // Methode zum Zurücksetzen der Builder-Instanz
  void reset() {
    _rooms = 0;
    _floors = 0;
    _hasGarage = false;
    _hasPool = false;
  }
}

// Die HouseDirector-Klasse steuert den Bauprozess.
// Sie definiert verschiedene vordefinierte "Baupläne".
class HouseDirector {
  final HouseBuilder builder;

  // Konstruktor, der den Builder entgegennimmt
  HouseDirector(this.builder);

  // Methode zum Erstellen eines Standardhauses
  House constructStandardHouse() {
    builder.reset(); // Builder zurücksetzen
    return builder.setRooms(3).setFloors(2).addGarage().build();
  }

  // Methode zum Erstellen eines Luxushauses
  House constructLuxuryHouse() {
    builder.reset(); // Builder zurücksetzen
    return builder.setRooms(5).setFloors(3).addGarage().addPool().build();
  }

  // Methode zum Erstellen eines minimalen Hauses
  House constructMinimalHouse() {
    builder.reset(); // Builder zurücksetzen
    return builder.setRooms(1).setFloors(1).build();
  }
}

void main() {
  // Ein neuer HouseBuilder wird erstellt
  HouseBuilder builder = HouseBuilder();
  // Ein neuer HouseDirector wird erstellt und der Builder übergeben
  HouseDirector director = HouseDirector(builder);

  // Verschiedene Häuser werden erstellt und ausgegeben
  House standardHouse = director.constructStandardHouse();
  print(standardHouse); // Haus: 3 Zimmer, 2 Etagen, Garage: ja, Schwimmbad: nein

  House luxuryHouse = director.constructLuxuryHouse();
  print(luxuryHouse); // Haus: 5 Zimmer, 3 Etagen, Garage: ja, Schwimmbad: ja

  House minimalHouse = director.constructMinimalHouse();
  print(minimalHouse); // Haus: 1 Zimmer, 1 Etage, Garage: nein, Schwimmbad: nein
}
