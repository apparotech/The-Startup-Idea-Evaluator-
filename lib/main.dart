import 'package:flutter/material.dart';
import 'package:idea_envalutor/Screens/idea_listing_screen.dart';
import 'package:idea_envalutor/Screens/idea_submission_screen.dart';
import 'package:idea_envalutor/viewModel/idea_provider.dart';
import 'package:idea_envalutor/viewModel/theme_provider.dart';
import 'package:provider/provider.dart';

import 'Screens/leaderboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IdeaProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          labelStyle: const TextStyle(color: Colors.blue),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      darkTheme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.purple),
          ),
          labelStyle: const TextStyle(color: Colors.purple),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          bodyLarge: TextStyle(color: Colors.black87),
        ),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/' : (context) => const IdeaListingScreen(),
        '/ideaSubmission': (context) => const IdeaSubmissionScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
      },
     // home: const IdeaSubmissionScreen()
    );
  }
}
