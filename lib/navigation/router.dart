import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/custom_page_builder.dart';
import 'package:bodyflow/navigation/scaffold_with_bottom_nav.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/main_pages/generator/view_models/generator_page_viewmodel.dart';
import 'package:bodyflow/ui/main_pages/homepage/view_models/home_page_viewmodel.dart';
import 'package:bodyflow/ui/main_pages/profile/view_models/profile_page_viewmodel.dart';
import 'package:bodyflow/ui/main_pages/generator/widgets/generator_page.dart';
import 'package:bodyflow/ui/main_pages/homepage/widgets/home_page.dart';
import 'package:bodyflow/ui/main_pages/profile/widgets/profile_page.dart';
import 'package:bodyflow/ui/sub_pages/exercise/exercise_page.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/create_account_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/email_verification_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/login_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/email_verification_page.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/login_page.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/password_recovery_page.dart';
import 'package:bodyflow/ui/sub_pages/schedule/view_models/schedule_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/schedule/widgets/schedule_page.dart';
import 'package:bodyflow/ui/sub_pages/session/widgets/session_page.dart';
import 'package:bodyflow/ui/sub_pages/session/view_models/session_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      path: Routes.emailVerification,
      pageBuilder: (context, state) {
        return buildPageWithPlatformTransitions(
          context: context,
          state: state,
          child: EmailVerificationPage(
            viewModel: EmailVerificationViewmodel(authService: context.read()),
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.signUp,
      pageBuilder: (context, state) => buildPageWithPlatformTransitions(
        context: context,
        state: state,
        child: CreateAccountPage(
          viewModel: CreateAccountViewmodel(
            authService: context.read(),
            databaseService: context.read(),
          ),
        ),
      ),
    ),
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => buildPageWithPlatformTransitions(
        context: context,
        state: state,
        child: LoginPage(model: LoginViewmodel(authService: context.read())),
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
            child: Builder(
              builder: (context) {
                final localization = AppLocalization.of(context);
                return Scaffold(
                  body: Center(child: Text(localization.exerciseNotFound)),
                );
              },
            ),
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
          child: SessionPage(
            model: SessionViewModel(session: session, repo: context.read()),
          ),
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
          child: SchedulePage(
            model: ScheduleViewModel(schedule: schedule, repo: context.read()),
          ),
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
                child: HomePage(
                  viewModel: HomePageViewModel(workoutRepo: context.read()),
                ),
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
                child: FirebaseAuth.instance.currentUser != null
                    ? GeneratorPage(
                        model: GeneratorPageViewModel(
                          workoutRepo: context.read(),
                        ),
                      )
                    : LoginPage(
                        model: LoginViewmodel(authService: context.read()),
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
                child: FirebaseAuth.instance.currentUser != null
                    ? ProfilePage(
                        viewModel: ProfilePageViewmodel(
                          authService: context.read(),
                          workoutRepo: context.read(),
                          database: context.read(),
                        ),
                      )
                    : LoginPage(
                        model: LoginViewmodel(authService: context.read()),
                      ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final isloggedIn = FirebaseAuth.instance.currentUser != null;
  final userEmailVerified =
      FirebaseAuth.instance.currentUser?.emailVerified ?? false;

  if (!isloggedIn) {
    switch (state.fullPath) {
      case Routes.signUp:
        return null; // Allow access to sign up page
      case Routes.passwordRecovery:
        return null; // Allow access to password recovery page
      case Routes.login:
        return null; // Allow access to login page
      default:
        return Routes.login; // Redirect unauthenticated users to login page
    }
  }

  if (isloggedIn && !userEmailVerified) {
    if (state.fullPath != Routes.emailVerification) {
      return Routes.emailVerification; // Redirect to email verification page
    } else {
      return null; // Allow access to email verification page
    }
  }

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
