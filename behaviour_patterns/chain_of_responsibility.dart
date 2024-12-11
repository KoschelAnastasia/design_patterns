abstract class PoliceOfficer {
  PoliceOfficer? nextOfficer;

  // Methode zur Fallbearbeitung
  void handleCase(String caseType);

  // Setzt den nächsten Polizisten
  void setNext(PoliceOfficer next) {
    nextOfficer = next;
  }
}

class RegularPolice extends PoliceOfficer {
  @override
  void handleCase(String caseType) {
    if (caseType == 'simple theft') {
      print("Der normale Polizist löst einen einfachen Diebstahlsfall.");
    } else {
      print("Der normale Polizist kann diesen Fall nicht lösen. Weiterleitung.");
      nextOfficer?.handleCase(caseType);
    }
  }
}

class Detective extends PoliceOfficer {
  @override
  void handleCase(String caseType) {
    if (caseType == 'complicated theft' || caseType == 'fraud') {
      print("Der Detektiv untersucht einen komplexen Fall.");
    } else {
      print("Der Detektiv kann diesen Fall nicht lösen. Weiterleitung.");
      nextOfficer?.handleCase(caseType);
    }
  }
}

class Investigator extends PoliceOfficer {
  @override
  void handleCase(String caseType) {
    if (caseType == 'murder') {
      print("Der Ermittler untersucht einen Mordfall.");
    } else {
      print("Der Ermittler kann diesen Fall nicht lösen. Anfrage nicht bearbeitet.");
    }
  }
}

void main() {
  // Erstelle eine Kette von Polizisten
  PoliceOfficer regularPolice = RegularPolice();
  PoliceOfficer detective = Detective();
  PoliceOfficer investigator = Investigator();

  // Setze die Reihenfolge der Bearbeitung
  regularPolice.setNext(detective);
  detective.setNext(investigator);

  // Der Klient reicht den Fall ein
  print("Der Polizist erhält einen Diebstahlsfall:");
  regularPolice.handleCase('simple theft');

  print("\nDer Polizist erhält einen Betrugsfall:");
  regularPolice.handleCase('fraud');

  print("\nDer Polizist erhält einen Mordfall:");
  regularPolice.handleCase('murder');

  print("\nDer Polizist erhält einen sehr komplexen Fall:");
  regularPolice.handleCase('unknown case');
}
