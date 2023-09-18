import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void addFavorite(String item) {
    _favorites.add(item);
    notifyListeners();
  }

  void removeFavorite(String item) {
    _favorites.remove(item);
    notifyListeners();
  }
}
