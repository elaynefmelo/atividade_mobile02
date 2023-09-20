import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites.addAll(prefs.getStringList('favorites') ?? []);
    });
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites);
  }

  void _addToFavorites(String item) {
    if (!_favorites.contains(item)) {
      setState(() {
        _favorites.add(item);
        _saveFavorites();
      });
    }
  }

  void _removeFromFavorites(String item) {
    if (_favorites.contains(item)) {
      setState(() {
        _favorites.remove(item);
        _saveFavorites();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButton = ElevatedButton(
        onPressed: () {
          String newItem = _controller.text;
          if (newItem.isNotEmpty) {
            _addToFavorites(newItem);
            _controller.clear();
          }
        },
        // ignore: sort_child_properties_last
        child: const Text('Adicionar aos Favoritos'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
        ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Meus Favoritos'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Favorito',
            ),
          ),
          elevatedButton,
          Expanded(
            child: ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                String item = _favorites[index];
                return ListTile(
                  title: Text(item),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _removeFromFavorites(item);
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
