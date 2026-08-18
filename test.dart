class MyClass {
  static final router = _Router(
    builder: () {
      return myMethod();
    }
  );

  static int myMethod() => 42;
}

class _Router {
  final int Function() builder;
  _Router({required this.builder});
}

void main() {
  print(MyClass.router.builder());
}
