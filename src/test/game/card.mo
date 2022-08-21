import State "../state";
import Types "../types";

module Card {
  public func getData(card : Types.Card) : Types.Card {
    var newCard : Types.Card = {
      data = card.data;
    };
    return newCard;
  };

  public func create(card : Types.Card, state : State.State)  {
    let created = state.cards.put(card.data, card);
  };

  public func update(card : Types.Card, state : State.State) {
    let updated = state.cards.replace(card.data, card);
  };

  public func isCorrectPairCard(paircard : (Types.Card, Types.Card)) : Int {
    return if (paircard.0 == paircard.1) { 1 } else { 0 }; 
  };

  public func isDuplicatePairCard(paircard : (Types.Card, Types.Card), listcards : [(Types.Card, Types.Card)]) : Bool {
    for (cards in listcards.vals()) {
      if ( isCorrectPairCard(paircard) == 1 and (cards.0 == paircard.0 and cards.1 == paircard.1)) return true;
    };
    false;
  };  
};