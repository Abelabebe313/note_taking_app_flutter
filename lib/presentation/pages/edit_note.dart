// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:note_taking_app/bloc/note_bloc.dart';
import 'package:note_taking_app/bloc/note_bloc.dart';
import 'package:note_taking_app/data/note.dart';
import 'package:note_taking_app/model/note_model.dart';

class EditNote extends StatefulWidget {
  NoteModel note;
   EditNote({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String tag = 'Personal';
  List<String> tags = [
    'Personal',
    'Work',
    'Academic',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    tag = widget.note.tag;
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
  }

  @override
  dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    // Check if the title or content is not empty
    if (title.isNotEmpty || content.isNotEmpty) {
      NoteLocalDataSource dataSource =
          NoteLocalDataSource(); // Instantiate NoteLocalDataSource
      // Create a NoteModel instance
      NoteModel note = NoteModel(
        id: UniqueKey().toString(),
        title: title,
        content: content,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        tag: '', // Add any tag logic here if needed
      );
      await dataSource.setNote(note); // Save the note to the database
      Navigator.of(context).pop(); // Close the CreateNote screen
    } else {
      // Show a snackbar or dialog indicating that title or content is empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F8FD),
        title: TextFormField(
          controller: titleController,
          maxLines: 1,
          autofocus: true,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Nunito_Light',
          ),
          decoration: const InputDecoration(
            hintText: 'Title',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              String title = titleController.text.trim();
              String content = contentController.text.trim();
              //
              NoteModel note = NoteModel(
                id: UniqueKey().toString(),
                title: title,
                content: content,
                createdAt: DateTime.now().toString(),
                updatedAt: DateTime.now().toString(),
                tag: tag,
              );
              BlocProvider.of<NoteBloc>(context).add(UpdateNoteEvent(note));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successfully updated a note!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              const Text(
                'Tag',
                style: TextStyle(
                  color: Color(0xFF292150),
                  fontSize: 16,
                  fontFamily: 'Nunito_Black',
                ),
              ),
              const SizedBox(width: 20),
              DropdownButton<String>(
                value: tag,
                onChanged: (String? value) {
                  setState(() {
                    tag = value!;
                  });
                },
                items: tags.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: TextFormField(
              controller: contentController,
              maxLines: null,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Nunito_Light',
              ),
              decoration: const InputDecoration(
                hintText: 'Content',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
