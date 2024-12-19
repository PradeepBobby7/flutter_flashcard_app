import 'package:flashcard_app/bloc/flashcard_bloc.dart';
import 'package:flashcard_app/bloc/flashcard_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashCardForm extends StatelessWidget {
  final int? index;
  final String? quiz;
  final String? answer;
  FlashCardForm({this.index, this.quiz, this.answer});

  final formkey = GlobalKey<FormState>();

  final TextEditingController quizController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (quiz != null && answer != null) {
      quizController.text = quiz!;
      answerController.text = answer!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(index == null ? 'New Flash Card' : 'Edit Flash Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter the Question' : null,
                controller: quizController,
                decoration: const InputDecoration(labelText: 'Question'),
              ),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? 'Please Enter the  Answer' : null,
                controller: answerController,
                decoration: const InputDecoration(labelText: 'Answer'),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      if (index == null) {
                        context.read<FlashCardBloc>().add(FlashcardNew(
                            quizController.text, answerController.text));
                      } else {
                        context.read<FlashCardBloc>().add(
                              FlashCardUpdate(index!, quizController.text,
                                  answerController.text),
                            );
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
