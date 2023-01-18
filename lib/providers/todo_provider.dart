import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';

final List <Item>initialItems = [];


class ItemProvider with ChangeNotifier {

  final List <Item> _items = initialItems;

  List <Item> get items => _items;

  void addItem(Item item){
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item){
    _items.remove(item);
    notifyListeners();
  }

  void selectItem(Item item){
    _items[item.index].completed = !_items[item.index].completed;
    notifyListeners();
  }
}

