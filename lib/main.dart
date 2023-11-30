import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app/auth/auth.dart';
import 'package:social_media_app/screens/profile_page.dart';
import 'package:social_media_app/theme/dark_theme.dart';
import 'package:social_media_app/theme/light_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // darkTheme: darkTheme,
      home:
          //ProfilePage(),
          AuthScreen(),
    );
  }
}
