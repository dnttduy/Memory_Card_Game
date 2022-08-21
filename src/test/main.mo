import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Time "mo:base/Time";

import Card "./game/card";
import Player "./game/player";
import State "state";
import Types "types";


actor {
  var state : State.State = State.empty();
  type Response<Ok> = Result.Result<Ok, Types.Error>;

  public shared({caller}) func createCard(card : Types.Card) : async Response<Text> {
    // if (Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);
    // };

    let rs = state.cards.get(card.data);
    switch(rs) {
      case null {
        let created = Card.create(card, state);
        #ok("Success");
      };
      case (?V) {
        #err(#AlreadyExists);
      };
    };
  };

  public shared({caller}) func updateCard(card : Types.Card) : async Response<Text> {
    // if (Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);
    // };

    let rs = state.cards.get(card.data);
    switch(rs) {
      case null {
        #err(#NotFound);
      };
      case (?V) {
        let updated = Card.update(card, state);
        #ok("Success");
      };
    };
  };

  public shared({caller}) func deleteCard(id : Text) : async Response<Text> {
    // if (Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);
    // };

    let rs = state.cards.get(id);
    switch(rs) {
      case null {
        #err(#NotFound);
      };
      case (?V) {
        let created = state.cards.delete(id);
        #ok("Success");
      };
    };
  };


  public shared query({caller}) func listCards() : async Response<[Types.Card]> {
    var list : [Types.Card] = [];
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };

    for((_,V) in state.cards.entries()) {
      list := Array.append<Types.Card>(list, [V]);
    };
    #ok((list));
  };

  public shared query({caller}) func listDuplicatedCards() : async Response<[Types.Card]> {
    var list : [Types.Card] = [];
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };

    for((_,V) in state.cards.entries()) {
      list := Array.append<Types.Card>(list, [V]);
      list := Array.append<Types.Card>(list, [V]); // create duplicate card
    };
    #ok((list));
  };

  // -----------------------------------------------------------------------------------------
  public shared({caller}) func playerTakeCards(pairCard : (Types.Card, Types.Card)) : async Response<Text> {
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };

    let playerid = Principal.toText(caller);
    let rs = state.players.get(playerid);
    switch(rs) {
      case null {
        let newPlayer : Types.Player = await Player.create(playerid, state);
        let created = Player.createHistory(newPlayer, pairCard, state);
        #ok("Success");
      };
      case (?V) {
        if (V.isPlaying == false) {
          let updated = Player.createHistory(V, pairCard, state);
        } else {
          let updated = Player.updateHistory(V, pairCard, Time.now(), state);
        };
        #ok("Success");
      };
    };
  };

  public shared query({caller}) func isValidHistory(listFromClient : [(Types.Card, Types.Card)]) : async Response<Bool> {
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };

    let playerid = Principal.toText(caller);
    let rs = state.players.get(playerid);
    switch(rs) {
      case null {
        #err(#NotFound);
      };
      case (?V) {
        let lastestHistory = V.histories[V.histories.size() - 1];
        if (V.isPlaying == false and lastestHistory.selectedPairCards == listFromClient) {
          return #ok(true);
        };
        #ok(false);
      };
    }
  };


  public shared query({caller}) func listPlayers() : async Response<[Types.Player]> {
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };

    var list : [Types.Player] = [];
    for ((_,V) in state.players.entries()) {
      list := Array.append<Types.Player>(list, [V]);
    }; 
    return #ok(list);
  };
  
};
