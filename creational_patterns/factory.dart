// Creational Design Patterns: Factory Method

// Abstraktes Produkt Ticket
abstract class Ticket {
  String getTicketType();
  String getPrice();
}

// Konkrete Implementierungen des Produkts Ticket
class ErwachseneTicket implements Ticket {
  @override
  String getTicketType() => 'Erwachsene Ticket';
  @override
  String getPrice() => '10 Euro';
}

class SchuelerTicket implements Ticket {
  @override
  String getTicketType() => 'Schüler Ticket';
  @override
  String getPrice() => '5 Euro';
}

// Abstrakte Fabrik TicketFactory
abstract class TicketFactory {
  Ticket createTicket(int age);
}

// Konkrete Fabrik für Bustickets
class BusTicketFactory implements TicketFactory {
  @override
  Ticket createTicket(int age) {
    if (age < 18) {
      return SchuelerTicket();
    } else {
      return ErwachseneTicket();
    }
  }
}

void main() {
  final age = 18;
  TicketFactory factory = BusTicketFactory();
  Ticket ticket = factory.createTicket(age);

  print('Ihr Ticket: ${ticket.getTicketType()}'); // Erwachsene Ticket
  print('Preis: ${ticket.getPrice()}'); // 10 Euro
}
