//Behavioural Design Pattern - State

// Interface für die Authentifizierungszustände
abstract class AuthState {
  void login(AuthenticationContext context, String username, String password);
  void logout(AuthenticationContext context);
  bool isAuthenticated();
}

// Konkrete Implementierung des Interface "AuthState" für den ausgeloggten Zustand
class LoggedOutState implements AuthState {
  @override
  void login(AuthenticationContext context, String username, String password) {
    print('Versuch, Benutzer "$username" zu authentifizieren...');
    if (username == "admin" && password == "SuperSecretPassword1984!?*") {
      print('Authentifizierung erfolgreich. Sie sind als "$username" eingeloggt.\n');
      context.setState(LoggedInState(username));
    } else {
      print('Falscher Benutzername oder Passwort. Bitte versuchen Sie es erneut.\n');
    }
  }

  @override
  void logout(AuthenticationContext context) {
    print('Sie sind bereits ausgeloggt. Logout nicht möglich.\n');
  }

  @override
  bool isAuthenticated() => false;
}

// Konkrete Implementierung des Interface "AuthState" für den eingeloggten Zustand
class LoggedInState implements AuthState {
  final String username;

  LoggedInState(this.username);

  @override
  void login(AuthenticationContext context, String username, String password) {
    print('Sie sind bereits als "$username" angemeldet. Ein erneuter Login ist nicht erforderlich.\n');
  }

  @override
  void logout(AuthenticationContext context) {
    print('Benutzer "$username" meldet sich ab...');
    context.setState(LoggedOutState());
    print('Sie wurden erfolgreich ausgeloggt.\n');
  }

  @override
  bool isAuthenticated() => true;
}

// Kontextklasse, die den Authentifizierungszustand verwaltet
class AuthenticationContext {
  AuthState _state;

  AuthenticationContext() : _state = LoggedOutState();

  void setState(AuthState state) {
    _state = state;
  }

  void login(String username, String password) {
    _state.login(this, username, password);
  }

  void logout() {
    _state.logout(this);
  }

  bool isAuthenticated() {
    return _state.isAuthenticated();
  }
}

void main() {
  final authContext = AuthenticationContext();

  authContext.logout();

  authContext.login("admin", "SuperSecretPassword1984");

  authContext.login("admin", "SuperSecretPassword1984!?*");

  print("Ist der Benutzer authentifiziert? ${authContext.isAuthenticated()}\n");

  authContext.login("admin", "SuperSecretPassword1984!?*");

  authContext.logout();

  print("Ist der Benutzer authentifiziert? ${authContext.isAuthenticated()}\n");
}
