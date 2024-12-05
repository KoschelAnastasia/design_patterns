//Structural Design Pattern: Proxy

// Inteface für das Bild
abstract class Image {
  Future<void> display();
}

// Implementierung realer Bilder
class RealImage implements Image {
  String _filename;
  bool _isLoaded = false;

  RealImage(this._filename);

  Future<void> _loadFromDatenbank() async {
    if (!_isLoaded) {
      print('Lade Bild $_filename aus der Datenbank...');
      // Simuliere eine zeitaufwändige Ladeoperation
      await Future.delayed(Duration(seconds: 2));
      _isLoaded = true;
      print('Bild $_filename wurde geladen.');
    }
  }

  @override
  Future<void> display() async {
    await _loadFromDatenbank();
    print('Anzeige des Bildes $_filename');
  }
}

// Implementierung des Proxy-Bildes
class ProxyImage implements Image {
  String _filename;
  RealImage? _realImage;

  ProxyImage(this._filename);

  @override
  Future<void> display() async {
    if (_realImage == null) {
      _realImage = RealImage(_filename);
    }
    await _realImage!.display();
  }
}

// Client-Code
void main() async {
  Image image = ProxyImage('high_resolution_photo.jpg');

  // Das Bild wird nur beim ersten Anzeigen aus der Datenbank geladen
  await image.display();

  print('-------------------');

  // Beim erneuten Anzeigen wird das Bild nicht erneut geladen
  await image.display();
}
