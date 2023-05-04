import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/helpers/http_client.dart';
import 'package:frontend/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register_user(String email, String password) async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final AuthResponse res =
        await supabase.auth.signUp(email: email, password: password);
    final Session? session = res.session;
    final User? user = res.user;
    await BaseClient().post("users.post.user", {});
  }

  Future<void> _login(String email, String password) async {
    final AuthResponse res = await supabase.auth
        .signInWithPassword(email: email, password: password);
    final Session? session = res.session;
    final User? user = res.user;
    print(user);
    print(session);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitSignUpForm() {
    final email = _emailController.text;
    final password = _passwordController.text;
    _register_user(email, password);
  }

  void _submitLoginForm() {
    final email = _emailController.text;
    final password = _passwordController.text;
    _login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _submitSignUpForm,
                child: const Text('Sign up'),
              ),
              ElevatedButton(
                onPressed: _submitLoginForm,
                child: const Text('Log in'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
