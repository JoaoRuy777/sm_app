import 'package:flutter/material.dart';
import '../utils/export_service.dart';

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  void showExportOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exportar Relatório'),
          content: const Text('Escolha o formato de exportação:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Adicione chamada real para exportar PDF aqui
              },
              child: const Text('PDF'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Adicione chamada real para exportar CSV aqui
              },
              child: const Text('CSV'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Filtros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(child: TextField(decoration: InputDecoration(labelText: 'Data Inicial', border: OutlineInputBorder(), suffixIcon: Icon(Icons.calendar_today)))),
                      SizedBox(width: 16),
                      Expanded(child: TextField(decoration: InputDecoration(labelText: 'Data Final', border: OutlineInputBorder(), suffixIcon: Icon(Icons.calendar_today)))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(labelText: 'Viatura', border: OutlineInputBorder()),
                          items: const [DropdownMenuItem(value: '', child: Text('Todas'))],
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Condutor', border: OutlineInputBorder(), suffixIcon: Icon(Icons.search)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.filter_list), label: const Text('Filtrar')),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(onPressed: () => showExportOptions(context), icon: const Icon(Icons.file_download), label: const Text('Exportar Relatório')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: Center(
              child: Text('Nenhum relatório carregado.'),
            ),
          ),
        ],
      ),
    );
  }
}
