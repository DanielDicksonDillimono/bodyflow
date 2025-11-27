import 'package:bodyflow/navigation/scaffold_with_bottom_nav.dart';
import 'package:bodyflow/ui/main_pages/widgets/generator_page.dart';
import 'package:bodyflow/ui/main_pages/widgets/home_page.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/login_page.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/password_recovery_page.dart';
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
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    GoRoute(
      path: Routes.passwordRecovery,
      builder: (context, state) => PasswordRecoveryPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithBottomNavBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) {
                return HomePage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.generate,
              builder: (context, state) {
                return GeneratorPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              builder: (context, state) {
                return const Scaffold(
                  body: Center(child: Text('Profile Page')),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // final bool isloggedIn =
  //     context.read<UserAuthentication>().currentUser() != null;

  final bool isloggedIn = true;

  if (!isloggedIn) {
    // return state.fullPath == Routes.signUp ? Routes.signUp : Routes.login;
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
  if (isloggedIn && state.fullPath == Routes.login) {
    return Routes.home;
  }

  // switch (state.fullPath) {
  //   case Routes.login:
  //     return Routes.login; // Already on login page
  //   case Routes.signUp:
  //     return Routes.signUp; // Redirect to sign up page
  //   case Routes.passwordRecovery:
  //     return Routes.passwordRecovery; // Redirect to password recovery page
  //   default:
  //     return Routes.login; // Default redirect to login page
  // }
}
