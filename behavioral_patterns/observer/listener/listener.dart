import 'dart:async';

/// Mögliche Lieferstatus
/// Jede Variante repräsentiert eine feste Phase im Versandprozess
/// mit Beschreibung.
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

/// Generator-Funktion: „sendet“ alle 2 Sekunden einen neuen Status
Stream<DeliveryStatus> fakeDeliveryStream() async* {
  for (final status in DeliveryStatus.values) {
    await Future.delayed(const Duration(seconds: 2));
    yield status; // Benachrichtigt alle Zuhörer
  }
}

Future<void> main() async {
  final completer = Completer<void>();

  // Observer abonniert den Stream
  fakeDeliveryStream().listen(
    (status) => print('Neuer Status: $status'),
    onDone: () {
      print('Lieferung abgeschlossen');
      completer.complete();
    },
  );

  await completer.future;
}
