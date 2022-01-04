part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
  @override
  List<Object?> get props => [];
}

class InitialNoteEvent extends NoteEvent {}

class NoteAddEvent extends NoteEvent {
  late final String title, content;
  NoteAddEvent({required this.title, required this.content});
  @override
  List<Object?> get props => [title, content];
}

class NoteEditEvent extends NoteEvent {
  late final int index;
  late final String title, content;
  NoteEditEvent(
      {required this.index, required this.title, required this.content});
}

class NoteDeleteEvent extends NoteEvent {
  late final int index;
  NoteDeleteEvent({required this.index});
}

class DeleteAllNotes extends NoteEvent {}
