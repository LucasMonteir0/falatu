import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthGuard {
  static GoRouterRedirect call() {
    return (BuildContext context, GoRouterState state) {
      if (true) {
        return '/signin';
      } else {
        return null;
      }
    };
  }
}


