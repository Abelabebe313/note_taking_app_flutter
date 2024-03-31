import 'package:note_taking_app/bloc/note_bloc.dart';
import 'package:note_taking_app/presentation/pages/home.dart';
import 'package:note_taking_app/presentation/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (context) => NoteBloc(),
      child: MaterialApp(
        title: 'Note Taking App',
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
