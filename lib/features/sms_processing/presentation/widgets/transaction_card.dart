import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String balance;
  final String name;
  final String phone;
  final String reference;
  final String operator;
  final String type;
  final DateTime timestamp;

  const TransactionCard({
    super.key,
    required this.amount,
    required this.balance,
    required this.name,
    required this.phone,
    required this.reference,
    required this.operator,
    required this.type,
    required this.timestamp,
  });

  String _getOperatorEmoji(String operator) {
    switch (operator.toUpperCase()) {
      case 'M-PESA':
        return '🟢';
      case 'ORANGE MONEY':
      case 'ORANGE':
        return '🟠';
      case 'AIRTEL MONEY':
      case 'AIRTEL':
        return '🔴';
      default:
        return '🏢';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '⏰ ${DateFormat('dd/MM/yyyy HH:mm').format(timestamp)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        '💰 Transaction ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        type == 'RECEIVE' ? '⬇️' : '⬆️',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '💵 Montant: $amount USD',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '💳 Solde: $balance USD',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '👤 ${type == 'RECEIVE' ? 'De' : 'À'}: $name',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '📱 Téléphone: $phone',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '🔖 Référence: $reference',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '🏢 Opérateur: ${_getOperatorEmoji(operator)} $operator',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  '🤖 Traité par CoBolt',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
