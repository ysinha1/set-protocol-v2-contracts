pragma solidity 0.6.10;
pragma experimental "ABIEncoderV2";

/**
 * @title OneInchV2ExchangeAdapter
 * @author Yash Sinha // Set Protocol
 *
 * Exchange adapter for 1Inch v2 exchange that returns data for trades
 */

//TODO: Clarify whether this adapter is support to generate or validate calldata
contract OneInchV2ExchangeAdapter {

    /* ============ Structs ============ */

    /**
     * Struct containing information for trade function
     */
    struct SwapDescription {
        IERC20 srcToken;
        IERC20 dstToken;
        address srcReceiver;
        address dstReceiver;
        uint256 amount;
        uint256 minReturnAmount;
        uint256 guaranteedAmount;
        uint256 flags;
        address referrer;
        bytes permit;
    }
    
    /* ============ State Variables ============ */
    
    // Address of 1Inch approve token address
    address public oneInchV2ApprovalAddress;

    // Address of 1Inch exchange address
    address public oneInchV2ExchangeAddress;

    // Bytes to check 1Inch function signature
    bytes4 public oneInchV2FunctionSignature;

     /* ============ Constructor ============ */

    /**
     * Set state variables
     *
     * @param _oneInchV2ApprovalAddress       Address of 1inchV2 approval contract
     * @param _oneInchV2ExchangeAddress       Address of 1inchV2 exchange contract
     * @param _oneInchV2FunctionSignature     Bytes of 1inchV2 function signature
     */
    constructor(
        address _oneInchV2ApprovalAddress,
        address _oneInchV2ExchangeAddress,
        bytes4 _oneInchV2FunctionSignature
    )
        public
    {
        oneInchV2ApprovalAddress = _oneInchV2ApprovalAddress;
        oneInchV2ExchangeAddress = _oneInchV2ExchangeAddress;
        oneInchV2FunctionSignature = _oneInchV2FunctionSignature;
    }

 /* ============ External Getter Functions ============ */

    /**
     * Return 1inch calldata which is already generated from the 1inch API
     *
     * @param  _sourceToken              Address of source token to be sold
     * @param  _destinationToken         Address of destination token to buy
     * @param  _sourceQuantity           Amount of source token to sell
     * @param  _minDestinationQuantity   Min amount of destination token to buy
     * @param  _data                     Arbitrage bytes containing trade call data
     *
     * @return address                   Target contract address
     * @return uint256                   Call value
     * @return bytes                     Trade calldata
     */
    function getTradeCalldata(
        address _sourceToken,
        address _destinationToken,
        address _destinationAddress,
        uint256 _sourceQuantity,
        uint256 _minDestinationQuantity,
        bytes memory _data
    )
        external
        view
        returns (address, uint256, bytes memory)
    {
        SwapDescription memory swapDescription;
        swapDescription.srcToken = IERC20(_sourceToken); //do we really need to cast this? 
        swapDescription.dstToken = IERC20(_destinationToken);
        //tl;dr either just do input validation or leave it


        return (oneInchExchangeAddress, 0, _data);
    }

    /**
     * Returns the address to approve source tokens to for trading. This is the TokenTaker address
     *
     * @return address             Address of the contract to approve tokens to
     */
    function getSpender()
        external
        view
        returns (address)
    {
        return oneInchV2ApprovalAddress;
    }
}
