import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/widgets/drawer_menu_widget.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    super.key,
  });
  final NoteController noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SizedBox(width: 30),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/user-avatar.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DrawerMenuWidget(
              title: "All notes",
              icon: Icons.menu,
              onTap: () {},
              isActive: true,
              itemCount: noteController.notes.length.toString(),
            ),
            const SizedBox(height: 20),
            DrawerMenuWidget(
              title: "Favourites",
              icon: Icons.star_border_rounded,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            DrawerMenuWidget(
              title: "Folders",
              icon: Icons.folder_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Spacer(),
            DrawerMenuWidget(
              title: "Logout",
              icon: Icons.logout_outlined,
              iconColor: Colors.redAccent,
              onTap: () => Get.toNamed('/login'),
              textColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
