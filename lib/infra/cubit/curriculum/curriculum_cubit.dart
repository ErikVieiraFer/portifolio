import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'curriculum_state.dart';

class CurriculumCubit extends Cubit<CurriculumState> {
  PdfControllerPinch? pdfController;
  // Removida a variável estática para permitir recarregamento
  Future<PdfDocument>? _documentFuture;

  CurriculumCubit() : super(CurriculumInitial()) {
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    emit(CurriculumLoading());
    try {
      // Sempre carrega o documento, sem verificar se já foi carregado antes
      _documentFuture = PdfDocument.openAsset('assets/cv_erik.pdf');
      pdfController = PdfControllerPinch(document: _documentFuture!);
      emit(CurriculumReady());
    } catch (e) {
      emit(CurriculumError('Erro ao carregar PDF: ${e.toString()}'));
      debugPrint('Erro no PDF: $e');
    }
  }
}
