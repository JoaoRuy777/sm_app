import 'package:flutter/material.dart';

class VehiclesTab extends StatelessWidget {
  const VehiclesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Lista de Viaturas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          const Expanded(
            child: Center(child: Text('Nenhuma viatura cadastrada.')),
          ),
        ],
      ),
    );
  }
}
