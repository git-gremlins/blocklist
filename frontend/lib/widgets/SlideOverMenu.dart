import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/profile_screen.dart';

class SlideOverMenu extends StatelessWidget {
  const SlideOverMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Text('Settings'),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.home),
                      tooltip: "Home Task Page",
                    ),
                    title: const Text('Home Task Page'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                        ModalRoute.withName('/'),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                      tooltip: "Profile settings",
                    ),
                    title: const Text('Profile settings'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                        ModalRoute.withName('/'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: IconButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                },
                icon: const Icon(Icons.logout),
                tooltip: "Log Out",
              ),
              title: const Text('Log Out'),
              onTap: () async {
                await supabase.auth.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
