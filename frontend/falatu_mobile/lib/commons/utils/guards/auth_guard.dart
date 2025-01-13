import 'package:falatu_mobile/commons/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthGuard {
  static GoRouterRedirect call() {
    return (BuildContext context, GoRouterState state) {
      if (false) {
        return Routes.signIn;
      } else {
        return null;
      }
    };
  }
}


