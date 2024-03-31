part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotesEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final NoteModel note;

  AddNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final NoteModel notes;

  UpdateNoteEvent(this.notes);

  @override
  List<Object> get props => [notes];
}

class DeleteNoteEvent extends NoteEvent {
  final String id;

  DeleteNoteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetNoteEvent extends NoteEvent {
  final String id;

  GetNoteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetTaggedNotesEvent extends NoteEvent {
  final String tag;

  GetTaggedNotesEvent(this.tag);

  @override
  List<Object> get props => [tag];
}
