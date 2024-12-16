// Die Klasse Memento speichert den Zustand des Editors.
// Dies ist ein "Snapshot" – ein unveränderliches Objekt, das den Zustand zu einem bestimmten Zeitpunkt enthält.
class Memento {
  final String state;

  Memento(this.state);
}

// Die Klasse Editor – das ist unser "Editor", der einen Zustand (Text) hat.
class Editor {
  String _text = '';

  void setText(String text) {
    _text = text;
  }

  String get text => _text;

  Memento save() {
    return Memento(_text);
  }

  // Stellt den Zustand aus einem Schnappschuss wieder her.
  void restore(Memento memento) {
    _text = memento.state;
  }
}

// Die Klasse History – ein Verwalter der Memento
class History {
  final List<Memento> _history = [];

  // Speichert den aktuellen Zustand des Editors in der History.
  void save(Editor editor) {
    _history.add(editor.save());
  }

  // Setzt den Zustand auf einen vorherigen zurück, falls vorhanden.
  void undo(Editor editor) {
    if (_history.isNotEmpty) {
      final memento = _history.removeLast();
      editor.restore(memento);
    } else {
      print('Kein Zustand zur Wiederherstellung vorhanden!');
    }
  }
}

// Beispiel zur Nutzung:
void main() {
  // Erstellen eines Editors und einer History.
  final editor = Editor();
  final history = History();

  // Text setzen und Zustand speichern.
  editor.setText("Hallo, Welt!");
  history.save(editor);
  print("Aktueller Text: ${editor.text}"); // Erste Version des Textes

  // Text erneut ändern und speichern.
  editor.setText("Hallo, Welt! Mememto-Pattern ist toll!");
  history.save(editor);
  print("Aktueller Text: ${editor.text}"); // Zweite Version des Textes

  // Text erneut ändern, ohne im History zu speichern.
  editor.setText("Hallo Welt! Memento-Pattern ist toll! Oder doch nicht?");
  print("Aktueller Text: ${editor.text}"); // Dritte Version des Textes (nicht gespeichert)

  // Rückgängig machen auf den vorherigen gespeicherten Zustand.
  history.undo(editor);
  print("Nach undo: ${editor.text}"); // Zweite Version des Textes

  // Noch ein undo bringt uns zur ersten Version zurück.
  history.undo(editor);
  print("Nach dem zweiten undo: ${editor.text}"); // Erste Version des Textes
}
