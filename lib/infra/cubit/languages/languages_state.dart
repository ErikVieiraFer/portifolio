import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/core/models/language.dart';

class LanguagesState extends Equatable {
  final List<Language> languages;
  final bool isExpanded;

  const LanguagesState({required this.languages, this.isExpanded = false});

  @override
  List<Object> get props => [languages, isExpanded];
}
