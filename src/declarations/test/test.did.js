export const idlFactory = ({ IDL }) => {
  const Card = IDL.Record({ 'data' : IDL.Text });
  const Error = IDL.Variant({
    'NotFound' : IDL.Null,
    'NotAuthorized' : IDL.Null,
    'AlreadyExists' : IDL.Null,
  });
  const Response = IDL.Variant({ 'ok' : IDL.Text, 'err' : Error });
  const Response_3 = IDL.Variant({ 'ok' : IDL.Bool, 'err' : Error });
  const Response_2 = IDL.Variant({ 'ok' : IDL.Vec(Card), 'err' : Error });
  const History = IDL.Record({
    'startedTime' : IDL.Int,
    'score' : IDL.Int,
    'numberCorrectPair' : IDL.Int,
    'selectedPairCards' : IDL.Vec(IDL.Tuple(Card, Card)),
  });
  const Player = IDL.Record({
    'playerId' : IDL.Text,
    'histories' : IDL.Vec(History),
    'isPlaying' : IDL.Bool,
  });
  const Response_1 = IDL.Variant({ 'ok' : IDL.Vec(Player), 'err' : Error });
  return IDL.Service({
    'createCard' : IDL.Func([Card], [Response], []),
    'deleteCard' : IDL.Func([IDL.Text], [Response], []),
    'isValidHistory' : IDL.Func(
        [IDL.Vec(IDL.Tuple(Card, Card))],
        [Response_3],
        ['query'],
      ),
    'listCards' : IDL.Func([], [Response_2], ['query']),
    'listDuplicatedCards' : IDL.Func([], [Response_2], ['query']),
    'listPlayers' : IDL.Func([], [Response_1], ['query']),
    'playerTakeCards' : IDL.Func([IDL.Tuple(Card, Card)], [Response], []),
    'updateCard' : IDL.Func([Card], [Response], []),
  });
};
export const init = ({ IDL }) => { return []; };
