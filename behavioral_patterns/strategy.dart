// Abstrakte Angriffsstrategie
abstract class AttackStrategy {
  void attack();
}

// Konkrete Strategien
// Angriffe mit verschiedenen Waffen
class SwordAttack implements AttackStrategy {
  @override
  void attack() {
    print('Unit greift mit dem Schwert an');
  }
}

class BowAttack implements AttackStrategy {
  @override
  void attack() {
    print('Unit schießt mit dem Bogen');
  }
}

class FireballAttack implements AttackStrategy {
  @override
  void attack() {
    print('Unit greift mit einem Feuerball an');
  }
}

// Feind-Klasse
// Repräsentiert einen Feind mit einem bestimmten Typ
class Enemy {
  final EnemyType type;

  Enemy(this.type);

  @override
  String toString() {
    return type.toString().split('.').last;
  }
}

// Feindtypen
enum EnemyType { zombie, dragon, archer }

// Klasse Unit, die je nach Feind eine Strategie wählt
//
class Unit {
  late AttackStrategy _strategy;

  void _chooseStrategy(Enemy enemy) {
    switch (enemy.type) {
      case EnemyType.zombie:
        _strategy = SwordAttack();
      case EnemyType.dragon:
        _strategy = FireballAttack();
      case EnemyType.archer:
        _strategy = BowAttack();
    }
  }

  void attack(Enemy enemy) {
    _chooseStrategy(enemy);
    print('Angriff auf den Feind: ${enemy}');
    _strategy.attack();
  }
}

Future<void> main() async {
  final unit = Unit();

  final enemies = [Enemy(EnemyType.zombie), Enemy(EnemyType.archer), Enemy(EnemyType.dragon)];

  for (final enemy in enemies) {
    unit.attack(enemy);
    print('');
    await Future.delayed(Duration(seconds: 2));
  }
}
