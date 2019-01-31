var LivePod_Token =artifacts require("./livePod_token.sol");

contract('LivePod_Token', function(accounts)}{
  var tokenInstance;

  it('totalsupply beallitva',function(){
    return LivePod_Token.deployed().then(function(instance){
      tokenInstance = instance;
      return tokenInstance.totalSupply();
    }) then(function(totalSupply){
      assert equal(totalSupply.toNumber(),300000000,'totalSupply beállítva 300,000,000');
      return tokenInstance balanceOf(accounts[1]);
    }) then (function(adminBalance){
      assert equal(adminBalance.toNumber(),300000000,'atveszi az initSupplyt');
    });
  });
});
