::  simple nickname & pfp registry
::  contract agnostic
::
::  this app uses the `` contract, and the `` minter contract
::  perhaps add this all into lib/nimi under ++  sur 
|%
::
+$  state-0
  $:
    me=profile
    friends=(list profile)
  ==
::
+$  profile  [name=@t pfp=@t address=@ux nft=@ux]
::
+$  action
  $%
    [%whodis =ship]
    [%mint name=@t pfp=@t nft=@ux address=@ux]
    [%disme item=@ux address=@ux]     :: leave actual data to scrying chain?
  ==
::
+$  ship-sig      [p=@ux q=ship r=life]
++  nft-contract  0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae
-- 

