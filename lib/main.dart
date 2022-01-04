import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/bloc/note_bloc.dart';
import 'package:hive_bloc/data/models/note_model.dart';
import 'package:hive_bloc/modul/home/ui/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  Hive.openBox<NoteModel>("Note");
  runApp(
    BlocProvider(
      create: (context) => NoteBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(InitialNoteEvent());
    return GetMaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
