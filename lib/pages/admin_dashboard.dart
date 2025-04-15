import 'package:flutter/material.dart';
import 'employee_checklist.dart';
import '../utils/export_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  AdminDashboardState createState() => AdminDashboardState(); // ✅ agora o tipo é público
}


class AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmployeeChecklist()),
              );
            },
            tooltip: 'Novo Checklist',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            tooltip: 'Sair',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Relatórios', icon: Icon(Icons.assessment)),
            Tab(text: 'Usuários', icon: Icon(Icons.people)),
            Tab(text: 'Viaturas', icon: Icon(Icons.directions_car)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReportsTab(),
          _buildUsersTab(),
          _buildVehiclesTab(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
  // Dados de exemplo para exportação
  final List<Map<String, dynamic>> checklistData = [
    {'id': 1, 'date': '01/05/2023', 'vehicle': 'Ambulância 01', 'driver': 'João Silva', 'region': 'Norte', 'status': 'Completo'},
    {'id': 2, 'date': '02/05/2023', 'vehicle': 'Ambulância 02', 'driver': 'Maria Santos', 'region': 'Sul', 'status': 'Completo'},
    {'id': 3, 'date': '03/05/2023', 'vehicle': 'Ambulância 03', 'driver': 'Pedro Alves', 'region': 'Leste', 'status': 'Incompleto'},
    {'id': 4, 'date': '04/05/2023', 'vehicle': 'Ambulância 01', 'driver': 'Ana Costa', 'region': 'Oeste', 'status': 'Completo'},
    {'id': 5, 'date': '05/05/2023', 'vehicle': 'Ambulância 04', 'driver': 'Carlos Mendes', 'region': 'USA-1', 'status': 'Completo'},
  ];

  // Cabeçalhos e chaves para exportação
  final List<String> headers = ['ID', 'Data', 'Viatura', 'Condutor', 'Região', 'Status'];
  final List<String> keys = ['id', 'date', 'vehicle', 'driver', 'region', 'status'];

  // Função para mostrar opções de exportação
  void showExportOptions() {
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
                ExportService.exportToPdf(
                  checklistData,
                  headers,
                  keys,
                  'Relatório de Checklist de Viaturas',
                );
              },
              child: const Text('PDF'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ExportService.exportToCsv(
                  checklistData,
                  headers,
                  keys,
                );
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

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtros',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Data Inicial',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Data Final',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Viatura',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: '', child: Text('Todas')),
                          DropdownMenuItem(value: 'Ambulância 01', child: Text('Ambulância 01')),
                          DropdownMenuItem(value: 'Ambulância 02', child: Text('Ambulância 02')),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Condutor',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filtrar'),
                    ),
                    const SizedBox(width: 16),
                    // Botão de exportação adicionado aqui
                    ElevatedButton.icon(
                      onPressed: showExportOptions,
                      icon: const Icon(Icons.file_download),
                      label: const Text('Exportar Relatório'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Card(
            child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text('Checklist #${1000 + index}'),
                  subtitle: Text('Ambulância 0${index + 1} - ${DateTime.now().toString().substring(0, 10)}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Abrir detalhes do checklist
                  },
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildUsersTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lista de Usuários',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Adicionar novo usuário
                },
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Usuário'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final names = ['João Silva', 'Maria Santos', 'Pedro Alves', 'Ana Costa', 'Carlos Mendes'];
                  final roles = ['Admin', 'Funcionário', 'Funcionário', 'Admin', 'Funcionário'];
                  
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(names[index]),
                    subtitle: Text('Função: ${roles[index]}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Editar usuário
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Excluir usuário
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehiclesTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lista de Viaturas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Adicionar nova viatura
                },
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Viatura'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final vehicles = ['Ambulância 01', 'Ambulância 02', 'Ambulância 03', 'Ambulância 04', 'Ambulância 05'];
                  final plates = ['ABC-1234', 'DEF-5678', 'GHI-9012', 'JKL-3456', 'MNO-7890'];
                  final kms = [12500, 8700, 15300, 5200, 9800];
                  
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.directions_car),
                    ),
                    title: Text(vehicles[index]),
                    subtitle: Text('Placa: ${plates[index]} - Última KM: ${kms[index]}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Editar viatura
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Excluir viatura
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
