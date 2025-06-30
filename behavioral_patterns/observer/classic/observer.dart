import 'dart:async';

/// ────────────────────────────
/// Aufzählung der möglichen Lieferstatus.
/// Jede Variante repräsentiert eine feste Phase im Versandprozess
/// mit Beschreibung.
/// ────────────────────────────
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

abstract class DeliveryObserver {
  void update(DeliveryStatus status);
}

/// ────────────────────────────
/// Publisher
/// ────────────────────────────
///
/// Subjekt: verwaltet den Lieferstatus
/// und benachrichtigt alle angemeldeten Beobachter (Observer) bei Änderungen.
class DeliverySubject {
  final List<DeliveryObserver> _observers = [];
  DeliveryStatus _status = DeliveryStatus.ordered;

  void addObserver(DeliveryObserver o) => _observers.add(o);
  void removeObserver(DeliveryObserver o) => _observers.remove(o);

  DeliveryStatus get status => _status;

  set status(DeliveryStatus newStatus) {
    if (newStatus == _status) return; // Keine Benachrichtigung bei unverändertem Status
    _status = newStatus;
    _notify(); // Beobachter benachrichtigen
  }

  void _notify() {
    // Liste kopieren, falls sich ein Beobachter währenddessen abmeldet
    for (final obs in List<DeliveryObserver>.from(_observers)) {
      obs.update(_status);
    }
  }
}

/// ────────────────────────────
/// Konkreter Beobachter (Observer)
/// ────────────────────────────
class ConsoleLogger implements DeliveryObserver {
  final String name;
  ConsoleLogger(this.name);

  @override
  void update(DeliveryStatus status) {
    print('[$name] Neuer Status: $status');
  }
}

/// ────────────────────────────
/// Liefersimulation
/// ────────────────────────────
Future<void> simulateDelivery(DeliverySubject subject) async {
  for (final step in DeliveryStatus.values) {
    await Future.delayed(const Duration(seconds: 2));
    subject.status = step; // Status aktualisieren
  }
}

Future<void> main() async {
  final delivery = DeliverySubject();

  // Zwei unabhängige Beobachter
  // (z.B. Empfänger und Absender), die auf Statusänderungen reagieren
  final recipientLogger = ConsoleLogger('Empfänger');
  final senderLogger = ConsoleLogger('Absender');

  delivery.addObserver(recipientLogger);
  delivery.addObserver(senderLogger);

  // Lieferung starten
  await simulateDelivery(delivery);

  // Wird nicht mehr benötigt – abmelden
  delivery.removeObserver(recipientLogger);
  print('Empfänger hat sich von den Updates abgemeldet');
}
