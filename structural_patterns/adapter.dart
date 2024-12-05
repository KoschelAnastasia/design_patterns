//Structural Design Pattern: Adapter

// Interface für den amerikanischen Stecker
abstract class AmericanPlug {
  String connectToAmericanSocket();
  double get inputVoltage; // Spannung für amerikanische Steckdose
}

// Interface für den europäischen Stecker
abstract class EuropeanPlug {
  String connectToEuropeanSocket();
  double get inputVoltage; // Spannung für europäische Steckdose
}

// Adapter, um den europäischen Stecker in einer amerikanischen Steckdose zu verwenden
class EuropeanToAmericanAdapter implements AmericanPlug {
  final EuropeanPlug europeanPlug;

  EuropeanToAmericanAdapter(this.europeanPlug);

  @override
  String connectToAmericanSocket() =>
      europeanPlug.connectToEuropeanSocket() + " über einen Adapter an eine amerikanische Steckdose";

  @override
  double get inputVoltage => europeanPlug.inputVoltage - 120; // Spannung anpassen
}

// Implementierung des europäischen Steckers
class EuropeanPlugImpl implements EuropeanPlug {
  @override
  String connectToEuropeanSocket() => "Ein Europäischer Stecker wurde angeschlossen";

  @override
  double get inputVoltage => 230;
}

void main() {
  // Europäischer Stecker
  EuropeanPlug europeanPlug = EuropeanPlugImpl();

  // Adapter zum Anschließen an eine amerikanische Steckdose
  AmericanPlug adapter = EuropeanToAmericanAdapter(europeanPlug);

  // Verbindung über den Adapter
  print(adapter.connectToAmericanSocket());
  print("Die Spannung in der amerikanischen Steckdose beträgt: ${adapter.inputVoltage} V");
}
