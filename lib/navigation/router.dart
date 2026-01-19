import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/custom_page_builder.dart';
import 'package:bodyflow/navigation/scaffold_with_bottom_nav.dart';
import 'package:bodyflow/ui/main_pages/view_models/generator_page_viewmodel.dart';
import 'package:bodyflow/ui/main_pages/widgets/generator_page.dart';
import 'package:bodyflow/ui/main_pages/widgets/home_page.dart';
import 'package:bodyflow/ui/main_pages/widgets/profile_page.dart';
import 'package:bodyflow/ui/sub_pages/exercise/exercise_page.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/login_page.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/password_recovery_page.dart';
import 'package:bodyflow/ui/sub_pages/schedule/view_models/schedule_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/schedule/widgets/schedule_page.dart';
import 'package:bodyflow/ui/sub_pages/workout/widgets/session_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/create_account_page.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:provider/provider.dart';

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
    GoRoute(
      path: Routes.exercise,
      pageBuilder: (context, state) {
        final exercise = state.extra as Exercise?;
        if (exercise == null) {
          return buildPageWithPlatformTransitions(
            context: context,
            state: state,
            child: Scaffold(body: Center(child: Text('Exercise not found'))),
          );
        }
        return buildPageWithPlatformTransitions(
          context: context,
          state: state,
          child: ExercisePage(exercise: exercise),
        );
      },
    ),
    //this is the new route for workout page
    GoRoute(
      path: Routes.session,
      pageBuilder: (context, state) {
        final session = state.extra as Session;
        // if (workout == null) {
        //   // Navigate back if workout is null
        //   //return const Scaffold(body: Center(child: Text('Workout not found')));

        //   return buildPageWithPlatformTransitions(
        //     context: context,
        //     state: state,
        //     child: Scaffold(body: Center(child: Text('Workout not found'))),
        //   );
        // }
        return buildPageWithPlatformTransitions(
          context: context,
          state: state,
          child: SessionPage(session: session),
        );
      },
    ),
    //this is the route for schedule page
    GoRoute(
      path: Routes.schedule,
      pageBuilder: (context, state) {
        final schedule = state.extra as Schedule;
        return buildPageWithPlatformTransitions(
          context: context,
          state: state,
          child: SchedulePage(model: ScheduleViewModel(schedule: schedule)),
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithBottomNavBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              pageBuilder: (context, state) => buildPageWithPlatformTransitions(
                context: context,
                state: state,
                child: HomePage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.generate,
              pageBuilder: (context, state) => buildPageWithPlatformTransitions(
                context: context,
                state: state,
                child: GeneratorPage(
                  model: GeneratorPageViewModel(workoutRepo: context.read()),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              pageBuilder: (context, state) => buildPageWithPlatformTransitions(
                context: context,
                state: state,
                child: ProfilePage(),
              ),
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
    case Routes.exercise:
      return Routes.exercise; // Redirect to exercise page
    case Routes.home:
      return Routes.home; // Redirect to home page
    case Routes.generate:
      return Routes.generate; // Redirect to generator page
    case Routes.profile:
      return Routes.profile; // Redirect to profile page
    case Routes.session:
      return Routes.session; // Redirect to session page
    case Routes.schedule:
      return Routes.schedule; // Redirect to schedule page
    default:
      return Routes.home; // Default redirect to home page
  }
}
