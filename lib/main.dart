import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzapppfe/presentation/blocs/quizz_theme.dart';
import 'package:quizzapppfe/presentation/blocs/socket_bloc.dart';
import 'package:quizzapppfe/presentation/screens/home/home_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures widget binding is initialized
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SocketBloc>(
            create: (context) => SocketBloc(),
          ),
          BlocProvider<QuizzBloc>(
              create: (context) => QuizzBloc(firestore: FirebaseFirestore.instance)
          )
        ],
        child: HomeScreen(),
      ),
    );
  }
}
