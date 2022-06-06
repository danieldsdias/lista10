import 'package:flutter/material.dart';
import 'package:lista10/models/item.dart';

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
    id: 'il1',
    title: 'Compra do mês',
    listCategoryId: 'c1',
  ),
  ItemList(
    id: 'il2',
    title: 'Hortifruti',
    listCategoryId: 'c1',
  ),
  ItemList(
    id: 'il3',
    title: 'Reforma do quarto',
    listCategoryId: 'c2',
  ),
  ItemList(
    id: 'il4',
    title: 'Muambinhas',
    listCategoryId: 'c3',
  ),
];

const DUMMY_ITEMS = const [
  Item(
    id: 'i1',
    title: 'Carne',
    itemListId: 'il1',
  ),
  Item(
    id: 'i2',
    title: 'Arroz',
    itemListId: 'il1',
  ),
  Item(
    id: 'i3',
    title: 'Feijão',
    itemListId: 'il1',
  ),
  Item(
    id: 'i4',
    title: 'Coca',
    itemListId: 'il1',
  ),
  Item(
    id: 'i5',
    title: 'Frango',
    itemListId: 'il1',
  ),
  Item(
    id: 'i6',
    title: 'Linguiça',
    itemListId: 'il1',
  ),
  Item(
    id: 'i7',
    title: 'Azeite',
    itemListId: 'il1',
  ),
  Item(
    id: 'i8',
    title: 'Sabonete',
    itemListId: 'il1',
  ),
  Item(
    id: 'i9',
    title: 'Cebola',
    itemListId: 'il2',
  ),
  Item(
    id: 'i10',
    title: 'Maçã',
    itemListId: 'il2',
  ),
  Item(
    id: 'i11',
    title: 'Fita de led',
    itemListId: 'il4',
  ),
];
