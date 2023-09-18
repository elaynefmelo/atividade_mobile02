import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Lista de Favoritos'),
      ),
      body: ListView.builder(
        itemCount: favoriteModel.favorites.length,
        itemBuilder: (context, index) {
          final item = favoriteModel.favorites[index];
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                favoriteModel.removeFavorite(item);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItemDialog(context, favoriteModel);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addItemDialog(BuildContext context, FavoriteModel favoriteModel) {
    String newItem = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Item'),
          content: TextField(
            onChanged: (value) {
              newItem = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (newItem.isNotEmpty) {
                  favoriteModel.addFavorite(newItem);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
