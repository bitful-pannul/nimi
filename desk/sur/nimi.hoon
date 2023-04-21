::  simple nickname & pfp registry
::  contract agnostic
::
::
::
/+  smart=zig-sys-smart
|%
::
+$  state-0
  $:
    me=profile
    friends=(list profile)
    pending=(unit profile)
  ==
::
+$  profile  [name=@t uri=@t address=@ux item=@ux sig=(unit sig)]
::
+$  action
  $%
    [%whodis =ship]
    [%set-profile item=@ux address=@ux]
    [%sign-ship address=@ux]
    [%disme item=@ux address=@ux =sig]              :: leave actual data to scrying chain?
    [%notyet ~]
    [%mint name=@t uri=@t nft=@ux address=@ux ship=?]      :: more props?
  ==
::
+$  sig  [v=@ r=@ s=@]
::
+$  nft         :: from con/lib
    $:  id=@ud
        uri=@t
        metadata=id:smart
        allowances=(pset:smart address:smart)
        properties=(pmap:smart @tas @t)
        transferrable=?
    ==
::
++  nimi-domain   minter-contract                                             :: check these, move to /lib
++  nimi-type    (pairs:enjs:format ~[[%ship [%s '@p']] [%salt [%s '@ud']]])  :: everyone just needs to sign/check the same thing
::
++  nft-contract     0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae
++  minter-contract  0x8dae.9d0b.50a3.e817.588c.dda1.d5e0.3345.f273.178e.3c46.e02b.d6f7.a938.f4fa.79a0
::
+$  ship-sig      [p=@ux q=ship r=life]
-- 

