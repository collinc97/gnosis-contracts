pragma solidity 0.4.11;
import "Tokens/StandardToken.sol";


/// @title Gnosis token contract
/// @author Stefan George - <stefan@gnosis.pm>
contract GnosisToken is StandardToken {

    /*
     *  Constants
     */
    string public constant name = "Gnosis Token";
    string public constant symbol = "GNO";
    uint8 public constant decimals = 18;

    /*
     *  Public functions
     */
    /// @dev Contract constructor function sets dutch auction contract address and assigns all tokens to dutch auction
    /// @param dutchAuction Address of dutch auction contract
    /// @param owners Array of addresses receiving preassigned tokens
    /// @param tokens Array of preassigned token amounts
    function GnosisToken(address dutchAuction, address[] owners, uint[] tokens)
        public
    {
        // Address should not be null
        require(dutchAuction != 0);
        totalSupply = 10000000 * 10**18;
        balances[dutchAuction] = 9000000 * 10**18;
        Transfer(0, dutchAuction, balances[dutchAuction]);
        uint assignedTokens = balances[dutchAuction];
        for (uint i=0; i<owners.length; i++) {
            // Address should not be null
            require(owners[i] != 0);
            balances[owners[i]] += tokens[i];
            Transfer(0, owners[i], tokens[i]);
            assignedTokens += tokens[i];
        }
        // Assigned tokens match the total supply
        require(assignedTokens == totalSupply);
    }
}
