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
  String? _disciplinaSelecionada;
  Map<String, List<String>> _disciplinasComAnotacoes = {
    'DM': [],
    'POO': [],
  };

  void _adicionarAnotacao(String anotacao) {
    if (_disciplinaSelecionada != null) {
      setState(() {
        _disciplinasComAnotacoes[_disciplinaSelecionada]!.add(anotacao);
      });
    }
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
      _disciplinasComAnotacoes[disciplina] = [];
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
            ..._disciplinasComAnotacoes.keys.map(
              (disciplina) => ListTile(
                title: Text(disciplina),
                onTap: () {
                  setState(() {
                    _disciplinaSelecionada = disciplina;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(widget.title),
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar Disciplina',
                  onPressed: _mostrarAdicionarDisciplina,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _disciplinaSelecionada != null
                  ? 'Anotações para ${_disciplinaSelecionada!}:'
                  : 'Selecione uma disciplina no menu.',
            ),
            if (_disciplinaSelecionada != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _disciplinasComAnotacoes[_disciplinaSelecionada]!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_disciplinasComAnotacoes[_disciplinaSelecionada!]![index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_disciplinaSelecionada != null) {
            _mostrarAdicionarAnotacao();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Selecione uma disciplina primeiro!')),
            );
          }
        },
        tooltip: 'Adicionar Anotação',
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
