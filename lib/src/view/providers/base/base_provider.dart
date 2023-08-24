// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_state.dart';

abstract class BaseProvider extends StateNotifier<BaseState?> {
  BaseProvider({BaseState? baseState}) : super(baseState);

  void setScreenState(BaseState newState) {
    state = newState;
  }
}
