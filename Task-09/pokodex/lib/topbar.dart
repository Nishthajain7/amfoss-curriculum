import 'package:flutter/material.dart';
import 'login.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isLoggedIn;
  final Function(bool, String) loggedIn;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const TopBar({super.key, required this.isLoggedIn, required this.loggedIn, required this.usernameController,required this.passwordController});

  @override
  TopBarState createState() => TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Center(child: Text('Pokodex'))),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
            child: Text(
              widget.isLoggedIn ? 'Log out' : 'Log in',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (widget.isLoggedIn) { // If user is logged in, log out
                widget.loggedIn(false, '');
                // widget.usernameController.clear();
                // widget.passwordController.clear();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(loggedIn: widget.loggedIn),
                  ),
                );
              }
            },
          ),
          SizedBox(width: 100),
        ],
      ),
    );
  }
}