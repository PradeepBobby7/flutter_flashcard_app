import 'package:flashcard_app/bloc/flashcard_bloc.dart';
import 'package:flashcard_app/bloc/flashcard_event.dart';
import 'package:flashcard_app/bloc/flashcard_state.dart';
import 'package:flashcard_app/flashcard_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashCardScreen extends StatelessWidget {
  const FlashCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Card'),
      ),
      body: BlocBuilder<FlashCardBloc, FlashcardState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.flashCards.length,
            itemBuilder: (context, index) {
              final flashcard = state.flashCards[index];
              return Card(
                child: ListTile(
                  title: Text(flashcard['quiz']!),
                  onTap: () =>
                      context.read<FlashCardBloc>().add(FlashcardAnswer(index)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            showAnswer(context, flashcard['answer']!),
                        icon: const Icon(Icons.lightbulb_circle),
                      ),
                      IconButton(
                        onPressed: () =>
                            updateFlashCard(context, index, flashcard),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => deleteFlashcard(context, index),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addFlashcard(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void addFlashcard(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: context.read<FlashCardBloc>(),
        child: FlashCardForm(),
      ),
    ),
  );
}

void showAnswer(BuildContext context, String answer) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(answer),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('Close'))
      ],
    ),
  );
}

void updateFlashCard(
    BuildContext context, int index, Map<String, String> flashcard) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: context.read<FlashCardBloc>(),
        child: FlashCardForm(
          index: index,
          quiz: flashcard['quiz']!,
          answer: flashcard['answer']!,
        ),
      ),
    ),
  );
}

void deleteFlashcard(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confrim Delete !'),
      content: const Text('Are you Sure you want Delete'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
            onPressed: () {
              context.read<FlashCardBloc>().add(FlashCardDelete(index));
              Navigator.pop(context);
            },
            child: const Text('Delete'))
      ],
    ),
  );
}
