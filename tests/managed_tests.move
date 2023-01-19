// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

#[test_only]
module fungible_tokens::managed_tests {

    use fungible_tokens::managed::{Self, MANAGED};
    use sui::coin::{Coin, TreasuryCap};
    use sui::test_scenario::{Self, next_tx, ctx};

   #[test]
    fun test_mint_burn() {
        // Initialize a mock sender address
        let user = @0xA;

        // Begins a multi transaction scenario with 'user' as the sender
        let scenario = test_scenario::begin(user);
        
        // Run the managed coin module init function
        {
            managed::test_init(ctx(&mut scenario))
        };

        // Mint a 'Coin<MANAGED>' object
        next_tx(&mut scenario, user);
        {
            let treasury_cap = test_scenario::take_from_sender<TreasuryCap<MANAGED>>(&scenario);
            let num_coins = 42;
            managed::mint(&mut treasury_cap, num_coins, user, test_scenario::ctx(&mut scenario));
            test_scenario::return_to_address<TreasuryCap<MANAGED>>(user, treasury_cap);
        };

        // Burn a 'Coin<MANAGED>' object
        next_tx(&mut scenario, user);
        {
            let coin = test_scenario::take_from_sender<Coin<MANAGED>>(&scenario);
            let treasury_cap = test_scenario::take_from_sender<TreasuryCap<MANAGED>>(&scenario);
            managed::burn(&mut treasury_cap, coin);
            test_scenario::return_to_address<TreasuryCap<MANAGED>>(user, treasury_cap);
        };

        // Cleans up the scenario object
        test_scenario::end(scenario);
    }
}
