// import Principal "mo:base/Principal";
import TrieSet "mo:base/TrieSet";

import Logger "mo:ic-logger/Logger";

shared (msg) actor class TextLogger() {
    let OWNER = msg.caller;

    stable var state : Logger.State<Text> = Logger.new<Text>(0, null);
    let logger = Logger.Logger<Text>(state);

    // stable var allowed : TrieSet.Set<Principal> = TrieSet.empty<Principal>();
    // allowed := TrieSet.put(allowed, OWNER, Principal.hash(OWNER), Principal.equal);

    // public shared ({ caller }) func allow(ids: Principal) {
    //   assert(caller == OWNER);
    //   allowed := TrieSet.put(allowed, ids, Principal.hash(ids), Principal.equal);
    // };

    public query func stats() : async Logger.Stats {
      logger.stats()
    };

    public shared ({ caller }) func append(msgs: [Text]) : async () {
      // assert(TrieSet.mem(allowed, caller, Principal.hash(caller), Principal.equal));
      logger.append(msgs);
    };

    public shared query ({ caller }) func view(from: Nat, to: Nat) : async Logger.View<Text> {
      // assert(TrieSet.mem(allowed, caller, Principal.hash(caller), Principal.equal));
      logger.view(from, to);
    };

    public shared ({ caller }) func pop_buckets(num: Nat) {
      // assert(TrieSet.mem(allowed, caller, Principal.hash(caller), Principal.equal));
      logger.pop_buckets(num)
    }
};
