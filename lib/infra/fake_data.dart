import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/list_category.dart';
import '../models/item_list.dart';

const DUMMY_CATEGORIES = const [
  ListCategory(
    id: 'c1',
    title: 'Mercado',
    color: Colors.purple,
    type: CategoryType.market,
  ),
  ListCategory(
    id: 'c2',
    title: 'Casa',
    color: Colors.red,
    type: CategoryType.house,
  ),
  ListCategory(
    id: 'c3',
    title: 'Pessoal',
    color: Colors.blue,
    type: CategoryType.personal,
  ),
  ListCategory(
    id: 'c4',
    title: 'Trabalho',
    color: Colors.green,
    type: CategoryType.work,
  ),
];

const DUMMY_LISTS = const [
  ItemList(
    id: 1,
    title: 'Compra do mês',
    listCategoryId: 'c1',
  ),
  ItemList(
    id: 2,
    title: 'Hortifruti',
    listCategoryId: 'c1',
  ),
  ItemList(
    id: 3,
    title: 'Reforma do quarto',
    listCategoryId: 'c2',
  ),
  ItemList(
    id: 4,
    title: 'Muambinhas',
    listCategoryId: 'c3',
  ),
];

const DUMMY_ITEMS = const [
  Item(
    id: 1,
    title: 'Carne',
    itemListId: '1',
  ),
  Item(
    id: 2,
    title: 'Arroz',
    itemListId: '1',
  ),
  Item(
    id: 3,
    title: 'Feijão',
    itemListId: '1',
  ),
  Item(
    id: 4,
    title: 'Coca',
    itemListId: '1',
  ),
  Item(
    id: 5,
    title: 'Frango',
    itemListId: '1',
  ),
  Item(
    id: 6,
    title: 'Linguiça',
    itemListId: '1',
  ),
  Item(
    id: 7,
    title: 'Azeite',
    itemListId: '1',
  ),
  Item(
    id: 8,
    title: 'Sabonete',
    itemListId: '1',
  ),
  Item(
    id: 9,
    title: 'Cebola',
    itemListId: '2',
  ),
  Item(
    id: 10,
    title: 'Maçã',
    itemListId: '2',
  ),
  Item(
    id: 11,
    title: 'Fita de led',
    itemListId: '4',
  ),
];
