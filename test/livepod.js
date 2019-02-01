var LivePod_Token = artifacts.require("./livepod_token.sol");

contract('LivePod_Token', function(accounts){
  var tokenInstance;

it('inicializálva a contract correkt értékekkel', function(){
  return LivePod_Token.deployed().then(function(instance){
    tokenInstance=instance;
    return tokenInstance.name();
  }).then(function(name){
    assert.equal(name,'LIVEPOD TOKEN', 'helyes név megadás');
  });
});

  it('totalsupply beallitva',function(){
    return LivePod_Token.deployed().then(function(instance){
      tokenInstance = instance;
      return tokenInstance.totalSupply();
    }).then(function(totalSupply){
      assert.equal(totalSupply.toNumber(),300000000,'totalSupply beallitva 300,000,000');
      return tokenInstance.balanceOf(accounts[1]);
    }).then(function(adminBalance){
      assert.equal(adminBalance.toNumber(),300000000,'atveszi az initSupplyt admintol');
    });
  });

  it('tokentulajdonos ',function(){
    return LivePod_Token.deployed().then(function(instance){
      tokenInstance=instance;
      return tokenInstance.transfer.call(accounts[2],9999999999999);
    }).then(assert.fail).catch(function(error){
      assert(error.message.indexOf('revert')>= 0,'hibauzenet a tartalom visszaallitasarol');
      return tokenInstance.transfer(accounts[2],250000,{from:accounts[1]});
    }).then(function(recipt){
      assert.equal(recipt.logs.length,1,'egy esemény trigger');
      assert.equal(recipt.logs[0].event,'Szállítás','Transfer esemény lenne' );
      assert.equal(recipt.logs[0].args._from, accounts[1],'token elment forrástól');
      assert.equal(recipt.logs[0].args._to, accounts[2],'token megérkezett a címzetthez');
      assert.equal(recipt.logs[0].args._value, 250000,'token elment forrástól');
      return tokenInstance.balanceOf(accounts[2]);
    }).then(function(balance){
      assert.equal(balance.toNumber(), 250000,' hozzáadja a küldeményt a célcímre');
      return tokenInstance.balanceOf(accounts[1]);
    }).then(function(balance){
      assert.equal(balance.toNumber(),750000,'levonás a küldő számlájáról');
    });
  });
  it('jóváhagyja a felhatalmazott átutaláshoz szükséges tokeneket', function(){
    return LivePod_Token.deployed().then(function(instance){
      tokenInstance=instance;
      return tokenInstance.approve.call(accounts[2],100);
    }).then(function(success){
      assert.equal(success,true,'igaz érték visszaadva');
    });
  })
});
