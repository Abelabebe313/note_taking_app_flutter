import 'package:note_taking_app/bloc/note_bloc.dart';
import 'package:note_taking_app/model/note_model.dart';
import 'package:note_taking_app/presentation/pages/edit_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteListingPage extends StatefulWidget {
  final String title;
  final List<NoteModel> notes;

  const NoteListingPage({
    super.key,
    required this.title,
    required this.notes,
  });

  @override
  State<NoteListingPage> createState() => _NoteListingPageState();
}

class _NoteListingPageState extends State<NoteListingPage> {
  List<NoteModel> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _loadFilteredNotes();
  }

  Future<void> _loadFilteredNotes() async {
    filteredNotes = await filterNoteByTag(widget.notes, widget.title);
    setState(() {});
  }

  Future<List<NoteModel>> filterNoteByTag(
      List<NoteModel> notes, String tag) async {
    List<NoteModel> filteredNotes = [];
    for (NoteModel note in notes) {
      if (note.tag == tag) {
        filteredNotes.add(note);
      }
    }
    return filteredNotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: const Color(0xFFF9F8FD),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: Text(
                  '${filteredNotes.length} notes',
                  style: const TextStyle(
                    color: Color(0xFF292150),
                    fontFamily: 'Nunito_Light',
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  widget.title, // << Title goes here
                  style: const TextStyle(
                    fontFamily: 'Nunito_Black',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    BlocProvider.of<NoteBloc>(context)
                        .add(DeleteNoteEvent(filteredNotes[index].id));
                    filteredNotes.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Successfully deleted note!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    setState(() {});
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNote(
                            note: filteredNotes[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredNotes[index].title,
                            style: const TextStyle(
                              color: Color(0xFF292150),
                              fontFamily: 'Nunito_Black',
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            filteredNotes[index].updatedAt,
                            style: const TextStyle(
                              color: Color(0xFF292150),
                              fontFamily: 'Nunito_Regular',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: filteredNotes.length,
            ),
          ),
        ],
      ),
    );
  }
}
