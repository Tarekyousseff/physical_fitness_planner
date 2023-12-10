import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/data/my_list_tittle.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? profilepage;
  final void Function()? logout;
  const MyDrawer({super.key, this.profilepage, this.logout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                  child: Icon(
                Icons.person,
                color: Colors.red,
                size: 80,
              )),
              MyListTittle(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () => Navigator.pop(context),
              ),
              MyListTittle(
                  icon: Icons.person, text: 'My Profile', onTap: profilepage),
              MyListTittle(
                  icon: Icons.payment, text: 'P A Y M E N T', onTap: () {}),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTittle(
                icon: Icons.logout, text: 'L O G O U T', onTap: logout),
          ),
        ],
      ),
    );
  }
}
