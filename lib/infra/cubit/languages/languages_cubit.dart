import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/core/models/language.dart';
import 'languages_state.dart';
import 'package:flutter_test/flutter_test.dart';

class LanguagesCubit extends Cubit<LanguagesState> {
  LanguagesCubit()
    : super(
        LanguagesState(
          languages: const [
            Language(
              name: 'Flutter',
              proficiency: 0.7,
              color: Color.fromARGB(255, 0, 89, 255),
            ),
            Language(name: 'Dart', proficiency: 0.7, color: Colors.cyan),
            Language(
              name: 'CSS',
              proficiency: 0.6,
              color: Color.fromARGB(255, 1, 12, 168),
            ),
            Language(
              name: 'HTML',
              proficiency: 0.6,
              color: Color.fromARGB(255, 236, 50, 3),
            ),
            Language(
              name: 'JavaScript',
              proficiency: 0.6,
              color: Color.fromARGB(255, 243, 199, 3),
            ),
          ],
        ),
      );

  void toggleExpanded() {
    emit(
      LanguagesState(languages: state.languages, isExpanded: !state.isExpanded),
    );
  }
}

void main() {
  test('LanguagesCubit toggles isExpanded correctly', () {
    final cubit = LanguagesCubit();
    expect(cubit.state.isExpanded, false);
    cubit.toggleExpanded();
    expect(cubit.state.isExpanded, true);
  });
}
