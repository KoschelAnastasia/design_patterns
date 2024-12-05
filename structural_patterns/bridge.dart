// Interface für Geräte
abstract class Device {
  bool get isEnabled;
  int get volume;
  int get channel;
  void togglePower();
  void setVolume(int percent);
  void setChannel(int channel);
}

// Konkrete Implementierung eines Fernsehgeräts
class Tv implements Device {
  bool _isEnabled = false;
  int _volume = 50;
  int _channel = 1;

  @override
  bool get isEnabled => _isEnabled;

  @override
  void togglePower() {
    _isEnabled = !_isEnabled;
    print(_isEnabled ? 'Fernseher eingeschaltet.' : 'Fernseher ausgeschaltet.');
  }

  @override
  int get volume => _volume;

  @override
  void setVolume(int percent) {
    _volume = percent;
    print('Lautstärke des Fernsehers: $_volume');
  }

  @override
  int get channel => _channel;

  @override
  void setChannel(int channel) {
    _channel = channel;
    print('Kanal des Fernsehers: $_channel');
  }
}

// Konkrete Implementierung eines Radiogeräts
class Radio implements Device {
  bool _isEnabled = false;
  int _volume = 30;
  int _channel = 101;

  @override
  bool get isEnabled => _isEnabled;

  @override
  void togglePower() {
    _isEnabled = !_isEnabled;
    print(_isEnabled ? 'Radio eingeschaltet.' : 'Radio ausgeschaltet.');
  }

  @override
  int get volume => _volume;

  @override
  void setVolume(int percent) {
    _volume = percent;
    print('Lautstärke des Radios: $_volume');
  }

  @override
  int get channel => _channel;

  @override
  void setChannel(int channel) {
    _channel = channel;
    print('Kanal des Radios: $_channel');
  }
}

// Fernbedienung für Geräte
class Remote {
  final Device device;

  Remote(this.device);

  void togglePower() {
    print("${device.isEnabled ? 'Ausschalten' : 'Einschalten'} des Geräts.");
    device.togglePower();
  }

  void volumeDown() {
    print("Lautstärke von ${device.volume} auf ${device.volume - 10} verringern.");
    device.setVolume(device.volume - 10);
  }

  void volumeUp() {
    print("Lautstärke von ${device.volume} auf ${device.volume + 10} erhöhen.");
    device.setVolume(device.volume + 10);
  }

  void channelDown() {
    print("Kanal von ${device.channel} auf ${device.channel - 1} gewechselt.");
    device.setChannel(device.channel - 1);
  }

  void channelUp() {
    print("Kanal von ${device.channel} auf ${device.channel + 1} gewechselt.");
    device.setChannel(device.channel + 1);
  }
}

// Erweiterte Fernbedienung mit zusätzlicher Funktion
class AdvancedRemote extends Remote {
  AdvancedRemote(Device device) : super(device);

  void mute() {
    print('Stummschalten des Geräts.');
    device.setVolume(0);
  }
}

void main() {
  // Steuerung des Fernsehers über eine normale Fernbedienung
  print('Steuerung des Fernsehers:\n');
  var tv = Tv();
  Remote(tv)
    ..togglePower()
    ..volumeUp()
    ..channelUp();
  print('---\n');

  // Steuerung des Radios über eine erweiterte Fernbedienung
  print('Steuerung des Radios:\n');
  var radio = Radio();
  AdvancedRemote(radio)
    ..togglePower()
    ..mute()
    ..channelDown();
}
