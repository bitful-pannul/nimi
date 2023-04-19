/+  *zig-sys-smart
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
+$  action
  $%  [%mint nft=id uri=@t name=@t ship=(unit @p)]
  ==
::
++  write
  |=  act=action
  ^-  (quip call diff)
  ?-    -.act
      %mint
    ::
    =/  =id  (hash-data this.context nft.act town.context name.act)
    =/  =item
      :*  %&  id
          this.context
          nft.act
          town.context
          name.act
          %lookup  [id.caller.context ship.act]
      ==  
    ::  
    =/  propmap  %-  make-pmap
      ^-  (list [@tas @t])
      ~[[%name name.act]]
    ::
    =/  mintcalls=(list call)
      :~  :+  nft-contract
            town.context
          :*  %mint
              nft.act
              ^-  (list [address [@t (pmap @tas @t) ?]])
              ~[[id.caller.context [uri.act propmap %.y]]]
          ==
      ==
    ::
    :_  (result ~ [item ~] ~ ~)
    mintcalls
  ==
++  read
  |=  =pith
  ~
::
++  nft-contract        0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae 
::  
--
