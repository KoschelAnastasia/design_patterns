//Structural Design Pattern: Decorator

// Interface für die Komponente
abstract class Coffee {
  String get description;
  double get price;
}

// Konkrete Implementierung der Komponente
class SimpleCoffee implements Coffee {
  @override
  String get description => "Kaffee";

  @override
  double get price => 2.0;
}

// Dekorator für die Komponente
class CoffeeDecorator implements Coffee {
  final Coffee _coffee;

  CoffeeDecorator(this._coffee);

  @override
  String get description => _coffee.description;

  @override
  double get price => _coffee.price;
}

//Erweiterung für Milch
class MilkDecorator extends CoffeeDecorator {
  MilkDecorator(Coffee coffee) : super(coffee);

  @override
  String get description {
    return super.description + ", Milch";
  }

  @override
  double get price {
    return super.price + 0.5;
  }
}

//Erweiterung für Zucker
class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(Coffee coffee) : super(coffee);

  @override
  String get description {
    return super.description + ", Zucker";
  }

  @override
  double get price {
    return super.price + 0.2;
  }
}

void main() {
  Coffee coffee = SimpleCoffee();
  print("${coffee.description};\nPreis: ${coffee.price} Euro\n"); // Kaffee; Preis: 2.0 Euro

  coffee = MilkDecorator(coffee);
  print("${coffee.description}; \nPreis: ${coffee.price} Euro\n"); // Kaffee, Milch; Preis: 2.5 Euro

  coffee = SugarDecorator(coffee);
  print("${coffee.description}; \nPreis: ${coffee.price} Euro\n"); // Kaffee, Milch, Zucker; Preis: 2.7 Euro
}
