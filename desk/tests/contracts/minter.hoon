::
::  tests for con/minter.hoon
::
/+  *test, *transaction-sim
/=  minter  /con/minter
/*  minter-contract  %jam  /con/compiled/minter/jam
/*  nft-contract %jam /con/compiled/nft/jam
|%
::
::  test data
::
++  sequencer  caller-1
++  caller-1  ^-  caller:smart  [addr-1 1 (id addr-1)]:zigs
++  caller-2  ^-  caller:smart  [addr-2 1 (id addr-2)]:zigs
++  caller-3  ^-  caller:smart  [addr-3 1 (id addr-3)]:zigs
++  caller-4  ^-  caller:smart  [addr-4 1 (id addr-4)]:zigs
::
++  my-shell  ^-  shell:smart
  [caller-1 ~ id.p:minter-pact [1 1.000.000] default-town-id 0]
::
++  nft-1  (hash-data:smart id.p:nft-pact addr-1:zigs default-town-id 'nft1')
::
++  nft-item         :: premint?
  ^-  item:smart
  :-  %&
  :*  nft-1
      id.p:nft-pact  :: 0xcafe.babe
      addr-1:zigs
      'nft1'
      label=%nft
      :*  1
          'https://i.imgur.com/yHp31fs.png'
          id:nft-collection
          ~
          %-  ~(gas py:smart *(pmap:smart @tas @t))
          `(list [@tas @t])`~[[%name 'marqus']]
          %.y
      ==
  ==
++  nft-collection
  ^-  item:smart
  :*  %&
      id=`@ux`'nft-metadata'  :: 0x6174.6164.6174.656d.2d74.666e
      salt=`@`'nftsalt'
      label=%metadata
      :*  name='UQ Names'
          symbol='UQN'
          properties=(~(gas pn:smart *(pset:smart @tas)) `(list @tas)`~[%name])
          supply=10.000
          cap=`10.000
          mintable=%.y
          minters=(~(gas pn:smart *(pset:smart address:smart)) ~[id.p:minter-pact])
          deployer=caller-1
          salt=`@`'nftsalt'
      ==
      source=0xcafe.babe
      holder=0xcafe.babe
      town-id
  ==
++  nft-pact
  ^-  item:smart
  =/  code  (cue nft-contract)
  =/  id    (hash-pact:smart 0xdead.beef 0xdead.beef default-town-id code)
  ::  should be 0x58ba.a29a.ca62.331c.c86c.413e.3e09.519d.5c31.dce1.e6b1.5409.b8d2.78d3.792f.aed1
  :*  %|  id
      0xdead.beef  ::  source
      0xdead.beef  ::  holder
      default-town-id
      [-.code +.code]
      ~
  ==
::
++  minter-pact
  ^-  item:smart
  =/  code  (cue minter-contract)
  =/  id  (hash-pact:smart 0x1234.5678 0x1234.5678 default-town-id code)
  :*  %|  id
      0x1234.5678  ::  source
      0x1234.5678  ::  holder
      default-town-id
      [-.code +.code]
      ~
  ==
::
++  state
  %-  make-chain-state
  :~  minter-pact
      nft-pact
      nft-collection      :: uqnames item
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
    [fake-sig [%mint id.p.nft-collection 'https://i.imgur.com/yHp31fs.png' 'marqqus' ~] my-shell]
  :*  gas=~
      errorcode=`%0
      modified=`~     :: `(make-chain-state ~[org-item])
      burned=`~
      events=`~
  ==
::
::  tests for %edit-org
::
::  ++  test-yz-edit-org-not-controller  ^-  test-txn
::    :^    chain
::        [sequencer default-town-id batch=1 eth-block-height=0]
::      =+  [caller-2 ~ id.p:orgs-pact [1 1.000.000] default-town-id 0]
::      [fake-sig [%edit-org my-test-org-id /my-test-org `'newdesc' ~] -]
::    :*  gas=~
::        errorcode=`%6
::        modified=`~
::        burned=`~
::        events=`~
::    ==
::
::  ++  test-yy-edit-org
::    :^    chain
::        [sequencer default-town-id batch=1 eth-block-height=0]
::      [fake-sig [%edit-org my-test-org-id /my-test-org `'newdesc' ~] my-shell]
::    :*  gas=~
::        errorcode=`%0
::        ::  modified the org
::        :-  ~
::        %-  make-chain-state
::        :_  ~
::        %-  my-test-org
::        :*  'my-test-org'
::            `'newdesc'
::            addr-1:zigs
::            ~
::            %-  make-pmap:smart
::            ~['my-sub-org'^['my-sub-org' ~ addr-2:zigs ~ ~]]
::        ==
::        burned=`~
::        events=`~
::    ==
::
--