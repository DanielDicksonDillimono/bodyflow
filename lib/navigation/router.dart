import 'package:bodyflow/data/services/user_authentication.dart';
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
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  refreshListenable: null, // Can be enhanced to listen to auth state changes
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
              builder: (context, state) => ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final authService = Provider.of<UserAuthentication>(context, listen: false);
  final user = authService.currentUser();
  final isAuthenticated = user != null;
  
  final isOnAuthPage = state.fullPath == Routes.login ||
      state.fullPath == Routes.signUp ||
      state.fullPath == Routes.passwordRecovery;

  // If user is not authenticated and trying to access the generate page (protected)
  if (!isAuthenticated && state.fullPath == Routes.generate) {
    return Routes.login;
  }

  // If user is authenticated and trying to access auth pages, redirect to home
  if (isAuthenticated && isOnAuthPage) {
    return Routes.home;
  }

  // No redirect needed - users can browse home and profile without authentication
  return null;
}
