import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/sms_controller.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final TextEditingController _smsController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smsState = ref.watch(smsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Bolt'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _smsController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Entrez le texte du SMS',
                border: OutlineInputBorder(),
                hintText: 'Collez ici le contenu du SMS...',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: smsState.isLoading
                    ? null
                    : () => ref
                        .read(smsControllerProvider.notifier)
                        .processSms(_smsController.text),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: smsState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Traiter le SMS',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            if (smsState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Erreur: ${smsState.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (smsState.hasValue && smsState.value!.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Card(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        smsState.value!['discordMessage'] as String? ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
