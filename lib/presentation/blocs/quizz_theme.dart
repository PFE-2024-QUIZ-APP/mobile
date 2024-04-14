import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzapppfe/presentation/models/quizzes.dart';

// State
abstract class QuizzThemeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuizzThemeInitial extends QuizzThemeState {}

class QuizzThemeLoading extends QuizzThemeState {}

class QuizzThemeLoaded extends QuizzThemeState {
  final List<Quizz> quizzes;

  QuizzThemeLoaded(this.quizzes);

  @override
  List<Object?> get props => [quizzes];
}

class QuizzThemeError extends QuizzThemeState {}


// Event
abstract class QuizzEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadItems extends QuizzEvent {}



// BLoC
class QuizzBloc extends Bloc<QuizzEvent, QuizzThemeState> {
  final FirebaseFirestore firestore;

  QuizzBloc({required this.firestore}) : super(QuizzThemeInitial()) {
    on<LoadItems>((event, emit) async {
      emit(QuizzThemeLoading());
      try {
        final snapshot = await firestore.collection('Theme').get();
        final items = snapshot.docs.map((doc) => Quizz.fromFirestore(doc)).toList();
        emit(QuizzThemeLoaded(items));
      } catch (e) {
        print(e);
        emit(QuizzThemeError());
      }
    });
  }
}
