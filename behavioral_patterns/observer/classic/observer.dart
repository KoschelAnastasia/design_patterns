import 'dart:async';

/// Возможные этапы доставки

enum DeliveryStatus {
  ordered('In Bearbeitung'),
  packed('Wird für den Versand vorbereitet'),
  shipped('Paket wurde dem Zusteller übergeben'),
  outForDelivery('In Zustellung'),
  delivered('Zugestellt');

  final String description;

  const DeliveryStatus(this.description);

  @override
  String toString() => description;
}

/// ────────────────────────────
/// Observer — интерфейс слушателя
/// ────────────────────────────
abstract class DeliveryObserver {
  void update(DeliveryStatus status);
}

/// ────────────────────────────
/// Subject — источник событий
/// ────────────────────────────
class DeliverySubject {
  final List<DeliveryObserver> _observers = [];
  DeliveryStatus _status = DeliveryStatus.ordered;

  // Подписка / отписка
  void addObserver(DeliveryObserver o) => _observers.add(o);
  void removeObserver(DeliveryObserver o) => _observers.remove(o);

  DeliveryStatus get status => _status;

  /// Изменяем состояние и уведомляем всех
  set status(DeliveryStatus newStatus) {
    if (newStatus == _status) return; // ничего не изменилось
    _status = newStatus;
    _notify(); // notifyObservers()
  }

  void _notify() {
    // Копируем список на случай, если observer отпишется в процессе
    for (final obs in List<DeliveryObserver>.from(_observers)) {
      obs.update(_status);
    }
  }
}

/// ────────────────────────────
/// Конкретный Observer
/// ────────────────────────────
class ConsoleLogger implements DeliveryObserver {
  final String name;
  ConsoleLogger(this.name);

  @override
  void update(DeliveryStatus status) {
    print('[$name] 📦 новый статус: $status');
  }
}

/// ────────────────────────────
/// Симулируем ход доставки
/// ────────────────────────────
Future<void> simulateDelivery(DeliverySubject subject) async {
  for (final step in DeliveryStatus.values) {
    await Future.delayed(const Duration(seconds: 2));
    subject.status = step; // каждое присвоение → notify
  }
}

Future<void> main() async {
  final delivery = DeliverySubject();

  // Два независимых наблюдателя
  final recipientLogger = ConsoleLogger('Empfänger');
  final senderLogger = ConsoleLogger('Absender');

  delivery.addObserver(recipientLogger);
  delivery.addObserver(senderLogger);

  // Запускаем «доставку»
  await simulateDelivery(delivery);

  //  больше не нужен — отписываемся
  delivery.removeObserver(recipientLogger);
  print('Empfänger отписался от обновлений');
}
