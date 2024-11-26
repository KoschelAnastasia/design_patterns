// Creational Design Pattern: Abstract Factory

// Abstraktes Produkt Ticket
abstract class Ticket {
  String getTicketType();
  String getPrice();
}

// Konkrete Implementierungen des Produkts Ticket
class ErwachseneBusTicket implements Ticket {
  @override
  String getTicketType() => 'Erwachsene Bus Ticket';
  @override
  String getPrice() => '10 Euro';
}

class SchuelerBusTicket implements Ticket {
  @override
  String getTicketType() => 'Schüler Bus Ticket';
  @override
  String getPrice() => '5 Euro';
}

class ErwachseneTrainTicket implements Ticket {
  @override
  String getTicketType() => 'Erwachsene Train Ticket';
  @override
  String getPrice() => '20 Euro';
}

class SchuelerTrainTicket implements Ticket {
  @override
  String getTicketType() => 'Schüler Train Ticket';
  @override
  String getPrice() => '10 Euro';
}

// Abstrakte Fabrik TicketFactory
abstract class TicketFactory {
  Ticket createErwachseneTicket();
  Ticket createSchuelerTicket();
}

// Konkrete Fabriken für verschiedene Transportmittel
class BusTicketFactory implements TicketFactory {
  @override
  Ticket createErwachseneTicket() => ErwachseneBusTicket();

  @override
  Ticket createSchuelerTicket() => SchuelerBusTicket();
}

class TrainTicketFactory implements TicketFactory {
  @override
  Ticket createErwachseneTicket() => ErwachseneTrainTicket();

  @override
  Ticket createSchuelerTicket() => SchuelerTrainTicket();
}

// Klasse zum Verwalten von Fabriken
class TicketService {
  final Map<String, TicketFactory> _factories = {
    'bus': BusTicketFactory(),
    'train': TrainTicketFactory(),
  };

  // Wählt die richtige Fabrik basierend auf dem Transporttyp aus und erstellt ein Ticket basierend auf dem Alter
  Ticket getTicket(String transportType, int age) {
    // Überprüfen, ob es eine Fabrik für den angegebenen Transporttyp gibt
    TicketFactory? factory = _factories[transportType];
    if (factory == null) {
      throw Exception('Unbekannter Transporttyp: $transportType');
    }

    // Gibt ein Ticket basierend auf dem Alter zurück
    if (age < 18) {
      return factory.createSchuelerTicket();
    } else {
      return factory.createErwachseneTicket();
    }
  }
}

void main() {
  TicketService ticketService = TicketService();

  // Beispiel 1: Busticket für einen 17-Jährigen
  String transportType1 = 'bus';
  int age1 = 17;
  Ticket ticket1 = ticketService.getTicket(transportType1, age1);
  print('Transport: $transportType1'); // bus
  print('Ihr Ticket: ${ticket1.getTicketType()}'); // Schüler Bus Ticket
  print('Preis: ${ticket1.getPrice()}'); // 5 Euro

  // Beispiel 2: Zugticket für einen 25-Jährigen
  String transportType2 = 'train';
  int age2 = 25;
  Ticket ticket2 = ticketService.getTicket(transportType2, age2);
  print('\nTransport: $transportType2'); // train
  print('Ihr Ticket: ${ticket2.getTicketType()}'); // Erwachsene Train Ticket
  print('Preis: ${ticket2.getPrice()}'); // 20 Euro
}
