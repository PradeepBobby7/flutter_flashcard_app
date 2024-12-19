abstract class FlashcardEvent {}

class FlashcardNew extends FlashcardEvent {
  final String newCard;
  final String answer;
  FlashcardNew(this.newCard,this.answer);
}

class FlashcardAnswer extends FlashcardEvent {
  final int index;
  FlashcardAnswer(this.index);
}

class FlashCardUpdate extends FlashcardEvent {
  final int index;
  final String editCard;
  final String editAnswer;
  FlashCardUpdate(this.index, this.editCard, this.editAnswer);
}

class FlashCardDelete extends FlashcardEvent {
  final int index;
  FlashCardDelete(this.index);
}
