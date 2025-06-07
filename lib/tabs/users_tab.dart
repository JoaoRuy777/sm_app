import 'package:flutter/material.dart';
import '../data/user_dao.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  final UserDAO _userDAO = UserDAO();
  List<Map<String, dynamic>> _users = [];

  Future<void> _loadUsers() async {
    final users = await _userDAO.getAllUsers();
    setState(() => _users = users);
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Lista de Usuários', style: TextStyle(fontSize: 20)),
              ElevatedButton.icon(
                onPressed: () async {
                  await _userDAO.insertUser('Novo Usuário', 'Admin');
                  _loadUsers();
                },
                icon: const Icon(Icons.add),
                label: const Text('Adicionar'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _users.isEmpty
                ? const Center(child: Text('Nenhum usuário.'))
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return ListTile(
                        title: Text(user['name']),
                        subtitle: Text(user['role']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await _userDAO.deleteUser(user['id']);
                            _loadUsers();
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
