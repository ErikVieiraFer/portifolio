import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class CurriculumViewer extends StatelessWidget {
  const CurriculumViewer({super.key});

  Future<void> _downloadPdf(BuildContext context) async {
    try {
      // Mostrar indicador de progresso
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Preparando download...')));

      // Método 1: Tentar usar flutter_file_dialog
      try {
        // Carregar o arquivo PDF do assets
        final ByteData data = await rootBundle.load('assets/cv_erik.pdf');
        final List<int> bytes = data.buffer.asUint8List();

        // Salvar temporariamente o arquivo
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/cv_erik.pdf');
        await tempFile.writeAsBytes(bytes);

        // Configurar opções de salvamento
        final params = SaveFileDialogParams(
          sourceFilePath: tempFile.path,
          fileName: 'cv_erik.pdf',
          mimeTypesFilter: ['application/pdf'],
        );

        // Abrir diálogo de salvamento
        final filePath = await FlutterFileDialog.saveFile(params: params);

        // Feedback ao usuário
        if (filePath != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Currículo salvo com sucesso!')),
          );
          return; // Retorna se o método 1 funcionar
        }
      } catch (e) {
        // Se o método 1 falhar, tenta o método 2 (não mostra erro ainda)
        print('Método 1 falhou: $e');
      }

      // Método 2: Usar url_launcher para abrir o PDF em uma nova aba
      try {
        // Criar URI para o arquivo PDF
        final Uri uri = Uri.parse(
          'https://erikvieirafer.github.io/portifolio/assets/cv_erik.pdf',
        );

        // Verificar se pode abrir a URL
        if (await canLaunchUrl(uri)) {
          // Abrir URL em nova aba
          await launchUrl(uri, mode: LaunchMode.externalApplication);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PDF aberto em nova aba para download'),
            ),
          );
          return; // Retorna se o método 2 funcionar
        }
      } catch (e) {
        // Se o método 2 falhar, tenta o método 3 (não mostra erro ainda)
        print('Método 2 falhou: $e');
      }

      // Método 3: Mostrar instruções para o usuário
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Download Manual'),
            content: const Text(
              'Para baixar o currículo, acesse:\n\n'
              'https://erikvieirafer.github.io/portifolio/assets/cv_erik.pdf\n\n'
              'Ou clique com o botão direito no PDF e selecione "Salvar como..."',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Erro geral
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao baixar o currículo: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurriculumCubit>();

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barra de título com botão de download
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Currículo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.white),
                  onPressed: () => _downloadPdf(context),
                  tooltip: 'Baixar Currículo',
                ),
              ],
            ),
          ),
          // Visualizador de PDF
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child:
                  cubit.pdfController != null
                      ? PdfViewPinch(controller: cubit.pdfController!)
                      : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
