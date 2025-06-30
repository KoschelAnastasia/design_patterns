/// Repräsentiert ein Ereignis im Kaffeeautomaten (Typ + optionales Getränk)
class CoffeeEvent {
  final CoffeeEventType type;
  final String? drink;
  CoffeeEvent(this.type, {this.drink});
}

/// Mögliche Ereignistypen des Kaffeeautomaten
enum CoffeeEventType { balanceChanged, drinkDispensed, insufficientFunds, invalidSelection }

// Modell
// Repräsentiert den Zustand des Kaffeeautomaten
// und enthält die Logik für das Einfügen von Münzen und die Auswahl von Getränken.
class CoffeeModel {
  final Map<String, double> menu = {'Espresso': 2.50, 'Cappuccino': 3.50, 'Latte': 3.20};

  double _balance = 0;

  final List<void Function(CoffeeEvent)> _listeners = [];

  double get balance => _balance;

  void addListener(void Function(CoffeeEvent) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(CoffeeEvent) listener) {
    _listeners.remove(listener);
  }

  void _notify(CoffeeEvent event) {
    for (var listener in _listeners) {
      listener(event);
    }
  }

  // Einfügen von Münzen
  void insertCoin(double amount) {
    _balance += amount;
    _notify(CoffeeEvent(CoffeeEventType.balanceChanged));
  }

  //Auswahl eines Getränks
  void selectDrink(String drink) {
    if (!menu.containsKey(drink)) {
      _notify(CoffeeEvent(CoffeeEventType.invalidSelection, drink: drink));
      return;
    }

    final price = menu[drink]!;
    if (_balance >= price) {
      _balance -= price;
      _notify(CoffeeEvent(CoffeeEventType.drinkDispensed, drink: drink));
      _notify(CoffeeEvent(CoffeeEventType.balanceChanged));
    } else {
      _notify(CoffeeEvent(CoffeeEventType.insufficientFunds, drink: drink));
    }
  }
}

// Controller
// Vermittelt Benutzereingaben an das Modell
class CoffeeController {
  final CoffeeModel model;
  CoffeeController(this.model);

  void insertCoin(double amount) => model.insertCoin(amount);
  void selectDrink(String drink) => model.selectDrink(drink);
}

// View
// Präsentiert Ausgaben auf der Konsole und lauscht Modell‑Ereignissen
class CoffeeView {
  CoffeeView(CoffeeModel model) {
    // Abonnieren der Modell-Ereignisse
    model.addListener((event) {
      switch (event.type) {
        case CoffeeEventType.balanceChanged:
          showBalance(model.balance);
        case CoffeeEventType.drinkDispensed:
          showMessage('Ihr ${event.drink} ist fertig!');
        case CoffeeEventType.insufficientFunds:
          showMessage('Nicht genug Guthaben für ${event.drink}');
        case CoffeeEventType.invalidSelection:
          showMessage('Unbekanntes Getränk: ${event.drink}');
      }
    });
  }

  void showMenu(Map<String, double> menu) {
    print('=== Menü ===');
    menu.forEach((drink, price) => print('$drink: $price €'));
    print('============\n');
  }

  void showMessage(String message) => print('>> $message');
  void showBalance(double balance) => print('Guthaben: ${balance.toStringAsFixed(2)} €');
}

void main() {
  final model = CoffeeModel();
  final view = CoffeeView(model);
  final ctrl = CoffeeController(model);

  view.showMenu(model.menu);
  ctrl.insertCoin(1.50);
  ctrl.selectDrink('Latte');
  ctrl.insertCoin(2);
  ctrl.selectDrink('Latte');
}
