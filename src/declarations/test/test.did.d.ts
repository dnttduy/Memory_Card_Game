import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Card { 'data' : string }
export type Error = { 'NotFound' : null } |
  { 'NotAuthorized' : null } |
  { 'AlreadyExists' : null };
export interface History {
  'startedTime' : bigint,
  'score' : bigint,
  'numberCorrectPair' : bigint,
  'selectedPairCards' : Array<[Card, Card]>,
}
export interface Player {
  'playerId' : string,
  'histories' : Array<History>,
  'isPlaying' : boolean,
}
export type Response = { 'ok' : string } |
  { 'err' : Error };
export type Response_1 = { 'ok' : Array<Player> } |
  { 'err' : Error };
export type Response_2 = { 'ok' : Array<Card> } |
  { 'err' : Error };
export type Response_3 = { 'ok' : boolean } |
  { 'err' : Error };
export interface _SERVICE {
  'createCard' : ActorMethod<[Card], Response>,
  'deleteCard' : ActorMethod<[string], Response>,
  'isValidHistory' : ActorMethod<[Array<[Card, Card]>], Response_3>,
  'listCards' : ActorMethod<[], Response_2>,
  'listDuplicatedCards' : ActorMethod<[], Response_2>,
  'listPlayers' : ActorMethod<[], Response_1>,
  'playerTakeCards' : ActorMethod<[[Card, Card]], Response>,
  'updateCard' : ActorMethod<[Card], Response>,
}
