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

/// Функция-генератор: «шлёт» статус раз в 2 с.
Stream<DeliveryStatus> fakeDeliveryStream() async* {
  for (final status in DeliveryStatus.values) {
    await Future.delayed(const Duration(seconds: 2));
    yield status; // notifyObservers()
  }
}

Future<void> main() async {
  final completer = Completer<void>();
  // Observer подписывается
  fakeDeliveryStream().listen(
    (status) => print('📦 Новый статус: $status'),
    onDone: () {
      print('🎉 Lieferung abgeschlossen');
      completer.complete();
    },
  );

  // ждём конца потока, чтобы приложение не закрылось раньше времени
  await completer.future;
}
