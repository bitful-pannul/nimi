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
+$  profile  [name=@t pfp=@t address=@ux item=@ux sig=(unit sig)]
::
+$  action
  $%
    [%whodis =ship]
    [%set-profile item=@ux address=@ux]
    [%sign-ship address=@ux]
    [%disme item=@ux address=@ux =sig]              :: leave actual data to scrying chain?
    [%mint name=@t pfp=@t nft=@ux address=@ux]      :: more props?
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
++  minter-contract  0xa3fe.e174.a884.4777.41f6.860a.0e8d.ec56.6198.07a8.661a.2cf5.5c65.5ad9.40d4.5916
::
+$  ship-sig      [p=@ux q=ship r=life]
-- 

