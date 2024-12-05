//Structural Design Pattern: Proxy

// Inteface für das Bild
abstract class Image {
  void display();
}

// Implementierung realer Bilder
class RealImage implements Image {
  String _filename;

  RealImage(this._filename) {
    _loadFromDatenbank();
  }

  void _loadFromDatenbank() {
    print('Lade Bild $_filename aus der Datenbank...');
    // Hier könnte eine aufwendige Ladeoperation stattfinden
  }

  @override
  void display() {
    print('Anzeige des Bildes $_filename');
  }
}

// Implementierung des Proxy-Bildes
class ProxyImage implements Image {
  String _filename;
  RealImage? _realImage;

  ProxyImage(this._filename);

  @override
  void display() {
    if (_realImage == null) {
      _realImage = RealImage(_filename);
    }
    _realImage!.display();
  }
}

// Client-Code
void main() {
  Image image = ProxyImage('high_resolution_photo.jpg');

  // Das Bild wird nur beim ersten Anzeigen aus der Datenbank geladen
  image.display();

  print('-------------------');

  // Beim erneuten Anzeigen wird das Bild nicht erneut geladen
  image.display();
}
