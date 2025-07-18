import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/infra/repositories/language_repository.dart';
import 'languages_state.dart';

class LanguagesCubit extends Cubit<LanguagesState> {
  final LanguageRepository _repository;

  LanguagesCubit({LanguageRepository? repository})
      : _repository = repository ?? LanguageRepository(),
        super(const LanguagesState()) {
    loadLanguages();
  }

  Future<void> loadLanguages() async {
    emit(state.copyWith(status: LanguageStatus.loading));
    try {
      final languages = await _repository.getLanguages();
      emit(state.copyWith(
        status: LanguageStatus.success,
        languages: languages,
      ));
    } catch (e) {
      emit(state.copyWith(status: LanguageStatus.error));
    }
  }

  void toggleExpanded() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }
}
