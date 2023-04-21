::
::  tests for con/minter.hoon
::  put in %zig desk along with contracts to test.
::  
::
/+  *test, *transaction-sim
/=  minter  /con/minter
/*  minter-contract  %jam  /con/compiled/minter/jam
/*  nft-contract     %jam  /con/compiled/nft/jam
|%
::
::  test data
::
++  sequencer  caller-1
++  caller-1  ^-  caller:smart  [addr-1 1 (id addr-1)]:zigs
++  caller-2  ^-  caller:smart  [addr-2 1 (id addr-2)]:zigs
++  caller-3  ^-  caller:smart  [addr-3 1 (id addr-3)]:zigs
::
++  my-shell  ^-  shell:smart
  [caller-1 ~ id.p:minter-pact [1 1.000.000] default-town-id 0]
::::
++  minter-pact
  ::  note, if you modify the nft contract, update the hardcoded value in lib/minter.hoon
  ^-  item:smart
  =/  code  (cue minter-contract)
  =/  id  (hash-pact:smart 0x0 0x0 default-town-id code)
  :*  %|  id
      0x0  ::  source
      0x0  ::  holder
      default-town-id
      [-.code +.code]
      ~
  ==
::
++  nft-pact
  ^-  item:smart
  =/  code  (cue nft-contract)
  =/  id    (hash-pact:smart 0x0 0x0 default-town-id code)
  :*  %|  id
      0x0  ::  source
      0x0  ::  holder
      default-town-id
      [-.code +.code]
      ~
  ==
::
++  nft-collection
  ^-  item:smart
  :*  %&
      id=(hash-data id.p:nft-pact id.p:nft-pact default-town-id 'nftsalt')
      source=id.p:nft-pact
      holder=id.p:nft-pact
      default-town-id
      salt=`@`'nftsalt'
      label=%metadata
      :*  name='UQ Names'
          symbol='UQN'
          properties=(~(gas pn:smart *(pset:smart @tas)) `(list @tas)`~[%name])
          supply=69
          cap=`10.000
          mintable=%.y
          minters=(make-pset:smart `(list @ux)`~[address:caller-1 id.p:minter-pact])
          deployer=address:caller-1
          salt=`@`'nftsalt'
  ==  ==
::
++  nft-id  (hash-data:smart id.p:nft-pact addr-1:zigs default-town-id (cat 3 'nftsalt' (scot %ud 70)))
::
++  nft-item        
  ^-  item:smart
  :*  %&
      nft-id
      id.p:nft-pact  ::  source
      addr-1:zigs    ::  holder
      default-town-id
      (cat 3 'nftsalt' (scot %ud 70))
      label=%nft
      :*  70
          'https://i.imgur.com/yHp31fs.png'
          id.p:nft-collection
          ~
          %-  ~(gas py:smart *(pmap:smart @tas @t))
          `(list [@tas @t])`~[[%name 'marqus']]
          %.y
  ==  ==
::
++  username-id  (hash-data:smart id.p:minter-pact id.p:nft-collection 0x0 'marqus')
::
++  username-item
  ^-  item:smart
  :*  %&
      username-id
      id.p:minter-pact     ::  source
      id.p:nft-collection  ::  holder
      0x0
      'marqus'
      label=%lookup
      [address:caller-1 ~] ::  [@ux (unit @p)]
  == 
++  state
  %-  make-chain-state
  ::
  :~  minter-pact
      nft-collection      :: uqnames item
      nft-pact
      (account addr-1 300.000.000 ~):zigs
      (account addr-2 200.000.000 ~):zigs
  ==
++  chain
  ^-  chain:engine
  [state ~]
::
::  tests for %mint
::
++  test-zz-mint  ^-  test-txn
  ::
  :^    chain
      [sequencer default-town-id batch=1 eth-block-height=0]
    [fake-sig [%mint id.p:nft-collection 'marqus' 'https://i.imgur.com/yHp31fs.png' ~] my-shell]
  :*  gas=~
      errorcode=`%0
      ::  doublecheck merk-items below
      modified=`(make-chain-state ~[username-item nft-item nft-collection])    
      burned=`~
      events=`~
  ==
::
--
