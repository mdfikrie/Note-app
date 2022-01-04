import 'package:hive/hive.dart';
import 'package:hive_bloc/data/models/note_model.dart';

class NoteDatabase {
  // buka box
  String _boxName = "Note";

  Future<Box> noteBox() async {
    final box = await Hive.openBox<NoteModel>(_boxName);
    return box;
  }

  Future<List<NoteModel>> getAllNotes() async {
    final box = await noteBox();
    List<NoteModel> notes = await box.values.toList() as List<NoteModel>;
    return notes;
  }

  Future<void> addToBox(NoteModel note) async {
    final box = await noteBox();
    await box.add(note);
  }

  Future<void> deleteBox(index) async {
    final box = await noteBox();
    await box.deleteAt(index);
  }

  Future<void> deleteAllBox() async {
    final box = await noteBox();
    await box.clear();
  }

  Future<NoteModel> editNote(index) async {
    final box = await noteBox();
    final note = await box.getAt(index);
    return note;
  }

  Future<void> updateBox(int index, NoteModel note) async {
    final box = await noteBox();
    await box.putAt(index, note);
  }
}
