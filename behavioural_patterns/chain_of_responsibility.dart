//Behavioral Design Patterns - Chain of Responsibility

//Klasse, die die Informationen über die kriminelle Handlung enthält
class CriminalAction {
  final int complexity;
  final String description;

  CriminalAction(this.complexity, this.description);
}

//Abstrakte Klasse Policeman
abstract class Policeman {
  final String name;
  final String rank;
  Policeman? next;

  Policeman(this.name, this.rank);

  int get deduction;

  // Methode zum Festlegen des nächsten Polizisten in der Kette
  Policeman setNext(Policeman policeman) {
    next = policeman;
    return policeman;
  }

  // Methode zum Starten der Ermittlung
  void handleCase(CriminalAction criminalAction) {
    if (deduction < criminalAction.complexity) {
      print("Fall '${criminalAction.description}' ist zu komplex für $rank $name (Deduktionsstufe: $deduction).");
      if (next != null) {
        print("Übergabe des Falls an Polizisten ${next!.name}");
        next!.handleCase(criminalAction);
      } else {
        print("Dieser Fall kann von niemandem gelöst werden.");
      }
    } else {
      investigateCase(criminalAction.description);
    }
  }

  // Methode zur spezifischen Ermittlung
  void investigateCase(String description) {
    print("Die Ermittlung des Falls '$description' wird von $rank $name durchgeführt.\n");
  }
}

//Klassen, die von der abstrakten Klasse Policeman erben
class MartinRiggs extends Policeman {
  MartinRiggs() : super("Martin Riggs", "Sergeant");

  @override
  int get deduction => 3;
}

class JohnMcClane extends Policeman {
  JohnMcClane() : super("John McClane", "Detektiv");

  @override
  int get deduction => 5;
}

class MaxPayne extends Policeman {
  MaxPayne() : super("Max Payne", "Detektiv");

  @override
  int get deduction => 8;
}

void main() {
  print("Verantwortungskette (Chain of Responsibility)\n");

  Policeman policeman = MartinRiggs();
  policeman.setNext(JohnMcClane()).setNext(MaxPayne());

  policeman.handleCase(CriminalAction(2, "Drogenhandel aus Vietnam"));
  policeman.handleCase(CriminalAction(5, "Geiselnahme in einem Wolkenkratzer in Los Angeles"));
  policeman.handleCase(CriminalAction(7, "Mord an einer Journalistin in New York"));
  policeman.handleCase(CriminalAction(10, "Der Mord an Laura Palmer in Twin Peaks"));
}
