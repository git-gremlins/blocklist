import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/screens/parent_tasks.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:frontend/widgets/SlideOverMenu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // await dotenv.load(fileName: "../../backend/db/.env");
  String? SUPABASE_URL =
      "http://localhost:54321"; //dotenv.env["API_EXTERNAL_URL"];
  String? SUPABASE_ANON_KEY =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"; // dotenv.env["ANON_KEY"];
  if (SUPABASE_URL == null || SUPABASE_ANON_KEY == null) {
    throw Exception("Supabase keys not defined correctly");
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: SUPABASE_ANON_KEY,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLOCKLIST',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          body: supabase.auth.currentUser == null
              ? const SplashPage()
              : const ParentTaskScreen(),
        ),
      ),
    );
  }
}

final supabase = Supabase.instance.client;
