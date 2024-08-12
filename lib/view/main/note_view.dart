import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/main/widgets/note_text_field.dart';

class NoteView extends GetView {
  NoteView({super.key});

  final arg = Get.arguments;
  bool isUpdate(arg) {
    return arg != null && arg['note'] != null;
  }

  // String markDown = '''
  // # A first-level heading
  // ## A second-level heading
  // ### A third-level heading
  // ''';

  final NoteController noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => noteController.onBackClick(didPop),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),
          title: SizedBox(
            width: 200,
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
              controller: noteController.title,
            ),
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'fav',
                  onTap: () => noteController.deleteNote(),
                  child: const Row(
                    children: [
                      Icon(Icons.star_rounded),
                      Text("Add to favourite")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  onTap: () => noteController.deleteNote(),
                  child: const Row(
                    children: [Icon(Icons.delete), Text("Delete Note")],
                  ),
                ),
              ],
            )
          ],
        ),
        body: GetBuilder<NoteController>(
          builder: (noteController) => SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    child: NoteTextField(
                      controller: noteController.content,
                      hint: "Write anything...",
                      expands: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
