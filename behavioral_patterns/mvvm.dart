import 'dart:io';

// ======================
// 1. MODEL
// ======================

enum CoffeeType { espresso, americano, latte }

extension CoffeeInfo on CoffeeType {
  String get name {
    switch (this) {
      case CoffeeType.espresso:
        return 'Espresso';
      case CoffeeType.americano:
        return 'Americano';
      case CoffeeType.latte:
        return 'Latte';
    }
  }

  double get price {
    switch (this) {
      case CoffeeType.espresso:
        return 1.5;
      case CoffeeType.americano:
        return 2.0;
      case CoffeeType.latte:
        return 2.5;
    }
  }
}

/// Logik des Kaffeeautomaten: Verfügbarkeit prüfen, Abbuchung, Berechnung des Wechselgeldes
class CoffeeMachine {
  final Map<CoffeeType, int> _stock = {CoffeeType.espresso: 5, CoffeeType.americano: 5, CoffeeType.latte: 5};

  bool isAvailable(CoffeeType type) => _stock[type]! > 0;

  /// Versuch des Verkaufs. Gibt entweder eine Fehlermeldung oder ein Erfolgsergebnis zurück.
  /// Bei erfolgreichem Verkauf vermindert den Bestand und gibt das Wechselgeld zurück.
  CoffeeVendResult vend(CoffeeType type, double paid) {
    if (!isAvailable(type)) {
      return CoffeeVendResult.failure('${type.name} ist nicht mehr auf Lager.');
    }
    final price = type.price;
    if (paid < price) {
      final need = (price - paid).toStringAsFixed(2);
      return CoffeeVendResult.failure('Unzureichende Mittel: Es fehlen noch €${need}.');
    }
    _stock[type] = _stock[type]! - 1;
    final change = (paid - price);
    return CoffeeVendResult.success(
      message:
          'Ausgegeben: ${type.name}. Preis: €${price.toStringAsFixed(2)}. Wechselgeld: €${change.toStringAsFixed(2)}. Verbleibend: ${_stock[type]}.',
      change: change,
    );
  }
}

class CoffeeVendResult {
  final bool success;
  final String message;
  final double change;

  CoffeeVendResult._(this.success, this.message, this.change);

  factory CoffeeVendResult.success({required String message, required double change}) =>
      CoffeeVendResult._(true, message, change);

  factory CoffeeVendResult.failure(String message) => CoffeeVendResult._(false, message, 0.0);
}

// ======================
// 2. VIEWMODEL
// ======================

class CoffeeViewModel {
  final CoffeeMachine _machine;

  CoffeeType? _selectedType;
  double _paid = 0.0;

  CoffeeViewModel(this._machine);

  /// Liste verfügbarer Getränke
  List<CoffeeType> get menu => CoffeeType.values;

  /// Ausgewähltes Getränk (oder null)
  CoffeeType? get selectedType => _selectedType;

  /// Vom Benutzer bereits eingezahlter Betrag
  double get paid => _paid;

  /// Noch einzuzahlender Betrag für den Kauf
  double get remaining {
    if (_selectedType == null) return 0.0;
    return (_selectedType!.price - _paid).clamp(0.0, double.infinity);
  }

  /// Auswahl des Getränks anhand des Index im Menü
  String selectCoffee(int index) {
    if (index < 0 || index >= menu.length) {
      return 'Ungültige Auswahl, bitte wählen Sie eine Nummer von 1 bis ${menu.length}.';
    }
    _selectedType = menu[index];
    _paid = 0.0;
    return 'Sie haben ${_selectedType!.name} ausgewählt. Preis: €${_selectedType!.price.toStringAsFixed(2)}.';
  }

  /// Münzen einzahlen
  String insertMoney(double amount) {
    if (_selectedType == null) {
      return 'Wählen Sie zuerst ein Getränk.';
    }
    if (amount <= 0) {
      return 'Bitte geben Sie einen positiven Betrag ein.';
    }
    _paid += amount;
    if (_paid < _selectedType!.price) {
      return 'Eingezahlt: €${_paid.toStringAsFixed(2)}. Es fehlen noch €${remaining.toStringAsFixed(2)}.';
    } else {
      return 'Eingezahlt: €${_paid.toStringAsFixed(2)}.';
    }
  }

  /// Kaufversuch
  CoffeeVendResult buy() {
    if (_selectedType == null) {
      return CoffeeVendResult.failure('Wählen Sie zuerst ein Getränk.');
    }
    final result = _machine.vend(_selectedType!, _paid);
    // Nach dem Versuch Zustand zurücksetzen
    _selectedType = null;
    _paid = 0.0;
    return result;
  }
}

// ======================
// 3. VIEW (Konsolenansicht)
// ======================

class ConsoleView {
  final CoffeeViewModel vm;

  ConsoleView(this.vm);

  void run() {
    while (true) {
      _printMenu();
      stdout.write('Wählen Sie Kaffee per Nummer (oder q zum Beenden): ');
      final choice = stdin.readLineSync()?.trim();
      if (choice == null || choice.toLowerCase() == 'q') {
        print('Auf Wiedersehen!');
        break;
      }

      final idx = int.tryParse(choice);
      if (idx == null) {
        print('Ungültige Eingabe, bitte erneut versuchen.');
        continue;
      }

      print(vm.selectCoffee(idx - 1));

      // Wenn die Auswahl korrekt ist, beginnen wir mit der Münzeinzahlung
      while (vm.selectedType != null && vm.paid < vm.selectedType!.price) {
        stdout.write('Es fehlen noch €${vm.remaining.toStringAsFixed(2)}. Geben Sie einen Betrag ein: ');
        final inp = stdin.readLineSync();
        final coin = double.tryParse(inp ?? '');
        print(vm.insertMoney(coin ?? -1));
      }

      // Kaufversuch
      final result = vm.buy();
      print(result.message);
      print('');
    }
  }

  void _printMenu() {
    print('\n=== Kaffeeautomat ===');
    final menu = vm.menu;
    for (var i = 0; i < menu.length; i++) {
      final t = menu[i];
      print('[${i + 1}] ${t.name} — €${t.price.toStringAsFixed(2)}');
    }
  }
}

void main() {
  final machine = CoffeeMachine();
  final vm = CoffeeViewModel(machine);
  final view = ConsoleView(vm);
  view.run();
}
