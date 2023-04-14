/+  *zig-sys-smart
::
::  Proxy contract for minting name/pfp nft:s 
::  Combined with a pure nft registry contract.
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
    ::  
    =+  `item`(need (scry-state nft.act))
    =/  meta  (husk metadata - `this.context ~)
    =/  salt    (cat 3 salt.meta (scot %ud +(supply.noun.meta)))
    =/  item-id  (hash-data nft.act id.caller.context town.context salt)
    ::  
    =/  mintcalls
      :~  :+  nft-contract
            town.context
          :*  %mint
              nft.act
              ~[[id.caller.context [uri.act properties.act %.y]]]
          ==
          ::
          :+  registry-contract
            town.context
          :-  %store
          [ship.act item-id]      :: how do we fetch the nft that's about to be minted from the above call?
                                  :: one option is husk the nft.act metadata state, find the salt, current supply,
                                  :: and generate the new item-id based on that salt. 
                                  :: might be unreliable though. what if someone mints inbetween and we send the wrong info to registry?
                                  :: %on-mint would be an interesting function to implement as well. 
      ==
    ::
    :_  (result ~ ~ ~ ~)
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
