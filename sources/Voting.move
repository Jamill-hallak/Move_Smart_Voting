module Voting {

    resource struct Poll {
        question: String,
        options: vector<String>,
        votes: vector<u64>,
    }

    resource struct PollManager {
        owner: address,
        polls: vector<Poll>,
    }

    public fun initialize(account: &signer) {
        move_to<PollManager>(Signer::address_of(account), PollManager { owner: Signer::address_of(account), polls: vector::empty() });
    }

    public fun create_poll(account: &signer, question: String, options: vector<String>) {
        let poll_manager = borrow_global_mut<PollManager>(Signer::address_of(account));
        assert!(poll_manager.owner == Signer::address_of(account), 100); // onlyOwner check

        let poll = Poll {
            question,
            options,
            votes: vector::empty(),
        };
        vector::push_back(&mut poll_manager.polls, poll);
    }

    public fun vote(account: &signer, poll_id: u64, option_idx: u64) {
        let poll_manager = borrow_global_mut<PollManager>(Signer::address_of(account));
        let poll = vector::borrow_mut(&mut poll_manager.polls, poll_id);
        assert!(option_idx < vector::length(&poll.options), 101);
        if (vector::length(&poll.votes) == 0) {
            vector::push_back(&mut poll.votes, 0);
        }
        vector::borrow_mut(&mut poll.votes, option_idx) += 1;
    }

    // Function to view poll results
    public fun view_results(account: &signer, poll_id: u64): vector<u64> {
        let poll_manager = borrow_global<PollManager>(Signer::address_of(account));
        let poll = vector::borrow(&poll_manager.polls, poll_id);
        poll.votes
    }
}
