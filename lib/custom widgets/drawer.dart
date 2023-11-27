import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? profileTap;
  final void Function()? signOut;
  const MyDrawer({super.key, required this.profileTap, required this.signOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          //header

          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            ),
          ),

          //home list tile

          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            ontap: () => Navigator.pop(context),
          ),

          // profile list tile
          MyListTile(
              icon: Icons.person, text: 'P R O F I L E', ontap: profileTap),
          const Expanded(
            child: SizedBox(),
          ),
          //logout list tile
          MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            ontap: signOut,
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
