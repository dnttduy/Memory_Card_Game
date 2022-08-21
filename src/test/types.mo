module {
    public type Card = {
        data : Text;
    };

    public type Player = {
        playerId : Text;
        isPlaying : Bool;
        histories : [History];
    };

    public type History = {
        startedTime : Int;
        selectedPairCards : [(Card, Card)];
        numberCorrectPair : Int;
        score : Int;
    };

    public type Error = {
        #NotFound;
        #AlreadyExists;
        #NotAuthorized;
    };

};
