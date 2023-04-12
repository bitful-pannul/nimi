/+  *zig-sys-smart
:: 
::  Registry for storing addresses, their optionally associated @p, and pfp/name nft id.
::  
::
|_  =context
::
+$  action
  $%  [%store =entry]
      [%deploy-registry ~]
  ==
+$  entry     [ship=(unit ship) =id]
+$  registry  (map address entry)
::
++  write
  |=  act=action
  ^-  (quip call diff)
  ?-    -.act
      %deploy-registry
    ::  contract/data separation makes it possible for several registries.
    ::  the salt setting here allows for 1 per contract
    ::  ?>  =(id.caller.context 0x1111.1111),  optionally %deploy-and-init flow.
    =/  =id  (hash-data this.context this.context town.context (cat 3 this.context 'nft-registry'))
    =/  =item
      :*  %&  id
          this.context
          this.context
          town.context
          (cat 3 this.context 'nft-registry') 
          %registry  *registry
      ==
    `(result ~ item^~ ~ ~)
    ::
      %store
    =+  id=(hash-data this.context this.context town.context (cat 3 this.context 'nft-registry'))
    ::
    =+  (need (scry-state id))
    =/  regi  (husk registry - `this.context ~)
    ::
    =.  noun.regi                                     :: todo fix registry.noun.regi
    (~(put by noun.regi) id.caller.context entry.act) 
    ::
    :_  (result [%&^regi ~] ~ ~ ~)
    ~
  ==
++  read
  ::  todo add reads 
  |=  =pith
  ~
--
