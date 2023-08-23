// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'base_state.dart';

abstract class BaseProvider with ChangeNotifier {
  BaseState state;

  BaseProvider({
    required this.state,
  });

  void setScreenState(BaseState newState) {
    state = newState;
    notifyListeners();
  }
}
