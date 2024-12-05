//Structural Design Pattern: Composite

// Interface für die Komponente
abstract class Component {
  String get type;
  String get name;
  double get price;
  void showDetails();
}

// Interface für den Kompositum
abstract class Composite implements Component {
  List<Component> get components;

  void addComponent(Component component);

  void removeComponent(Component component);
}

// Konkrete Implementierung einer Computerkomponente (Leaf)
class ComputerComponent implements Component {
  final String _name;
  final double _price;
  final String _componentType;

  ComputerComponent._(this._componentType, this._name, this._price);

  factory ComputerComponent.processor(String name, double price) {
    return ComputerComponent._('Prozessor', name, price);
  }

  factory ComputerComponent.hardDrive(String name, double price) {
    return ComputerComponent._('Festplatte', name, price);
  }

  factory ComputerComponent.memory(String name, double price) {
    return ComputerComponent._('Arbeitsspeicher', name, price);
  }

  factory ComputerComponent.mainboard(String name, double price) {
    return ComputerComponent._('Mainboard', name, price);
  }

  factory ComputerComponent.graphicsCard(String name, double price) {
    return ComputerComponent._('Grafikkarte', name, price);
  }

  factory ComputerComponent.powerSupply(String name, double price) {
    return ComputerComponent._('Netzteil', name, price);
  }

  factory ComputerComponent.computerCase(String name, double price) {
    return ComputerComponent._('Gehäuse', name, price);
  }

  @override
  String get name => _name;

  @override
  double get price => _price;

  @override
  String get type => _componentType;

  @override
  void showDetails() {
    print('$_componentType: $_name, Preis: ${_price.toStringAsFixed(2)} Euro');
  }
}

// Konkrete Implementierung eines Computersystems (Composite)
class ComputerSystem implements Composite {
  final String _compositeType;

  final String _name;

  ComputerSystem._(this._compositeType, this._name);

  factory ComputerSystem.newSystemBlock(String name) {
    return ComputerSystem._('Systemblock', name);
  }

  final List<Component> _components = [];

  @override
  List<Component> get components => _components;

  @override
  String get name => _name;

  @override
  double get price {
    double totalPrice = 0;
    for (var component in _components) {
      totalPrice += component.price;
    }
    return totalPrice;
  }

  @override
  String get type => _compositeType;

  @override
  void addComponent(Component component) {
    _components.add(component);
  }

  @override
  void removeComponent(Component component) {
    _components.remove(component);
  }

  @override
  void showDetails() {
    print("--------------------");
    print('$_compositeType: $name, Preis: ${price.toStringAsFixed(2)} Euro');
    print("--------------------");
    print('Komponenten:');
    for (var component in _components) {
      component.showDetails();
    }
    print("--------------------");
  }
}

void main() {
  final systemBlock = ComputerSystem.newSystemBlock('Gaming PC');

  systemBlock
    ..addComponent(ComputerComponent.processor('Intel Core i9 14900K', 499.99))
    ..addComponent(ComputerComponent.hardDrive('Samsung 970 Evo', 199.99))
    ..addComponent(ComputerComponent.memory('Corsair Vengeance RGB Pro, 32 GB', 149.99))
    ..addComponent(ComputerComponent.mainboard('MSI MPG Z390 Gaming Pro Carbon', 199.99))
    ..addComponent(ComputerComponent.graphicsCard('Nvidia GeForce RTX 4080 Ti', 1199.99))
    ..addComponent(ComputerComponent.powerSupply('Corsair RM850x, 1000 W', 149.99))
    ..addComponent(ComputerComponent.computerCase('NZXT H710i', 199.99));

  systemBlock.showDetails();
}
