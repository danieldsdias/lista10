import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text('\$${transactions[index].amount}'),
                ),
              ),
            ),
            title: Text(
              transactions[index].title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[index].date),
            ),
            trailing: MediaQuery.of(context).size.width > 360
                ? TextButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).errorColor),
                    onPressed: () => deleteTx(transactions[index].id),
                  )
                : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
