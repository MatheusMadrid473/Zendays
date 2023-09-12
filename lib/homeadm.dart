import 'package:flutter/material.dart';
import 'package:zendays/nossowidget/admin_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  print(token);
  return token;
}

class HomeAdministradorPage extends StatefulWidget {
  @override
  _HomeAdministradorPageState createState() => _HomeAdministradorPageState();

}

class _HomeAdministradorPageState extends State<HomeAdministradorPage> {

  final List<CardItem> cards = [
    CardItem(
      title: 'Relatório',
      icon: Icons.bar_chart,
    ),
    CardItem(
      title: 'Férias',
      icon: Icons.beach_access,
    ),
    CardItem(
      title: 'Funcionário',
      icon: Icons.people,
    ),
    CardItem(
      title: 'Login',
      icon: Icons.login,
    ),
  ];

  String currentPage = 'home';

  void handleMenuTap(String page) {
    setState(() {
      currentPage = page;
    });
    // Adicione aqui qualquer lógica adicional que precisa ser executada quando um item do menu é selecionado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Administrador'),
      ),
      drawer: AdminMenu(
        currentPage: currentPage,
        onMenuTap: handleMenuTap,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: cards.map((card) => CardWidget(card: card)).toList(),
      ),
    );
  }
}

class CardItem {
  final String title;
  final IconData icon;

  CardItem({required this.title, required this.icon});
}

class CardWidget extends StatelessWidget {
  final CardItem card;

  CardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          // Implementar ação para cada card
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                card.icon,
                size: 48.0,
                color: Colors.blue,
              ),
              SizedBox(height: 8.0),
              Text(
                card.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
