import type { Principal } from '@dfinity/principal';
export type Result = { 'ok' : View } |
  { 'err' : string };
export interface View { 'messages' : Array<string>, 'start_index' : bigint }
export interface _SERVICE {
  'append' : (arg_0: Array<string>) => Promise<undefined>,
  'test' : () => Promise<bigint>,
  'test1' : () => Promise<Array<bigint>>,
  'view' : (arg_0: bigint, arg_1: bigint) => Promise<Result>,
}
