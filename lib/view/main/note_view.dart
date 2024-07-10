import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/main/widgets/note_image_widget.dart';
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
                icon: const Icon(Icons.attachment_outlined),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () =>
                              noteController.pickImage(fromCamera: true),
                          value: 'camera',
                          child: const Row(
                            children: [
                              Icon(Icons.camera),
                              SizedBox(width: 5),
                              Text("Camera"),
                            ],
                          )),
                      PopupMenuItem(
                        onTap: () => noteController.pickImage(),
                        value: 'gallery',
                        child: const Row(
                          children: [
                            Icon(Icons.photo_library_outlined),
                            SizedBox(width: 5),
                            Text("Gallery"),
                          ],
                        ),
                      ),
                    ]),
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 'delete',
                          onTap: () => noteController.deleteNote(),
                          child: const Row(
                            children: [Icon(Icons.delete), Text("Delete Note")],
                          )),
                    ])
          ],
        ),
        body: GetBuilder<NoteController>(
          builder: (noteController) => SafeArea(
            child: SingleChildScrollView(
              child: DragTarget<Offset>(
                onWillAcceptWithDetails: (details) => true,
                onAcceptWithDetails: (details) =>
                    noteController.updateImgPosition(details.offset),
                builder: (context, candidateData, rejectedData) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: 500,
                      child: NoteTextField(
                        controller: noteController.content,
                        hint: "Write here...",
                        expands: true,
                      ),
                    ),
                    if (noteController.currImage != null)
                      Obx(
                        () => Positioned(
                          left: noteController.imgPosition.value.dx,
                          top: noteController.imgPosition.value.dy,
                          child: Draggable<Offset>(
                            data: noteController.imgPosition.value,
                            feedback: NoteImageWidget(
                                currImage: noteController.currImage!),
                            childWhenDragging: Opacity(
                              opacity: 0.5,
                              child: NoteImageWidget(
                                  currImage: noteController.currImage!),
                            ),
                            child: NoteImageWidget(
                                currImage: noteController.currImage!),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
