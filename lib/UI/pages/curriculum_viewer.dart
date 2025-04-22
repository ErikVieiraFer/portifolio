import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';

class CurriculumViewer extends StatelessWidget {
  const CurriculumViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurriculumCubit>();

    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child:
            cubit.pdfController != null
                ? PdfViewPinch(controller: cubit.pdfController!)
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
