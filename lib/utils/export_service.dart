import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ExportService {
  // Exportar para PDF
  static Future<void> exportToPdf(
    List<Map<String, dynamic>> data,
    List<String> headers,
    List<String> keys,
    String title,
  ) async {
    final pdf = pw.Document();
    
    // Criar uma fonte para o título
    final titleFont = pw.Font.helveticaBold();
    
    // Adicionar página com título e tabela
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  font: titleFont,
                  fontSize: 20,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Data de geração: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),
              _buildPdfTable(data, headers, keys),
            ],
          );
        },
      ),
    );
    
    // Salvar o arquivo
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/relatorio_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());
    
    // Abrir o arquivo
    await OpenFile.open(file.path);
    
    // Compartilhar o arquivo
    await Share.shareXFiles(
  [XFile(file.path)],
  text: 'Relatório de Checklist',
);}
  
  // Exportar para CSV
  static Future<void> exportToCsv(
    List<Map<String, dynamic>> data,
    List<String> headers,
    List<String> keys,
  ) async {
    // Preparar os dados para CSV
    List<List<dynamic>> csvData = [];
    
    // Adicionar cabeçalho
    csvData.add(headers);
    
    // Adicionar linhas de dados
    for (var item in data) {
      List<dynamic> row = [];
      for (var key in keys) {
        row.add(item[key]);
      }
      csvData.add(row);
    }
    
    // Converter para CSV
    String csv = const ListToCsvConverter().convert(csvData);
    
    // Salvar o arquivo
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/relatorio_${DateTime.now().millisecondsSinceEpoch}.csv');
    await file.writeAsString(csv);
    
    // Abrir o arquivo
    await OpenFile.open(file.path);
    
    // Compartilhar o arquivo
await Share.shareXFiles(
  [XFile(file.path)],
  text: 'Relatório de Checklist',
);}
  
  // Construir tabela PDF
  static pw.Widget _buildPdfTable(
    List<Map<String, dynamic>> data,
    List<String> headers,
    List<String> keys,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        // Cabeçalho da tabela
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: headers.map((header) => pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(
              header,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          )).toList(),
        ),
        // Linhas de dados
        ...data.map((item) => pw.TableRow(
          children: keys.map((key) => pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(
              item[key].toString(),
              textAlign: pw.TextAlign.center,
            ),
          )).toList(),
        )),
      ],
    );
  }
}