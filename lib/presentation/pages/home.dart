import 'package:note_taking_app/bloc/note_bloc.dart';
import 'package:note_taking_app/model/note_model.dart';
import 'package:note_taking_app/presentation/pages/create_note.dart';
import 'package:note_taking_app/presentation/widgets/folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NoteModel> notes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoteBloc>(context).add(GetAllNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is NoteLoading) {
          setState(() {
            _isLoading = true;
          });
        } else if (state is NoteLoaded) {
          setState(() {
            notes = state.notes;
            _isLoading = false;
          });
          print('=================${notes[0].title}=====================');
        } else if (state is NoteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          setState(() {
            _isLoading = false;
          });
        }
      },
      builder: (context, state) {
        return buildBody(context);
      },
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F8FD),
        title: const Text(
          'Note-Taking App',
          style: TextStyle(
            color: Color(0xFF292150),
            fontFamily: 'Nunito_Black',
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF6B4EFF),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/PieChart(1).png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Available Space',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Nunito_Black',
                        ),
                      ),
                      Text(
                        '20.25GB of 64 GB used',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                          fontFamily: 'Nunito_Regular',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: GridView(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: gridDelegate,
                    children: [
                      FolderWidget(
                        title: 'Personal',
                        noteCount: '5',
                        notes: notes,
                      ),
                      FolderWidget(
                        title: 'Academic',
                        noteCount: '5',
                        notes: notes,
                      ),
                      FolderWidget(
                        title: 'Work',
                        noteCount: '15',
                        notes: notes,
                      ),
                      FolderWidget(
                        title: 'Other',
                        noteCount: '15',
                        notes: notes,
                      ),
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNote()),
          );
        },
        backgroundColor: const Color(0xFF6B4EFF),
        foregroundColor: Colors.white,
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 5.0,
    crossAxisSpacing: 5.0,
  );
}
