import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'dart:math';
import 'package:frontend/screens/instructions.dart';
import 'package:frontend/screens/welcome.dart';

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

  static const List<String> backgroundImages = [
    // 'assets/p1.jpg',
    'assets/p5.jpg',
    // 'assets/p3.jpg'
  ];

  String _getRandomBackgroundImage() {
    final random = Random();
    return backgroundImages[random.nextInt(backgroundImages.length)];
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
          //update this bit
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_getRandomBackgroundImage()),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Center(
              child: Container(
                //everything
                // color: Colors.pink,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Fill in email address";
                              }
                            },
                            controller: _emailController,
                            decoration:
                                const InputDecoration(label: Text("Email")),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Fill in password";
                              }
                            },
                            controller: _passwordController,
                            decoration:
                                const InputDecoration(label: Text("Password")),
                            obscureText: true,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _signInLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 20,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: _handleSignIn,
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Colors.green.withOpacity(0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: const Text("Sign In"),
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: _signUpLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 20,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: _handleSignUp,
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Colors.green.withOpacity(0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: const Text("Sign Up"),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );
                },
                icon: Icon(Icons.home),
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Instructions()),
                  );
                },
                icon: Icon(Icons.info),
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
