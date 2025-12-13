import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/firebase_options.dart';
import 'package:bodyflow/navigation/router.dart';
import 'package:bodyflow/ui/core/themes/theme.dart';
import 'package:bodyflow/ui/main_pages/view_models/generator_page_viewmodel.dart';
import 'package:bodyflow/ui/main_pages/view_models/profile_page_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/create_account_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/login_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserAuthentication(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(
          create: (context) => GeneratorPageViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfilePageViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateAccountViewmodel(),
        ),
        Provider(
          create: (context) => LoginViewmodel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BodyFlow',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router(),
    );
  }
}
