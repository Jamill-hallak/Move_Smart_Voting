module Voting {

    resource struct Poll {
        question: String,
        options: vector<String>,
        votes: vector<u64>,
    }

    resource struct PollManager {
        polls: vector<Poll>,
    }

    public fun initialize(account: &signer) {
        move_to<PollManager>(Signer::address_of(account), PollManager { polls: vector::empty() });
    }

    public fun create_poll(account: &signer, question: String, options: vector<String>) {
        let poll_manager = borrow_global_mut<PollManager>(Signer::address_of(account));
        let poll = Poll {
            question,
            options,
            votes: vector::empty(),
        };
        vector::push_back(&mut poll_manager.polls, poll);
    }
}
