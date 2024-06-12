import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/util/helpers/app_helper.dart';
import 'package:note_app/util/theme/app_styles.dart';

import '../../model/note.dart';

GestureDetector noteCard(Note note, NoteController noteController) {
  return GestureDetector(
    onTap: () {
      // If User tapped on a note, Take him to edit mode on note_view
      noteController.prepairUpdate(note);
      Get.toNamed('/addNote', arguments: {'state': 'Update'});
    },
    child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: double.infinity,
                // 
                height: 150,
                padding: const EdgeInsets.all(8),
                child: Text(note.content!.substring(0,
                    note.content!.length > 150 ? 150 : note.content!.length)),
              ),
            ),
            Text(
              note.title!,
              style: AppStyles.bodySemiBoldL.copyWith(height: 1),
            ),
            Text(AppHelper.formatDate(note.lastModified!)),
          ],
        )),
  );
}
