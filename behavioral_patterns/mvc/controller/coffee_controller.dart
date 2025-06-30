// controller/coffee_controller.dart

import '../model/coffee_model.dart';

class CoffeeController {
  final CoffeeModel model;
  CoffeeController(this.model);

  void insertCoin(int amount) => model.insertCoin(amount);
  void selectDrink(String drink) => model.selectDrink(drink);
}
