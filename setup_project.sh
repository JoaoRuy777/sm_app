#!/bin/bash
# Salve este script como setup_project.sh

# Criar estrutura de diretórios
mkdir -p lib/pages lib/components lib/models lib/utils

# Criar main.dart
cat > lib/main.dart << 'EOL'
import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Checklist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
EOL

# Criar login_page.dart
cat > lib/pages/login_page.dart << 'EOL'
import 'package:flutter/material.dart';
import 'employee_checklist.dart';
import 'admin_dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _handleLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Validação simples para demonstração
    if (username == "admin" && password == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard()),
      );
    } else if (username == "employee" && password == "employee") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmployeeChecklist()),
      );
    } else {
      setState(() {
        _errorMessage = "Credenciais inválidas";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Sistema de Checklist",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Faça login para acessar o sistema",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Usuário",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Entrar"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
EOL

# Criar employee_checklist.dart
cat > lib/pages/employee_checklist.dart << 'EOL'
import 'package:flutter/material.dart';

class ChecklistItem {
  final String title;
  String status;
  String? observation;
  String? photoPath;

  ChecklistItem({
    required this.title,
    this.status = '',
    this.observation,
    this.photoPath,
  });
}

class EmployeeChecklist extends StatefulWidget {
  @override
  _EmployeeChecklistState createState() => _EmployeeChecklistState();
}

class _EmployeeChecklistState extends State<EmployeeChecklist> {
  int _currentStep = 0;
  String _selectedVehicle = '';
  String _selectedRegion = '';
  final _nurseController = TextEditingController();
  final _kmController = TextEditingController();
  
  final List<String> _vehicles = [
    'Ambulância 01',
    'Ambulância 02',
    'Ambulância 03',
    'Ambulância 04',
    'Ambulância 05',
  ];
  
  final List<String> _regions = [
    'Norte',
    'Sul',
    'Leste',
    'Oeste',
    'USA-1',
    'USA-2',
  ];
  
  final List<ChecklistItem> _checklistItems = [
    ChecklistItem(title: 'Combustível'),
    ChecklistItem(title: 'Mecânica'),
    ChecklistItem(title: 'Nível de Óleo do Motor'),
    ChecklistItem(title: 'Nível de Líquido de Arrefecimento'),
    ChecklistItem(title: 'Palhetas'),
    ChecklistItem(title: 'Vazamentos'),
    ChecklistItem(title: 'Sinal Luminoso e sonoro'),
    ChecklistItem(title: 'Alarme de ré'),
    ChecklistItem(title: 'Rádios e Tablets'),
    ChecklistItem(title: 'Elétrica'),
    ChecklistItem(title: 'Ar-Condicionado'),
    ChecklistItem(title: 'Pneus'),
    ChecklistItem(title: 'Pintura e Funilaria'),
    ChecklistItem(title: 'Limpeza'),
    ChecklistItem(title: 'Cones'),
    ChecklistItem(title: 'Oxigênio'),
    ChecklistItem(title: 'Materiais'),
    ChecklistItem(title: 'Maca'),
    ChecklistItem(title: 'Foto Dianteira'),
    ChecklistItem(title: 'Foto Traseira'),
    ChecklistItem(title: 'Foto Lateral esquerda'),
    ChecklistItem(title: 'Foto Lateral direita'),
    ChecklistItem(title: 'Foto salão interno'),
    ChecklistItem(title: 'Observações Gerais'),
  ];

  void _nextStep() {
    if (_currentStep < 1) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      _submitChecklist();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _submitChecklist() {
    // Aqui você implementaria a lógica para salvar o checklist
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Checklist enviado com sucesso!')),
    );
    Navigator.pop(context);
  }

  void _setItemStatus(int index, String status) {
    setState(() {
      _checklistItems[index].status = status;
    });
  }

  void _setItemObservation(int index, String observation) {
    setState(() {
      _checklistItems[index].observation = observation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist de Viatura'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(_currentStep == 1 ? 'Enviar' : 'Próximo'),
                ),
                if (_currentStep > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextButton(
                      onPressed: details.onStepCancel,
                      child: Text('Voltar'),
                    ),
                  ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text('Informações'),
            content: _buildBasicInfoForm(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: Text('Checklist'),
            content: _buildChecklistForm(),
            isActive: _currentStep >= 1,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selecione a viatura:'),
        DropdownButton<String>(
          isExpanded: true,
          hint: Text('Selecione a viatura'),
          value: _selectedVehicle.isEmpty ? null : _selectedVehicle,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedVehicle = newValue;
              });
            }
          },
          items: _vehicles.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Text('Selecione a região:'),
        DropdownButton<String>(
          isExpanded: true,
          hint: Text('Selecione a região'),
          value: _selectedRegion.isEmpty ? null : _selectedRegion,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedRegion = newValue;
              });
            }
          },
          items: _regions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _nurseController,
          decoration: InputDecoration(
            labelText: 'Nome do Enfermeiro',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _kmController,
          decoration: InputDecoration(
            labelText: 'Quilometragem',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildChecklistForm() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _checklistItems.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final item = _checklistItems[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${index + 1}. ${item.title}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: item.status == 'C' ? Colors.green : null,
                    ),
                    onPressed: () => _setItemStatus(index, 'C'),
                    child: Text('Conforme'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: item.status == 'NC' ? Colors.red : null,
                    ),
                    onPressed: () => _setItemStatus(index, 'NC'),
                    child: Text('Não Conforme'),
                  ),
                ),
              ],
            ),
            if (item.status == 'NC')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Observação',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _setItemObservation(index, value),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aqui você implementaria a captura de foto
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('Anexar Foto'),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
EOL

# Criar admin_dashboard.dart
cat > lib/pages/admin_dashboard.dart << 'EOL'
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
EOL

# Atualizar pubspec.yaml para adicionar dependências
cat >> pubspec.yaml << 'EOL'

  # Adicione estas dependências abaixo:
  image_picker: ^0.8.6
  shared_preferences: ^2.0.15
  intl: ^0.17.0
EOL

echo "Projeto configurado com sucesso!"
echo "Execute 'flutter pub get' para instalar as dependências"
echo "Execute 'flutter run' para iniciar o aplicativo"