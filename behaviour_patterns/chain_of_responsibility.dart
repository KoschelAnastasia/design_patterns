class CriminalAction {
  final int complexity; // Schwierigkeitsgrad des Falls
  final String description; // Kurze Beschreibung des Verbrechens

  CriminalAction(this.complexity, this.description);
}

abstract class Policeman {
  final String name;
  final String rank;
  final int deduction;
  Policeman? next;

  Policeman(this.deduction, this.name, this.rank);

  // Methode zum Festlegen des nächsten Polizisten in der Kette
  Policeman setNext(Policeman policeman) {
    next = policeman;
    return policeman;
  }

  // Methode zum Starten der Ermittlung
  void investigate(CriminalAction criminalAction) {
    if (deduction < criminalAction.complexity) {
      print("Fall '${criminalAction.description}' ist zu komplex für $rank $name (Deduktionsstufe: $deduction).");
      if (next != null) {
        print("Übergabe des Falls an Polizisten ${next!.name}");
        next!.investigate(criminalAction);
      } else {
        print("Dieser Fall kann von niemandem gelöst werden.");
      }
    } else {
      investigateConcrete(criminalAction.description);
    }
  }

  // Methode zur spezifischen Ermittlung
  void investigateConcrete(String description) {
    print("Die Ermittlung des Falls '$description' wird von $rank $name durchgeführt.\n");
  }
}

class MartinRiggs extends Policeman {
  MartinRiggs(int deduction) : super(deduction, "Martin Riggs", "Sergeant");
}

class JohnMcClane extends Policeman {
  JohnMcClane(int deduction) : super(deduction, "John McClane", "Detektiv");
}

class MaxPayne extends Policeman {
  MaxPayne(int deduction) : super(deduction, "Max Payne", "Detektiv");
}

void main() {
  print("Verantwortungskette (Chain of Responsibility)\n");

  Policeman policeman = MartinRiggs(3)
    ..setNext(JohnMcClane(5))
    ..setNext(MaxPayne(8));

  policeman.investigate(CriminalAction(2, "Drogenhandel aus Vietnam"));
  policeman.investigate(CriminalAction(5, "Geiselnahme in einem Wolkenkratzer in Los Angeles"));
  policeman.investigate(CriminalAction(7, "Mord an einer Journalistin in New York"));
  policeman.investigate(CriminalAction(10, "Suche nach einem Detonator im Zentrum von Gotham"));
}
