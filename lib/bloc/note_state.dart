part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteEdit extends NoteState {
  late final NoteModel note;
  NoteEdit({required this.note});

  @override
  List<Object?> get props => [note];
}

class LoadNotesState extends NoteState {
  final List<NoteModel>? note;
  LoadNotesState({this.note});
  LoadNotesState copyWith({List<NoteModel>? note}) {
    return LoadNotesState(
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [note];
}

class NewNoteState extends NoteState {
  @override
  List<Object?> get props => [];
}
