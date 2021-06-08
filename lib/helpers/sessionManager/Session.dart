class Session {
  static final Session _session = Session._initializerFunction();

  String id;
  String names;
  String lastName;
  String emailAddress;
  int userType;
  bool verified;
  String stateId;
  String token;

  factory Session() {
    return _session;
  }

  Session._initializerFunction();
}
