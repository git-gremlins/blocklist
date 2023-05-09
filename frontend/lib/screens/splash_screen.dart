import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _signInLoading = false;
  bool _signUpLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid != true) {
      return;
    }
    setState(() {
      _signInLoading = true;
    });
    try {
      await supabase.auth.signInWithPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login Failed"),
        backgroundColor: Colors.redAccent,
      ));
      setState(() {
        _signInLoading = false;
      });
    }
  }

  void _handleSignUp() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid != true) {
      return;
    }

    setState(() {
      _signUpLoading = true;
    });
    try {
      var temp = await supabase.auth.signUp(
          email: _emailController.text, password: _passwordController.text);
      await postUser(
          InputUser(userId: temp.user!.id, name: "Kamal", surname: "Sac"));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Success!"),
        backgroundColor: Color.fromARGB(255, 69, 247, 78),
      ));
      setState(() {
        _signUpLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sign up Failed"),
        backgroundColor: Colors.redAccent,
      ));
      setState(() {
        _signUpLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Sign in to BLOCKLIST!")),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Fill in email address";
                    }
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text("Email")),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Fill in password";
                    }
                  },
                  controller: _passwordController,
                  decoration: const InputDecoration(label: Text("Password")),
                  obscureText: true,
                ),
              ),
              _signInLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: OutlinedButton(
                          onPressed: _handleSignIn,
                          child: const Text("Sign In")),
                    ),
              _signUpLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: OutlinedButton(
                          onPressed: _handleSignUp,
                          child: const Text("Sign Up")),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
