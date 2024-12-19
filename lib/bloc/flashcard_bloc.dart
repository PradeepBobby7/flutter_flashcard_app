import 'package:bloc/bloc.dart';
import 'package:flashcard_app/bloc/flashcard_event.dart';
import 'package:flashcard_app/bloc/flashcard_state.dart';

class FlashCardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  FlashCardBloc() : super(FlashcardState(flashCards: [])) {
    on<FlashcardNew>((event, emit) {
      final updateCard = List<Map<String, String>>.from(state.flashCards)
        ..add({'quiz': event.newCard, 'answer': event.answer});
      emit(FlashcardState(flashCards: updateCard));
    });

    on<FlashcardAnswer>((event, emit) {
      final answer = state.flashCards[event.index]['answer'];
      emit(FlashcardState(flashCards: state.flashCards, currentAnswer: answer));
    });

    on<FlashCardUpdate>((event, emit) {
      final updateCard = List<Map<String, String>>.from(state.flashCards)
        ..[event.index] = {'quiz': event.editCard, 'answer': event.editAnswer};
      emit(FlashcardState(flashCards: updateCard));
    });

    on<FlashCardDelete>((event, emit) {
      final updateCards = List<Map<String, String>>.from(state.flashCards)
        ..removeAt(event.index);
      emit(FlashcardState(flashCards: updateCards));
    });
  }


  // Stream<FlashcardState> mapEventToState(FlashcardEvent event) async* {
  //   if (event is FlashcardNew) {
  //     final updateCard = List<Map<String, String>>.from(state.flashCards)
  //       ..add({'quiz': event.newCard, 'answer': event.answer});
  //     yield FlashcardState(flashCards: updateCard);
  //   } else if (event is FlashcardAnswer) {
  //     final showAnswer = state.flashCards[event.index]['answer'];
  //     yield FlashcardState(
  //         flashCards: state.flashCards, currentAnswer: showAnswer);
  //   } else if (event is FlashCardUpdate) {
  //     final updateCard = List<Map<String, String>>.from(state.flashCards);

  //     updateCard[event.index] = {
  //       'quiz': event.editCard,
  //       'answer': event.editAnswer
  //     };
  //     yield FlashcardState(flashCards: updateCard);
  //   } else if (event is FlashCardDelete) {
  //     final updateCard = List<Map<String, String>>.from(state.flashCards)
  //       ..removeAt(event.index);
  //     yield FlashcardState(flashCards: updateCard);
  //   }
  // }
}
