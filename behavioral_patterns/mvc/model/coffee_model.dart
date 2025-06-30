// model/coffee_model.dart

enum CoffeeEventType { balanceChanged, drinkDispensed, insufficientFunds, invalidSelection }

class CoffeeEvent {
  final CoffeeEventType type;
  final String? drink;
  CoffeeEvent(this.type, {this.drink});
}

class CoffeeModel {
  final Map<String, int> menu = {'Espresso': 30, 'Cappuccino': 40, 'Latte': 45};

  int _balance = 0;
  // Здесь вместо CoffeeEventListener пишем сразу void Function(CoffeeEvent)
  final List<void Function(CoffeeEvent)> _listeners = [];

  int get balance => _balance;

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

  void insertCoin(int amount) {
    _balance += amount;
    _notify(CoffeeEvent(CoffeeEventType.balanceChanged));
  }

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
