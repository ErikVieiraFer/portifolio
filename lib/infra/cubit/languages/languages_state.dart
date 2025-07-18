import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/core/models/language.dart';

enum LanguageStatus { initial, loading, success, error }

class LanguagesState extends Equatable {
  final List<Language> languages;
  final bool isExpanded;
  final LanguageStatus status;

  const LanguagesState({
    this.languages = const [],
    this.isExpanded = false,
    this.status = LanguageStatus.initial,
  });

  @override
  List<Object> get props => [languages, isExpanded, status];

  LanguagesState copyWith({
    List<Language>? languages,
    bool? isExpanded,
    LanguageStatus? status,
  }) {
    return LanguagesState(
      languages: languages ?? this.languages,
      isExpanded: isExpanded ?? this.isExpanded,
      status: status ?? this.status,
    );
  }
}
