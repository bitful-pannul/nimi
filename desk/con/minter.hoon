/+  *zig-sys-smart
::
::  Proxy contract for minting name/pfp nft:s 
::  Issues %resolver items for reverse lookups
::  
::
|_  =context
::
+$  action
  $%  [%mint nft=id uri=@t properties=(pmap @tas @t) ship=(unit @p)]
      :: uri==pfp or uri!=pfp?
  ==
::
++  write
  |=  act=action
  ^-  (quip call diff)
  ?-    -.act
      %mint
    ::
    =/  name  (~(got by properties.act) %name)
    =/  =id  (hash-data 0x0 nft.act town.context (cat 3 nft.act name))
    =/  =item
      :*  %&  id
          0x0
          nft.act
          town.context
          (cat 3 nft.act name) 
          %resolver  [id.caller.context ship.act]
      ==  
    ::  
    =/  mintcalls
      :~  :+  nft-contract
            town.context
          :*  %mint
              nft.act
              ~[[id.caller.context [uri.act properties.act %.y]]]
          ==
      ==
    ::
    :_  (result ~ item^~ ~ ~)
    mintcalls
  ==
++  read
  |=  =pith
  ~
::
++  nft-contract        0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae 
::
++  registry-contract   0x1b1c.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae
::
+$  metadata
  $:  name=@t
      symbol=@t
      properties=(pset @tas)
      supply=@ud
      cap=(unit @ud)  
      mintable=?      
      minters=(pset address)
      deployer=id
      salt=@
  ==
::
--
