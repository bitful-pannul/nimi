/+  *zig-sys-smart
::
::  Proxy contract for minting name/pfp nft:s 
::
|_  =context
++  write
  |=  act=action
  ^-  (quip call diff)
  ?-    -.act
      %mint
    ::  transferrable? yes mayb
    =/  properties  %-  make-pmap
      ^-  (list [@tas @t])
      ~[[%name name.act] [%ship-sig ship-sig.act]]
    ::
    :_  (result ~ ~ ~ ~)
    :~  :+  nft-contract
          town.context
        :*  %mint
            address.act
            ~[[id.caller.context [pfp.act properties %.y]]]
        ==
    ==
  ==
++  read
  |=  =pith
  ~
::
++  nft-contract  0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae 
::
+$  action
  $%  [%mint =address name=@t pfp=@t ship-sig=@t]
  ==
::  +$  ship-sig  [p=@ux q=ship r=life], we are expecting a jammed noun,
::  as an atom, inside a @t. Could do the conversion here, off-chain
::  cheaper :)
--
