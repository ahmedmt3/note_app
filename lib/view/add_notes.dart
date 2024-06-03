import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/widgets/text_field.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  var arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: GetBuilder<NoteController>(
        init: Get.find<NoteController>(),
        builder: (noteController) => SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: noteController.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    customTextField(
                      controller: noteController.title,
                      hint: "Title",
                      validator: (value) => noteController.validateTitle(value),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      child: customTextField(
                        controller: noteController.content,
                        hint: "Write here...",
                        suffixIcon: Icons.note,
                        expands: true,
                        validator: (value) =>
                            noteController.validateContent(value),
                      ),
                    ),
                    const SizedBox(height: 20),
                    customTextField(
                      controller: noteController.color,
                      hint: "Color: #",
                      validator: (value) => noteController.validateColor(value),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: MaterialButton(
                        onPressed: () {
                          arg != null && arg['state'] != null 
                              ? noteController
                                  .updateNote()
                              : noteController.addNote();
                        },
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(arg != null && arg['state'] != null
                            ? 'Update Note'
                            : 'Add Note'),
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
