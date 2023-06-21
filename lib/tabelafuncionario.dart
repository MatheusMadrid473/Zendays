import 'package:flutter/material.dart';
import 'editarfuncionario.dart';
import 'cadastrofuncionario.dart';
import 'nossowidget/admin_menu.dart';

class Funcionario {
  final String nome;
  final String cargo;
  final String departamento;

  Funcionario({
    required this.nome,
    required this.cargo,
    required this.departamento,
  });
}

class TabelaFuncionariosPage extends StatefulWidget {
  @override
  _TabelaFuncionariosPageState createState() => _TabelaFuncionariosPageState();
}

class _TabelaFuncionariosPageState extends State<TabelaFuncionariosPage> {
  final List<Funcionario> funcionarios = [
    Funcionario(
      nome: 'João da Silva',
      cargo: 'Analista',
      departamento: 'TI',
    ),
    Funcionario(
      nome: 'Maria Oliveira',
      cargo: 'Desenvolvedora',
      departamento: 'TI',
    ),
    Funcionario(
      nome: 'Pedro Santos',
      cargo: 'Gerente de Projetos',
      departamento: 'RH',
    ),
    Funcionario(
      nome: 'Ana Souza',
      cargo: 'Analista de Marketing',
      departamento: 'Marketing',
    ),
    Funcionario(
      nome: 'Carlos Ribeiro',
      cargo: 'Engenheiro de Software',
      departamento: 'TI',
    ),
    Funcionario(
      nome: 'Julia Mendes',
      cargo: 'Designer',
      departamento: 'Design',
    ),
    Funcionario(
      nome: 'Fernando Costa',
      cargo: 'Analista de Negócios',
      departamento: 'RH',
    ),
    Funcionario(
      nome: 'Camila Alves',
      cargo: 'Desenvolvedora',
      departamento: 'TI',
    ),
    // Restante dos funcionários...
  ];

  String currentPage = 'funcionarios';

  void handleMenuTap(String page) {
    setState(() {
      currentPage = page;
    });
    // Adicione aqui qualquer lógica adicional que precisa ser executada quando um item do menu é selecionado
  }

  Future<void> _editarFuncionario(Funcionario funcionario) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EdicaoFuncionarioPage(
          funcionario: funcionario,
          nome: funcionario.nome,
          cargo: funcionario.cargo,
          departamento: funcionario.departamento,
          telefone: '', // Adicione os demais campos aqui
          endereco: '',
          email: '',
        ),
      ),
    );
    if (result != null) {
      setState(() {
        funcionarios[funcionarios.indexOf(funcionario)] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela de Funcionários'),
      ),
      drawer: AdminMenu(
        currentPage: currentPage,
        onMenuTap: handleMenuTap,
      ),
      body: ListView.separated(
        itemCount: funcionarios.length,
        separatorBuilder: (context, index) => Divider(height: 1.0),
        itemBuilder: (context, index) {
          final funcionario = funcionarios[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  funcionario.nome[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
              title: Text(funcionario.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cargo: ${funcionario.cargo}'),
                  Text('Departamento: ${funcionario.departamento}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editarFuncionario(funcionario);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Excluir Funcionário'),
                            content: Text('Tem certeza que deseja excluir o funcionário?'),
                            actions: [
                              TextButton(
                                child: Text('Não'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Sim'),
                                onPressed: () {
                                  setState(() {
                                    funcionarios.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroFuncionarioPage()),
          ).then((value) {
            if (value != null) {
              setState(() {
                funcionarios.add(value);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
