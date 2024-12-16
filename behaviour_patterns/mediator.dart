import 'dart:async';
//Behavioral Design Patterns - Mediator

// Abstrakte Klasse Mediator – definiert die Interface für die Kommunikation zwischen den Piloten
abstract class Mediator {
  void registerPilot(Pilot pilot);
  void requestLanding(Pilot pilot);
  void notifyRunwayCleared(Pilot pilot);
}

// Abstrakte Klasse Pilot – definiert die Basisfunktionalität für die Piloten
abstract class Pilot {
  final String name;
  Mediator? mediator;

  Pilot(this.name);

  // Fordert eine Landeerlaubnis beim Fluglotsen an
  void requestLanding() {
    print('$name: Fordert Landeerlaubnis an.');
    mediator?.requestLanding(this);
  }

  // Erhält Anweisungen vom Fluglotsen
  void receiveInstruction(String instruction) {
    print('$name erhält eine Anweisung vom Fluglotsen: $instruction');
    if (instruction.contains('Landeerlaubnis erteilt')) {
      // Wenn die Erlaubnis erteilt wurde, erfolgt die Landung nach einer Verzögerung
      Future.delayed(Duration(seconds: 2), landedAndClearedRunway);
    }
  }

  // Informiert den Fluglotsen über die Freigabe der Landebahn
  void landedAndClearedRunway() {
    print('$name: Landung abgeschlossen, Landebahn freigegeben.\n');
    mediator?.notifyRunwayCleared(this);
  }
}

// Konkrete Implementierung des Mediators – der Fluglotse
class Dispatcher implements Mediator {
  final List<Pilot> _pilots = [];
  Pilot? _pilotOnRunway;
  final List<Pilot> _waitingQueue = [];

  @override
  void registerPilot(Pilot pilot) {
    _pilots.add(pilot);
    pilot.mediator = this;

    // Nach der Registrierung fordert der Pilot automatisch eine Landeerlaubnis an
    Future.delayed(Duration(seconds: 1), pilot.requestLanding);
  }

  @override
  void requestLanding(Pilot pilot) {
    if (_pilotOnRunway == null) {
      // Die Landebahn ist frei – Erlaubnis wird erteilt
      _pilotOnRunway = pilot;
      pilot.receiveInstruction('Landeerlaubnis erteilt, Landebahn frei.');
    } else {
      // Die Landebahn ist belegt – der Pilot wird in die Warteschlange geschickt
      _waitingQueue.add(pilot);
      pilot.receiveInstruction('Landebahn belegt. Bitte warten Sie in der Warteschleife.');
    }
  }

  @override
  void notifyRunwayCleared(Pilot pilot) {
    if (_pilotOnRunway == pilot) {
      _pilotOnRunway = null;
      print('Fluglotse: Die Landebahn ist jetzt frei.');
      _givePermissionToNextPilot();
    }
  }

  void _givePermissionToNextPilot() {
    if (_waitingQueue.isNotEmpty) {
      final nextPilot = _waitingQueue.removeAt(0);
      _pilotOnRunway = nextPilot;
      nextPilot.receiveInstruction('Sie sind als nächster dran. Landeerlaubnis erteilt.');
    } else {
      // Wenn die Warteschlange leer ist, haben alle Piloten bereits gelandet
      if (_pilots.every((p) => p != _pilotOnRunway)) {
        print('Fluglotse: Alle Piloten haben erfolgreich gelandet!');
      }
    }
  }
}

//Klassen AirplanePilot und HelicopterPilot, die von der Klasse Pilot erben
class AirplanePilot extends Pilot {
  AirplanePilot(String name) : super(name);
}

class HelicopterPilot extends Pilot {
  HelicopterPilot(String name) : super(name);
}

void main() {
  final dispatcher = Dispatcher();

  final airplanePilot1 = AirplanePilot('Airbus-A320');
  final helicopterPilot1 = HelicopterPilot('Robinson R22');
  final airplanePilot2 = AirplanePilot('Boing-737');

  dispatcher.registerPilot(airplanePilot1);
  dispatcher.registerPilot(helicopterPilot1);
  dispatcher.registerPilot(airplanePilot2);
}
