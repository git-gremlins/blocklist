import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/screens/parent_tasks.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: "../../backend/db/.env");
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
  late final StreamSubscription<AuthState> _authSubscription;
  User? _user;
  late bool _logged_in;

  @override
  void initState() {
    if (supabase.auth.currentUser == null) {
      _logged_in = false;
    } else {
      _logged_in = true;
    }
    _authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      // final AuthChangeEvent event = data.event
      // final Session? session = data.session;
      setState(() {
        if (supabase.auth.currentUser == null) {
          _logged_in = false;
        } else {
          _logged_in = true;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _logged_in ? const ParentTaskScreen() : const SplashPage(),
    );
  }
}

final supabase = Supabase.instance.client;
