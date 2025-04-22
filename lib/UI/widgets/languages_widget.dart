import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_state.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LanguagesCubit, LanguagesState, bool>(
      selector: (state) => state.isExpanded,
      builder: (context, isExpanded) {
        return Row(
          children: [
            const Text('Linguagens', style: TextStyle(fontSize: 18)),
            IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => context.read<LanguagesCubit>().toggleExpanded(),
            ),
          ],
        );
      },
    );
  }
}
