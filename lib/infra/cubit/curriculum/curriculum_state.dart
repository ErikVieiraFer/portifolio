import 'package:equatable/equatable.dart';

abstract class CurriculumState extends Equatable {
  const CurriculumState();

  @override
  List<Object> get props => [];
}

class CurriculumInitial extends CurriculumState {}

class CurriculumLoading extends CurriculumState {}

class CurriculumReady extends CurriculumState {}

class CurriculumError extends CurriculumState {
  final String message;
  const CurriculumError(this.message);
}
