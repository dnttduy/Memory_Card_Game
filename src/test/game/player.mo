import Array "mo:base/Array";
import Time "mo:base/Time";

import Card "./card";
import State "../state";
import Types "../types";

module Player {
  public func init(caller : Text) : Types.Player {
    var newPlayer: Types.Player = {
      playerId = caller;
      isPlaying = false;
      histories = [];
    };
    return newPlayer;
  };

  public func create(caller : Text, state : State.State) : async Types.Player {
    let init_player = init(caller);
    let created = state.players.put(caller, init_player);
    init_player;
  };

  public func update(player : Types.Player, state : State.State) {
    let updated = state.players.replace(player.playerId, player);
  };

  public func createHistory(player : Types.Player, paircard : (Types.Card, Types.Card), state : State.State) {
    let newHistory : Types.History = {
        startedTime = Time.now()/1000000000;
        selectedPairCards = [paircard];
        numberCorrectPair = Card.isCorrectPairCard(paircard);
        score = 1;
    };

    let newPlayer : Types.Player = {
        playerId = player.playerId;
        isPlaying = true;
        histories = Array.append(player.histories, [newHistory]);
    };

    let updated = update(newPlayer, state);
  };

  public func updateHistory(player : Types.Player, paircard : (Types.Card, Types.Card), overTime : Int, state : State.State) {
    // lay cac lich su da choi xong
    var listHistories = Array.thaw<Types.History>(player.histories);

    // lich su dang choi
    var lastestHistory = listHistories[listHistories.size() - 1];

    // kiem tra cap card co bi trung trong mang cac cap da chon khong
    if (Card.isDuplicatePairCard(paircard, lastestHistory.selectedPairCards) == false) {
      var numberCorrectPair =  if (lastestHistory.numberCorrectPair + Card.isCorrectPairCard(paircard) == state.cards.size()) {true} else {false};
      let newHistory : Types.History = {
          startedTime = lastestHistory.startedTime;
          selectedPairCards = Array.append(lastestHistory.selectedPairCards, [paircard]);
          numberCorrectPair = lastestHistory.numberCorrectPair + Card.isCorrectPairCard(paircard);
          score = lastestHistory.score + 1 + (if (numberCorrectPair == true) { (overTime/1000000000) -  lastestHistory.startedTime} else { 0 });
      };

      listHistories[listHistories.size() - 1] := newHistory;

      let newPlayer : Types.Player = {
          playerId = player.playerId;
          isPlaying = if (numberCorrectPair == true) { false } else { player.isPlaying };
          histories = Array.freeze<Types.History>(listHistories);
      };

      let updated = update(newPlayer, state);
    };

  };


};