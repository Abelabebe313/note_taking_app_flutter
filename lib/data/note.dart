import 'package:note_taking_app/data/db_helper.dart';
import 'package:note_taking_app/model/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NoteLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> setNote(NoteModel note) async {
    final db = await _databaseHelper.database;
    await db.insert('note', note.toJson());
    print('Note added successfully');
  }

  Future<NoteModel> update(NoteModel note) async {
    final db = await _databaseHelper.database;
    await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    return note;
  }

  // Future<List<NoteModel>> update(List<NoteModel> notes) async {
  //   final db = await _databaseHelper.database;
  //   final batch = db.batch();
  //   for (var note in notes) {
  //     batch.update(
  //       'note',
  //       note.toJson(),
  //       where: 'id = ?',
  //       whereArgs: [note.id],
  //     );
  //   }
  //   await batch.commit();
  //   return notes;
  // }

  Future<String> delete(String id) async {
    final db = await _databaseHelper.database;
    final result = await db.delete('note', where: 'id = ?', whereArgs: [id]);
    if (result == 0) {
      throw Exception('Note not found');
    }
    return id;
  }

  Future<NoteModel> getNote(String id) async {
    final db = await _databaseHelper.database;
    final maps = await db.query('note', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) {
      throw Exception('Note not found');
    }
    return NoteModel.fromJson(maps.first);
  }

  Future<List<NoteModel>> getTaggedNotes(String tag) async {
    final db = await _databaseHelper.database;
    final maps = await db.query('note', where: 'tag = ?', whereArgs: [tag]);
    return List.generate(maps.length, (i) {
      return NoteModel.fromJson(maps[i]);
    });
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await _databaseHelper.database;
    final maps = await db.query('note');
    return List.generate(maps.length, (i) {
      return NoteModel.fromJson(maps[i]);
    });
  }
}
