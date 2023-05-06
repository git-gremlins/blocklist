import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

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
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {},
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
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
