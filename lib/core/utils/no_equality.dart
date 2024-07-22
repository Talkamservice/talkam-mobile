mixin NoEquality {
  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => 0;
}