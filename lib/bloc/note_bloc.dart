import 'package:note_taking_app/data/note.dart';
import 'package:note_taking_app/model/note_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteLocalDataSource _noteLocalDataSource = NoteLocalDataSource();
  NoteBloc() : super(NoteInitial()) {
    on<GetAllNotesEvent>((event, emit) async {
      emit(NoteLoading());
      try {
        print('=======GEtNote Event in try');
        final notes = await _noteLocalDataSource.getAllNotes();
        // final notes = <NoteModel>[];
        print('=================${notes[0].title}=====================');
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<AddNoteEvent>((event, emit) async {
      emit(NoteLoading());
      print('=======AddNote Event in called');
      try {
        await _noteLocalDataSource.setNote(event.note);
        final notes = await _noteLocalDataSource.getAllNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      emit(NoteLoading());
      try {
        _noteLocalDataSource.delete(event.id);
        final notes = await _noteLocalDataSource.getAllNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<UpdateNoteEvent>((event, emit) async {
      emit(NoteLoading());
      try {
        await _noteLocalDataSource.update(event.notes);
        final notes = await _noteLocalDataSource.getAllNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });


  }
}
