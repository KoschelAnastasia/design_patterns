//Behavioral Design Pattern - Command

// Die Klasse TextEditor – Simuliert einen Texteditor

class TextEditor {
  String _text = '';

  String get text => _text;

  void addText(String newText) {
    _text += newText;
  }

  void removeText(int length) {
    if (length <= _text.length) {
      _text = _text.substring(0, _text.length - length);
    }
  }
}

// Abstrakte Klasse Command
abstract class Command {
  final TextEditor editor;

  Command(this.editor);

  void execute();
  void undo();
}

// Klassen, die die konkreten Befehle darstellen
class AddTextCommand extends Command {
  final String textToAdd;
  String _backup = '';

  AddTextCommand(TextEditor editor, this.textToAdd) : super(editor);

  @override
  void execute() {
    _backup = editor.text;
    editor.addText(textToAdd);
  }

  @override
  void undo() {
    editor._text = _backup;
  }
}

class RemoveTextCommand extends Command {
  final int length;
  String _backup = '';

  RemoveTextCommand(TextEditor editor, this.length) : super(editor);

  @override
  void execute() {
    _backup = editor.text;
    editor.removeText(length);
  }

  @override
  void undo() {
    editor._text = _backup;
  }
}

// Klasse, die die Befehle ausführt und den Verlauf speichert
class EditorInvoker {
  final TextEditor editor;
  final List<Command> _history = [];

  EditorInvoker(this.editor);

  void executeCommand(Command command) {
    command.execute();
    _history.add(command);
  }

  void undo() {
    if (_history.isNotEmpty) {
      Command lastCommand = _history.removeLast();
      lastCommand.undo();
    }
  }
}

void main() {
  final editor = TextEditor();
  final invoker = EditorInvoker(editor);

  invoker.executeCommand(AddTextCommand(editor, "Hello, "));
  invoker.executeCommand(AddTextCommand(editor, "World!"));
  print(editor.text);

  invoker.executeCommand(RemoveTextCommand(editor, 6));
  print(editor.text);

  invoker.undo();
  print(editor.text);
}
