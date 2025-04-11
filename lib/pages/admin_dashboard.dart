import 'package:flutter/material.dart';
import 'employee_checklist.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
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
        title: Text('Painel Administrativo'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeeChecklist()),
              );
            },
            tooltip: 'Novo Checklist',
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            tooltip: 'Sair',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
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
                  Text(
                    'Filtros',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Viatura',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(value: '', child: Text('Todas')),
                            DropdownMenuItem(value: 'Ambulância 01', child: Text('Ambulância 01')),
                            DropdownMenuItem(value: 'Ambulância 02', child: Text('Ambulância 02')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
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
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.filter_list),
                      label: Text('Filtrar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Card(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Checklist #${1000 + index}'),
                    subtitle: Text('Ambulância 0${index + 1} - ${DateTime.now().toString().substring(0, 10)}'),
                    trailing: Icon(Icons.chevron_right),
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
              Text(
                'Lista de Usuários',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Adicionar novo usuário
                },
                icon: Icon(Icons.add),
                label: Text('Adicionar Usuário'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Card(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final names = ['João Silva', 'Maria Santos', 'Pedro Alves', 'Ana Costa', 'Carlos Mendes'];
                  final roles = ['Admin', 'Funcionário', 'Funcionário', 'Admin', 'Funcionário'];
                  
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(names[index]),
                    subtitle: Text('Função: ${roles[index]}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Editar usuário
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
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
              Text(
                'Lista de Viaturas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Adicionar nova viatura
                },
                icon: Icon(Icons.add),
                label: Text('Adicionar Viatura'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Card(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final vehicles = ['Ambulância 01', 'Ambulância 02', 'Ambulância 03', 'Ambulância 04', 'Ambulância 05'];
                  final plates = ['ABC-1234', 'DEF-5678', 'GHI-9012', 'JKL-3456', 'MNO-7890'];
                  final kms = [12500, 8700, 15300, 5200, 9800];
                  
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.directions_car),
                    ),
                    title: Text(vehicles[index]),
                    subtitle: Text('Placa: ${plates[index]} - Última KM: ${kms[index]}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Editar viatura
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
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
