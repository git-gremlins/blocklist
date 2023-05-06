import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/screens/parent_tasks.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:frontend/widgets/SlideOverMenu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  String? supabaseUrl =
      "http://localhost:54321"; //dotenv.env["API_EXTERNAL_URL"];
  String? supabaseAnonKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"; // dotenv.env["ANON_KEY"];
  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw Exception("Supabase keys not defined correctly");
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    supabase.auth.onAuthStateChange.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blocklist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        drawer: const SlideOverMenu(),
        body: supabase.auth.currentUser == null
            ? const SplashPage()
            : const ParentTaskScreen(),
      ),
    );
  }
}

final supabase = Supabase.instance.client;
