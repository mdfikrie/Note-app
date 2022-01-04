import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_bloc/data/database/note_database.dart';
import 'package:hive_bloc/data/models/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  List<NoteModel> _notes = [];
  final noteDatabase = NoteDatabase();
  NoteBloc() : super(NoteInitial()) {
    // Inisiasi data
    on<InitialNoteEvent>((event, emit) async {
      _notes = await noteDatabase.getAllNotes();
      emit(LoadNotesState().copyWith(note: _notes));
    });
    // Menambah data
    on<NoteAddEvent>((event, emit) async {
      await noteDatabase
          .addToBox(NoteModel(title: event.title, content: event.content));
      _notes = await noteDatabase.getAllNotes();
      emit(LoadNotesState(note: _notes));
    });
    // mengedit data
    on<NoteEditEvent>((event, emit) async {
      await noteDatabase.updateBox(
          event.index, NoteModel(title: event.title, content: event.content));
      _notes = await await noteDatabase.getAllNotes();
      emit(LoadNotesState(note: _notes));
    });
    // Hapus data
    on<NoteDeleteEvent>((event, emit) async {
      await noteDatabase.deleteBox(event.index);
      _notes = await noteDatabase.getAllNotes();
      emit(LoadNotesState(note: _notes));
    });
    // Hapus seluruh data
    on<DeleteAllNotes>((event, emit) async {
      await noteDatabase.deleteAllBox();
      _notes = await noteDatabase.getAllNotes();
      emit(LoadNotesState(note: _notes));
    });
  }
}
