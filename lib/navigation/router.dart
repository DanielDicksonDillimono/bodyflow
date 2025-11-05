import 'package:bodyflow/ui/sub_pages/login_signup/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/create_account_page.dart';
import 'package:bodyflow/navigation/routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  routes: [
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const CreateAccountPage(),
    ),
    GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // final bool isloggedIn =
  //     context.read<UserAuthentication>().currentUser() != null;

  // if (!isloggedIn) {
  //   // return state.fullPath == Routes.signUp ? Routes.signUp : Routes.login;
  //   switch (state.fullPath) {
  //     case Routes.login:
  //       return Routes.login; // Already on login page
  //     case Routes.signUp:
  //       return Routes.signUp; // Redirect to sign up page
  //     case Routes.passwordRecovery:
  //       return Routes.passwordRecovery; // Redirect to password recovery page
  //     default:
  //       return Routes.login; // Default redirect to login page
  //   }
  // }
  // if (isloggedIn && state.fullPath == Routes.login) {
  //   return Routes.home;
  // }

  switch (state.fullPath) {
    case Routes.login:
      return Routes.login; // Already on login page
    case Routes.signUp:
      return Routes.signUp; // Redirect to sign up page
    case Routes.passwordRecovery:
      return Routes.passwordRecovery; // Redirect to password recovery page
    default:
      return Routes.login; // Default redirect to login page
  }
}
