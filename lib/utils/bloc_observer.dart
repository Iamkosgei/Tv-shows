import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      Fimber.i('$event');
    }
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      Fimber.i('$change');
    }
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      Fimber.i('$transition');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      Fimber.i('$error');
    }
    super.onError(bloc, error, stackTrace);
  }
}
