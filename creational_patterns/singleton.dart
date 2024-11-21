// Die Singleton-Klasse repräsentiert einen Präsidenten
class President {
  // Statische Variable, die die einzige Instanz speichert
  static final President _instance = President._internal();

  // Privater Konstruktor
  President._internal();

  // Fabrikmethode gibt immer die gleiche Instanz zurück
  factory President() {
    return _instance;
  }

  // Methode, um den Namen des Präsidenten auszugeben
  void getName() {
    print('Der Name des Präsidenten ist Wladimir');
  }
}

void main() {
  // Zwei Referenzen auf dieselbe Instanz erstellen
  var president1 = President();
  var president2 = President();

  // Überprüfen, ob beide Referenzen identisch sind
  print(president1 == president2); // true

  // Die Methode aufrufen, die den Namen des Präsidenten nennt
  president1.getName(); // Der Name des Präsidenten ist Wladimir
  president2.getName(); // Der Name des Präsidenten ist Wladimir
}
