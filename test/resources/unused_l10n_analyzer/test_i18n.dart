class TestI18n {
  static const String field = 'field';

  static String get getter => 'getter'; // LINT

  static String method(String value) => value;

  static String secondMethod(String value, num number) =>
      value + number.toString();

  String regularMethod(String value) => value;

  String get regularGetter => 'regular getter'; // LINT

  final String regularField = 'regular field';

  TestI18n.of(String value) {
    print(value);
  }
}

class S {
  static const String field = 'field'; // LINT

  static String get getter => 'getter';

  static String method(String value) => value; // LINT

  static String secondMethod(String value, num number) => // LINT
      value + number.toString();

  String regularMethod(String value) => value;

  String get regularGetter => 'regular getter';

  final String regularField = 'regular field'; // LINT

  // ignore: prefer_constructors_over_static_methods
  static S of(String value) {
    print(value);

    return S();
  }
}

class L10nClass {
  String method(String value) => value;

  String get regularGetter => 'regular getter';

  final String regularField = 'regular field';

  L10nClass._();
}

class L10nWrapper {}

extension L10nExtension on L10nWrapper {
  L10nClass get l10n => L10nClass._();
}
