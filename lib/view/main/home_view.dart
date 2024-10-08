import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/core/config/app_routes.dart';
import 'package:note_app/core/theme/app_styles.dart';
import 'package:note_app/core/widgets/app_drawer.dart';
import 'package:note_app/view/main/widgets/note_card_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          noteController.clearFields();
          Get.toNamed(AppRoutes.note);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("All notes"),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: GetBuilder<NoteController>(
          builder: ((noteController) => noteController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: noteController.loadNotes,
                  child: noteController.notes.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Lottie.asset(
                                'assets/lotties/empty.json',
                              ),
                              Text(
                                "You have't added any Notes",
                                style: AppStyles.bodyRegularL
                                    .copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 220),
                          itemCount: noteController.notes.length,
                          itemBuilder: (context, index) {
                            return noteCard(
                              noteController.notes[index],
                              noteController,
                            );
                          },
                        ),
                )),
        ),
      ),
    );
  }
}
