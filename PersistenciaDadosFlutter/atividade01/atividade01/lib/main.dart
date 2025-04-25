import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserForm(),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _favoriteColor = 'Blue';
  String _savedName = '';
  String _savedAge = '';
  String _savedColor = 'Blue';

  final Map<String, Color> _colorMap = {
    'Blue': Colors.blue,
    'Red': Colors.red,
    'Green': Colors.green,
    'Yellow': Colors.yellow,
  };

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('name') ?? '';
      _savedAge = prefs.getString('age') ?? '';
      _savedColor = prefs.getString('color') ?? 'Blue';
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('age', _ageController.text);
    await prefs.setString('color', _favoriteColor);

    setState(() {
      _savedName = _nameController.text;
      _savedAge = _ageController.text;
      _savedColor = _favoriteColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorMap[_savedColor] ?? Colors.blue,
      appBar: AppBar(
        title: const Text('Meu Perfil Persistente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Idade'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _favoriteColor,
              onChanged: (String? newValue) {
                setState(() {
                  _favoriteColor = newValue!;
                });
              },
              items: _colorMap.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text('Salvar Dados'),
            ),
            const SizedBox(height: 20),
            Text('Seu Nome: $_savedName'),
            Text('Sua Idade: $_savedAge'),
            Text('Sua Cor Favorita: $_savedColor'),
          ],
        ),
      ),
    );
  }
}