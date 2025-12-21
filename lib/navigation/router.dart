import 'package:bodyflow/navigation/custom_page_builder.dart';
import 'package:bodyflow/navigation/scaffold_with_bottom_nav.dart';
import 'package:bodyflow/ui/main_pages/widgets/generator_page.dart';
import 'package:bodyflow/ui/main_pages/widgets/home_page.dart';
import 'package:bodyflow/ui/main_pages/widgets/profile_page.dart';
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
      pageBuilder: (context, state) => buildPageWithPlatformTransitions(
        context: context,
        state: state,
        child: const CreateAccountPage(),
      ),
    ),
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => buildPageWithPlatformTransitions(
        context: context,
        state: state,
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: Routes.passwordRecovery,
      pageBuilder: (context, state) => buildPageWithPlatformTransitions(
        context: context,
        state: state,
        child: PasswordRecoveryPage(),
      ),
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
              builder: (context, state) => ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  switch (state.fullPath) {
    case Routes.login:
      return Routes.login; // Already on login page
    case Routes.signUp:
      return Routes.signUp; // Redirect to sign up page
    case Routes.passwordRecovery:
      return Routes.passwordRecovery; // Redirect to password recovery page
    case Routes.home:
      return Routes.home; // Redirect to home page
    case Routes.generate:
      return Routes.generate; // Redirect to generator page
    case Routes.profile:
      return Routes.profile; // Redirect to profile page
    default:
      return Routes.home; // Default redirect to login page
  }
}
