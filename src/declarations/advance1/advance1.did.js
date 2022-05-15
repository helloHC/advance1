export const idlFactory = ({ IDL }) => {
  const View = IDL.Record({
    'messages' : IDL.Vec(IDL.Text),
    'start_index' : IDL.Nat,
  });
  const Result = IDL.Variant({ 'ok' : View, 'err' : IDL.Text });
  return IDL.Service({
    'append' : IDL.Func([IDL.Vec(IDL.Text)], [], []),
    'test' : IDL.Func([], [IDL.Nat], []),
    'test1' : IDL.Func([], [IDL.Vec(IDL.Nat)], []),
    'view' : IDL.Func([IDL.Nat, IDL.Nat], [Result], []),
  });
};
export const init = ({ IDL }) => { return []; };
