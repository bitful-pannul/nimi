/+  *zig-sys-smart
/=  lib  /con/lib/minter
::
::  minter.hoon  [UQ | DAO]
::  
::  Proxy contract for minting name/pfp nft:s 
::  Issues %lookup items for reverse lookups
::    
::  To find the address of a username, get the item-id:
::  (hash-data resolver-contract nft-collection town username)
::
::  and then look in the noun of that item: [=address item=id ship=(unit @p)]
::
::
|_  =context
::
++  write
  |=  act=action:lib
  ^-  (quip call diff)
  ?-    -.act
      %mint
    =/  =id  (hash-data this.context nft.act town.context name.act)
    ::  precalculate the id of the to be minted nft
    =/  nft-data
      =+  (need (scry-state nft.act))
      (husk metadata:lib - `nft-contract:lib ~)  
    ::  
    =/  =metadata:lib  noun.nft-data
    ::  get the salt & the next-item-id from the nft metadata item
    ::
    =/  next-salt  (cat 3 salt.metadata (scot %ud +(supply.metadata)))
    =/  next-item  
      (hash-data nft-contract:lib id.caller.context town.context next-salt)
    ::
    =/  =item
      :*  %&  id
          this.context
          nft.act
          town.context
          name.act
          %lookup  [id.caller.context next-item ship.act]
      ==  
    =/  propmap  %-  make-pmap
      ~[[%name name.act]]
    ::
    =/  mintcalls=(list call)
      :~  :+  nft-contract:lib 
            town.context
          :*  %mint
              nft.act
              ~[[id.caller.context [uri.act propmap %.y]]]
      ==  ==
    :-  mintcalls
    (result ~ [item ~] ~ ~)
  ==
++  read
  |=  =pith
  ~    
--
