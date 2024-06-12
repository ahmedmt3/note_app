import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/widgets/app_drawer.dart';
import 'package:note_app/view/widgets/note_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addNote');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("All notes"),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: GetBuilder<NoteController>(
          builder: ((noteController) => noteController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async => await noteController.loadNotes(),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 220),
                    itemCount: noteController.notes.length,
                    itemBuilder: (context, index) {
                      if (index < noteController.notes.length) {
                        return noteCard(
                            noteController.notes[index], noteController);
                      } else {
                        return Container();
                      }
                    },
                  ),
                )),
        ),
      ),
    );
  }
}
