import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Metodos de Transporte", style: TextStyle(fontSize: 25),),
      ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListView(
        children: [
          Text("Investigación de Operaciones", textAlign: TextAlign.center,style: textStyles.titleMedium,),
          SizedBox(height: 10,),
          SizedBox(
            height: 100,
            child: FilledButton.icon(
              onPressed: () {
                context.push("/select_transport_problem");
              }, 
              label: Text("Metodo De Vogel", style: TextStyle(fontSize: 20),),
              icon: Icon(Icons.sort,size: 30,),
            ),
          ),
          SizedBox(height: 50,),
          Text("Integrantes:", ),
          Text("Velazquez Araujo Luis Fernando"),
          Text("Burgos Corvera Kiara Daniela"),
          Text("Inzunza Medina Carlos Raul"),
        ],
      ),
    );
  }
}