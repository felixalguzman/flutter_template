import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scaffold_provider.g.dart';

@riverpod
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey(
        ScaffoldMessengerKeyRef ref) =>
    GlobalKey<ScaffoldMessengerState>();

/// Returns the scaffold messenger associated with [scaffoldMessengerKeyProvider].
///
@riverpod
ScaffoldMessengerState scaffoldMessenger(ScaffoldMessengerRef ref) {
  return ref.watch(scaffoldMessengerKeyProvider).currentState!;
}
