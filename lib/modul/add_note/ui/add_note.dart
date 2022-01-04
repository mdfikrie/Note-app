import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_bloc/bloc/note_bloc.dart';

class AddNote extends StatelessWidget {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add Note"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.read<NoteBloc>().add(
                      NoteAddEvent(
                        title: title.text,
                        content: content.text,
                      ),
                    );
                Get.back();
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
