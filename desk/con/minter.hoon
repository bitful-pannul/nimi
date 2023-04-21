/+  *zig-sys-smart
/=  lib  /con/lib/minter
::
::  minter.hoon  [UQ| DAO]
::  
::  Proxy contract for minting name/pfp nft:s 
::  Issues %lookup items for reverse lookups
::    
::  To find the address of a username, get the item-id:
::  (hash-data resolver-contract nft-collection town username)
::
::  and then look in the noun of that item: [=address ship=(unit @p)]
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
    =/  =item
      :*  %&  id
          this.context
          nft.act
          town.context
          name.act
          %lookup  [id.caller.context ship.act]
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
