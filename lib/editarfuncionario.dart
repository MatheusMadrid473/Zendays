import 'package:flutter/material.dart';
import 'package:zendays/tabelafuncionario.dart';

class EdicaoFuncionarioPage extends StatefulWidget {
  final String nome;
  final String cargo;
  final String departamento;
  final String telefone;
  final String endereco;
  final String email;

  EdicaoFuncionarioPage({
    required this.nome,
    required this.cargo,
    required this.departamento,
    required this.telefone,
    required this.endereco,
    required this.email, required Funcionario funcionario,
  });

  @override
  _EdicaoFuncionarioPageState createState() => _EdicaoFuncionarioPageState();
}

class _EdicaoFuncionarioPageState extends State<EdicaoFuncionarioPage> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cargoController = TextEditingController();
  TextEditingController _departamentoController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.nome;
    _cargoController.text = widget.cargo;
    _departamentoController.text = widget.departamento;
    _telefoneController.text = widget.telefone;
    _enderecoController.text = widget.endereco;
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cargoController.dispose();
    _departamentoController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Funcionário'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _cargoController,
              decoration: InputDecoration(labelText: 'Cargo'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _departamentoController,
              decoration: InputDecoration(labelText: 'Departamento'),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para salvar as alterações do funcionário
                    },
                    child: Text('Salvar'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _nomeController.text = widget.nome;
                      _cargoController.text = widget.cargo;
                      _departamentoController.text = widget.departamento;
                      _telefoneController.text = widget.telefone;
                      _enderecoController.text = widget.endereco;
                      _emailController.text = widget.email;
                    },
                    child: Text('Limpar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
