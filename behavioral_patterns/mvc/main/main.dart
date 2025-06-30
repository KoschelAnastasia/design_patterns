import '../controller/coffee_controller.dart';
import '../model/coffee_model.dart';
import '../view/coffee_verkauf_ui.dart';

void main() {
  final model = CoffeeModel();
  final view = CoffeeView(model);
  final ctrl = CoffeeController(model);

  view.showMenu(model.menu);
  ctrl.insertCoin(20);
  ctrl.selectDrink('Latte');
  ctrl.insertCoin(30);
  ctrl.selectDrink('Latte');
}
