module Voting {
    
    // 1. Define the Poll Resource
    resource struct Poll {
        question: String,
        options: vector<String>,
        votes: vector<u64>,
    }

    // 2. Define the PollManager Resource
    resource struct PollManager {
        polls: vector<Poll>,
    }
}
