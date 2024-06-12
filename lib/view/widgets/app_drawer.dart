import 'package:flutter/material.dart';
import 'package:note_app/util/theme/app_styles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 130),
            Row(
              children: [
                Icon(Icons.menu, size: 30),
                SizedBox(width: 10),
                Text(
                  "All notes",
                  style:
                      AppStyles.heading3.copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.star_border_rounded, size: 30),
                const SizedBox(width: 10),
                Text(
                  "Favorites",
                  style:
                      AppStyles.heading3.copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.folder, size: 30),
                const SizedBox(width: 10),
                Text(
                  "Folders",
                  style:
                      AppStyles.heading3.copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
