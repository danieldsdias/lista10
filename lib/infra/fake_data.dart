// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/list_category.dart';
import '../models/item_list.dart';

final DUMMY_CATEGORIES = [
  ListCategory(
    id: 1,
    title: 'Mercado',
    color: Colors.purple.value,
    type: CategoryType.market.name,
  ),
  ListCategory(
    id: 2,
    title: 'Casa',
    color: Colors.red.value,
    type: CategoryType.house.name,
  ),
  ListCategory(
    id: 3,
    title: 'Pessoal',
    color: Colors.blue.value,
    type: CategoryType.personal.name,
  ),
  ListCategory(
    id: 4,
    title: 'Trabalho',
    color: Colors.green.value,
    type: CategoryType.work.name,
  ),
];

const DUMMY_LISTS = [
  ItemList(
    id: 1,
    title: 'Compra do mês',
    listCategoryId: '1',
  ),
  ItemList(
    id: 2,
    title: 'Hortifruti',
    listCategoryId: '1',
  ),
  ItemList(
    id: 3,
    title: 'Reforma do quarto',
    listCategoryId: '2',
  ),
  ItemList(
    id: 4,
    title: 'Muambinhas',
    listCategoryId: '3',
  ),
];

const DUMMY_ITEMS = [
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
