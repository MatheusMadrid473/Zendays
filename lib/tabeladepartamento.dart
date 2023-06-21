import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Departamento {
  final String supervisor;
  final String nome;

  Departamento({
    required this.supervisor,
    required this.nome,
  });
}

class TabelaDepartamentosPage extends StatefulWidget {
  @override
  _TabelaDepartamentosPageState createState() => _TabelaDepartamentosPageState();
}

class _TabelaDepartamentosPageState extends State<TabelaDepartamentosPage> {
  List<Departamento> departamentos = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDepartamentos();
  }

  Future<void> fetchDepartamentos() async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse('https://765f-2804-431-c7d3-ed79-8d45-fa51-479e-4b33.ngrok-free.app/api/v1/Departamento/GetAll');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var fetchedDepartamentos = List<Departamento>.from(data.map((x) => Departamento(
        supervisor: x['supervisor'],
        nome: x['nome'],
      )));

      setState(() {
        departamentos = fetchedDepartamentos;
        isLoading = false;
      });
    } else {
      print('Falha ao carregar os departamentos. Código de status: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela de Departamentos'),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.separated(
        itemCount: departamentos.length,
        separatorBuilder: (context, index) => Divider(height: 1.0),
        itemBuilder: (context, index) {
          final departamento = departamentos[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  departamento.nome[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
              title: Text(departamento.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Supervisor: ${departamento.supervisor}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchDepartamentos,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
