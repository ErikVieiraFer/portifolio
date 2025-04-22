import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/UI/pages/curriculum_viewer.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_state.dart';

class CurriculumButton extends StatelessWidget {
  const CurriculumButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        return FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () => _handlePress(context),
          child: _buildIcon(state),
        );
      },
    );
  }

  Widget _buildIcon(CurriculumState state) {
    if (state is CurriculumLoading) {
      return const CircularProgressIndicator(color: Colors.black);
    }
    return const Icon(Icons.picture_as_pdf, color: Colors.black);
  }

  void _handlePress(BuildContext context) {
    if (context.read<CurriculumCubit>().state is CurriculumReady) {
      showDialog(
        context: context,
        builder:
            (_) => BlocProvider.value(
              value: context.read<CurriculumCubit>(),
              child: const CurriculumViewer(),
            ),
      );
    }
  }
}
