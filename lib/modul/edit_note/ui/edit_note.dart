import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_bloc/bloc/note_bloc.dart';
import 'package:hive_bloc/data/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditNote extends StatelessWidget {
  final int index;
  final NoteModel note;
  bool newNote;
  EditNote({required this.index, required this.note, required this.newNote});

  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    title.text = note.title;
    content.text = note.content;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Edit Note"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              if (newNote == true) {
                Get.defaultDialog(
                  title: "Peringatan",
                  middleText: "Data akan hilang kalau belum di save",
                  cancel: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Batal"),
                  ),
                  confirm: TextButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    child: Text(
                      "Keluar",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              } else {
                Get.back();
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<NoteBloc>().add(
                      NoteEditEvent(
                        index: index,
                        content: content.text,
                        title: title.text,
                      ),
                    );
                if (newNote == true) {
                  newNote = false;
                }
                Get.snackbar(
                  "Success",
                  "Note berhasil diupdate!",
                  backgroundColor: Colors.white,
                );
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    controller: title,
                    onChanged: (value) {
                      if (newNote == false) {
                        newNote = true;
                      }
                    },
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Judul",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: content,
                    onChanged: (value) {
                      if (newNote == false) {
                        newNote = true;
                      }
                    },
                    maxLines: 25,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Mulai mengetik..",
                      hintStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
