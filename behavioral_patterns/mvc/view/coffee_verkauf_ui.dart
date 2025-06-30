// view/coffee_view.dart

import '../model/coffee_model.dart';

class CoffeeView {
  CoffeeView(CoffeeModel model) {
    // Подписываемся на события модели
    model.addListener((event) {
      switch (event.type) {
        case CoffeeEventType.balanceChanged:
          showBalance(model.balance);
          break;
        case CoffeeEventType.drinkDispensed:
          showMessage('Ваш ${event.drink} готов!');
          break;
        case CoffeeEventType.insufficientFunds:
          showMessage('Недостаточно средств на ${event.drink}');
          break;
        case CoffeeEventType.invalidSelection:
          showMessage('Нет такого напитка: ${event.drink}');
          break;
      }
    });
  }

  void showMenu(Map<String, int> menu) {
    print('=== Меню ===');
    menu.forEach((drink, price) => print('$drink: $price₽'));
  }

  void showMessage(String message) => print('>> $message');
  void showBalance(int balance) => print('Баланс: $balance₽');
}
