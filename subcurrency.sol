contract Coin{
    // The keyword public it's making the variables
    // here accesible from other contract
    address public minter;
    mapping(address => uint) public balances;

    // Events allows clients to react to specific contract changes you declare

    /* Event is an inheritable number of a contract. An event is emitted, 
    it stores the arguments passed in transaction logs. These logs are stored on blockchain
    and are accesible using address of the contract till the present on the blockchains. */
    event Sent(address from, address to, uint amount);

    // Contructor only run when when the contract is created
    constructor(){
        minter = msg.sender;
    }

    // make new coins and send them to an address
    // only the owner can send these coins
    function mint(address receiver , uint amount) public {
        require(msg.sender == minter);  
        balances[receiver] += amount;
    }
    // send any amount of coins
    // to an existing address 
    error insufficientError( uint requested, uint available);

    function send(address receiver , uint amount) public {
        // require amount is greater than x=true and then run this
        if(amount > balances[msg.sender])
        revert insufficientError({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
