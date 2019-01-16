import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NavBarState extends Equatable {
  NavBarState([Iterable props]) : super(props);
}

class NavBarJump extends NavBarState {
  final int oldIndex;
  final int currentIndex;
  final Widget screen;

  NavBarJump({
    @required this.oldIndex,
    @required this.currentIndex,
    @required this.screen,
  }) : super([oldIndex, currentIndex]);

  @override
  String toString() =>
      'jumping to new screen { oldIndex: $oldIndex, currentIndex: $currentIndex, screen: $screen}';
}
