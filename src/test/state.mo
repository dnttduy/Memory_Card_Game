import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";

import Types "types";

module {
    private type Map<K, V> = TrieMap.TrieMap<K, V>;

    public type State = {
        cards : Map<Text, Types.Card>;
        players : Map<Text, Types.Player>;
    };

    public func empty() : State {
        {
            cards = TrieMap.TrieMap<Text, Types.Card>(Text.equal,Text.hash);
            players = TrieMap.TrieMap<Text, Types.Player>(Text.equal,Text.hash);
        }
    }
};