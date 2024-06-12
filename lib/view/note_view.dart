import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/widgets/text_field.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  var arg = Get.arguments;
  bool isUpdate(arg) {
    return arg != null && arg['state'] != null;
  }

  String markDown = '''
  # A first-level heading
  ## A second-level heading
  ### A third-level heading
  ''';

  NoteController noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Title here",
            ),
            controller: noteController.title,
            autofocus: !isUpdate(arg),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              noteController.clearFields();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        actions: isUpdate(arg)
            ? [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 'delete',
                              onTap: () => noteController.deleteNote(),
                              child: const Row(
                                children: [
                                  Icon(Icons.delete),
                                  Text("Delete Note")
                                ],
                              )),
                        ])
              ]
            : null,
      ),
      body: GetBuilder<NoteController>(
        builder: (noteController) => SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: noteController.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 500,
                      child: customTextField(
                        controller: noteController.content,
                        hint: "Write here...",
                        suffixIcon: Icons.note,
                        expands: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // SizedBox(
                    //   height: 200,
                    //   child: SelectionArea(
                    //     child: Markdown(
                    //       data: markDown,
                    //       selectable: true,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 200,
                      child: MaterialButton(
                        onPressed: () {
                          isUpdate(arg)
                              ? noteController.updateNote()
                              : noteController.addNote();
                        },
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(isUpdate(arg) ? 'Update Note' : 'Add Note'),
                      ),
                    )
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
