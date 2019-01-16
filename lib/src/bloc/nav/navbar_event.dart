import 'package:meta/meta.dart';

abstract class NavBarEvent {}

class Jump extends NavBarEvent {
  final int newIndex;

  Jump({
    @required this.newIndex,
  });

  @override
  String toString() => 'jumping to index: $newIndex';
}
