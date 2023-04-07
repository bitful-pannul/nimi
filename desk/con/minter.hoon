/+  *zig-sys-smart
::
::  Proxy contract for minting name/pfp nft:s 
::  Also a sort of registry
::  
::
|_  =context
::
+$  action
  $%  [%mint nft=@ux name=@t pfp=@t ship=(unit @p)]
      [%deploy-registry ~]
  ==
+$  registry-state
  $:  shipux=(map @p @ux)
      uxship=(map @ux @p)
  ==
::
++  write
  |=  act=action
  ^-  (quip call diff)
  ?-    -.act
      %deploy-registry
    ::  contract/data separation makes it possible for several registries.
    ::  the salt setting here allows for 1 per contract
    =/  =id  (hash-data this.context this.context town.context (cat 3 this.context 'nickname-registry'))
    =/  =item
      :*  %&  id
          this.context
          this.context
          town.context
          (cat 3 this.context 'nickname-registry') 
          %registry  [~ ~]
      ==
    `(result ~ item^~ ~ ~)
    ::
      %mint
    ::  transferrable? yes mayb
    =+  id=(hash-data this.context this.context town.context (cat 3 this.context 'nickname-registry'))
    ::
    =+  (need (scry-state id))
    =/  registry  (husk registry-state - `this.context ~)
    ::
    =/  properties  %-  make-pmap
      ^-  (list [@tas @t])
      :~  [%name name.act]
          [%ship ?~(ship.act 'esta' (scot %p (need ship.act)))]      :: is empty string ok?
      ==
    ::
    =/  mintcalls
      :~  :+  nft-contract
            town.context
          :*  %mint
              nft.act
              ~[[id.caller.context [pfp.act properties %.y]]]
          ==
      ==
    ::  if user wants to make their @p => @ux connection public, add it to registry.
    ::  otherwise, just mint the nft
    ?.  =(~ ship.act)
      =:  
        shipux.noun.registry  (~(put by shipux.noun.registry) (need ship.act) id.caller.context) 
        uxship.noun.registry  (~(put by uxship.noun.registry) id.caller.context (need ship.act))
      ==
      ::  (result %&^registry^~ ~ ~ ~)
      :_  (result [%&^registry ~] ~ ~ ~)
      mintcalls
    ::
    :_  (result ~ ~ ~ ~)
    mintcalls
  ==
++  read
  |=  =pith
  ~
::
++  nft-contract  0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae 
::
::
::  +$  ship-sig  [p=@ux q=ship r=life], we are expecting a jammed noun,
::  as an atom, inside a @t. Could do the conversion here, off-chain
::  cheaper :)
--
