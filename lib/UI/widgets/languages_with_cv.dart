import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/UI/widgets/curriculum_button.dart';
import 'package:portfolio_flutter/UI/widgets/languages_widget.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_cubit.dart';

class LanguagesWithCV extends StatelessWidget {
  const LanguagesWithCV({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguagesCubit()),
        BlocProvider(create: (_) => CurriculumCubit()),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: const LanguagesWidget()),
                  const SizedBox(width: 16),
                  const Expanded(flex: 1, child: CurriculumButton()),
                ],
              );
            } else {
              return Column(
                children: [
                  const LanguagesWidget(),
                  const SizedBox(height: 16),
                  const CurriculumButton(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
