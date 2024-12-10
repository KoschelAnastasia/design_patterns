// Structural Design Pattern: Flyweight

// Gemeinsame Daten für viele ähnliche Objekte
class TreeType {
  final String name;
  final String color;
  final String texture;

  TreeType(this.name, this.color, this.texture);
}

class TreeFactory {
  static final Map<String, TreeType> _treeTypes = {};

  // Flyweight-Fabrik: Sucht nach einem vorhandenen Baumtyp oder erstellt einen neuen
  static TreeType getTreeType(String name, String color, String texture) {
    final key = '$name-$color-$texture';
    if (!_treeTypes.containsKey(key)) {
      _treeTypes[key] = TreeType(name, color, texture);
      print('TreeFactory: Erstelle neuen Baumtyp: $key');
    }
    return _treeTypes[key]!;
  }
}

class Tree {
  final int x;
  final int y;
  final TreeType type;

  // Repräsentiert ein konkretes Objekt, das sich auf gemeinsame Flyweight-Daten stützt
  Tree(this.x, this.y, this.type);

  // Zeichnet einen Baum an der Position (x, y)
  void draw() {
    print(
        'Zeichne einen Baum vom Typ ${type.name} in der Farbe ${type.color} (Textur: ${type.texture}) an der Position ($x, $y)');
  }
}

class Forest {
  final List<Tree> trees = [];

  // Verwaltet eine große Anzahl von Objekten mit Flyweight-Unterstützung
  void plantTree(int x, int y, String name, String color, String texture) {
    final type = TreeFactory.getTreeType(name, color, texture);
    final tree = Tree(x, y, type);
    trees.add(tree);
  }

  // Zeichnet alle Bäume im Wald
  void draw() {
    for (var tree in trees) {
      tree.draw();
    }
  }
}

void main() {
  final forest = Forest();

  // Pflanze Bäume mit verschiedenen Typen und Positionen
  forest.plantTree(1, 1, 'Eiche', 'Grün', 'Rau');
  forest.plantTree(2, 3, 'Eiche', 'Grün', 'Rau');
  forest.plantTree(5, 7, 'Birke', 'Weiß', 'Glatt');
  forest.plantTree(3, 4, 'Eiche', 'Grün', 'Glatt');
  forest.plantTree(4, 5, 'Birke', 'Weiß', 'Glatt');
  print("--------------------");

  // Zeichne den Wald
  forest.draw();
  print("--------------------");

  // Überprüft, ob zwei Bäume denselben Typ haben (zeigt den Speichergewinn durch Flyweight)
  print(
      "Der Typ des Baumes [0] und [1] ist dasselbe Objekt im Arbeitsspeicher: ${forest.trees[0].type == forest.trees[1].type}");
  print(
      "Der Typ des Baumes [0] und [3] ist dasselbe Objekt im Arbeitsspeicher: ${forest.trees[0].type == forest.trees[3].type}");
}
