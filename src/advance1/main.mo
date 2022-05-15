import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Result "mo:base/Result";

import Logger "mo:ic-logger/Logger";

import TextLogger "TextLogger";

actor Main {
    type Bucket = TextLogger.TextLogger;
    let buckets : Buffer.Buffer<Bucket> = Buffer.Buffer<Bucket>(0);
    // let OWNER = msg.caller;

    // stable var state : Logger.State<Text> = Logger.new<Text>(0, null);
    // let logger = Logger.Logger<Text>(state);

    // stable var allowed : TrieSet.Set<Principal> = TrieSet.empty<Principal>();
    // allowed := TrieSet.put(allowed, OWNER, Principal.hash(OWNER), Principal.equal);

    private func newBucket() : async Bucket {
        let newOne = await TextLogger.TextLogger();
        buckets.add(newOne);
        newOne
    };

    private func getBucket() : async Bucket {
        switch (buckets.size()) {
            case (0) {
                await newBucket()
            };
            case (_) {
                let latestBucket = buckets.get(buckets.size() - 1);
                let latestBucketStats = await latestBucket.stats();
                if(latestBucketStats.bucket_sizes[0] == 100) {
                    await newBucket()
                } else {
                    latestBucket
                }
            };
        }
    };

    public shared ({ caller }) func append(msgs: [Text]) : async () {
        for(msg in Array.vals(msgs)) {
            let latestBucket = await getBucket();
            await latestBucket.append([msg]);
        }
    };

    public shared ({ caller }) func view(from: Nat, to: Nat) : async Result.Result<Logger.View<Text>, Text> {
        switch (buckets.size()) {
            case (0) {
                #err("no logger")
            };
            case (_) {
                let latestBucket = buckets.get(buckets.size() - 1);
                let res = await latestBucket.view(from, to);
                #ok(res)
            };
        }
    };

    public shared func test() : async Nat {
        buckets.size()
    };

    public shared func test1() : async [Nat] {
        let latestBucket = buckets.get(buckets.size() - 1);
        let latestBucketStats = await latestBucket.stats();
        latestBucketStats.bucket_sizes
    };
};