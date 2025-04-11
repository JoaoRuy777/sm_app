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
