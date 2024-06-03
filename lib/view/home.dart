import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/widgets/list_item.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addNote'),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        
        title: const Text("Home Page"),
      ),
      body: SafeArea(
        child: GetBuilder<NoteController>(
          init: NoteController(),
          builder: ((noteController) => noteController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: noteController.notes.length,
                  itemBuilder: (context, index) => Column(children: [
                    Card(
                      child: myListTile(noteController.notes[index], noteController),
                    ),
                  ]),
                )),
        ),
      ),
    );
  }
}
