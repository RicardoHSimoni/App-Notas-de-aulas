import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de notas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'App de notas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> _disciplinas = ['DM', 'POO'];
  List<String> _anotacoes = [];

  void _adicionarAnotacao(String anotacao) {
    setState(() {
      _anotacoes.add(anotacao);
    });
  }

  void _mostrarAdicionarAnotacao() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Nova anotação'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _adicionarAnotacao(_controller.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _adicionarDisciplina(String disciplina) {
    setState(() {
      _disciplinas.add(disciplina);
    });
  }

  void _mostrarAdicionarDisciplina() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Nova disciplina'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _adicionarDisciplina(_controller.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Disciplinas'),
            ),
            ..._disciplinas.map(
              (disciplina) => ListTile(
                title: Text(disciplina),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            alignment: Alignment.centerRight,
            tooltip: 'Anotações',
            onPressed: () {
              _mostrarAdicionarAnotacao();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Botão da AppBar pressionado!')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Lista de Anotações:'),
            Expanded(
              child: ListView.builder(
                itemCount: _anotacoes.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_anotacoes[index]));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarAdicionarDisciplina,
        tooltip: 'Adicionar Disciplina',
        child: const Icon(Icons.add),
      ),
    );
  }
}
