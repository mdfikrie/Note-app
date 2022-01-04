import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_bloc/bloc/note_bloc.dart';
import 'package:hive_bloc/modul/add_note/ui/add_note.dart';
import 'package:hive_bloc/modul/edit_note/ui/edit_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Note App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Peringatan",
                middleText: "Anda akan menghapus seluruh data?",
                cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Batal"),
                ),
                confirm: TextButton(
                  onPressed: () {
                    context.read<NoteBloc>().add(DeleteAllNotes());
                    Get.back();
                  },
                  child: Text(
                    "Ya",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.only(left: 10),
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteInitial) {
                return Center(
                  child: Text("Waiting"),
                );
              } else if (state is NoteLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadNotesState) {
                if (state.note!.length != 0) {
                  return GridView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 5 / 5,
                    ),
                    children: List.generate(
                      state.note!.length,
                      (index) => GestureDetector(
                        onLongPress: () {
                          Get.defaultDialog(
                            title: "Hapus Note",
                            middleText: "Apakah anda ingin menghapus note ini?",
                            confirm: TextButton(
                              onPressed: () {
                                context
                                    .read<NoteBloc>()
                                    .add(NoteDeleteEvent(index: index));
                                Get.back();
                              },
                              child: Text(
                                "Ya",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.red),
                              ),
                            ),
                            cancel: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Batal",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                          print("Delete data");
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNote(
                                  index: index,
                                  note: state.note![index],
                                  newNote: false,
                                ),
                              ));
                          print("Edit data");
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, right: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.note![index].title}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                              Text(
                                "${state.note![index].content}",
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Tidak ada data!"),
                  );
                }
              } else {
                return Center(
                  child: Text("Error"),
                );
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<NoteBloc>().add(InitialNoteEvent());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
