// Do not change these configurations after the blockchain is initialized
module.exports = {
    // INFO: It is a reward to mine a block
    MINING_REWARD: 500,
    // INFO: Usually it's a fee over transaction size (not quantity)
    FEE_PER_TRANSACTION: 1,
    // INFO: Usually the limit is determined by block size (not quantity)
    TRANSACTIONS_PER_BLOCK: 2,
    genesisBlock: {
        index: 0,
        previousHash: '0',
        timestamp: 1465154705,
        nonce: 0,
        transactions: [
            {
                id: '63ec3ac02f822450039df13ddf7c3c0f19bab4acd4dc928c62fcd78d5ebc6dba',
                hash: null,
                type: 'regular',
                data: {
                    inputs: [],
                    outputs: []
                }
            }
        ]
    },
    pow: {
        getDifficulty: (blocks, index) => {
            // Proof-of-work difficulty settings
            const BASE_DIFFICULTY = Number.MAX_SAFE_INTEGER;
            const EVERY_X_BLOCKS = 5;
            const POW_CURVE = 5;

            return Math.max(
                Math.floor(
                    BASE_DIFFICULTY / Math.pow(
                        Math.floor(((index || blocks.length) + 1) / EVERY_X_BLOCKS) + 1
                        , POW_CURVE)
                )
                , 0);
        }
    }
};