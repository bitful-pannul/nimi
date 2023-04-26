::  simple nickname & pfp registry
::  contract agnostic
::
::
::
/+  smart=zig-sys-smart
|%
::
+$  profile  [name=@t uri=@t address=@ux item=@ux sig=(unit sig)]
::
+$  niccbook  (map ship profile)
::
+$  action
  $%
    [%whodis =ship]
    [%disme item=@ux address=@ux =sig]
    [%mint name=@t uri=@t nft=@ux address=@ux ship=?]
    [%set-profile item=@ux address=@ux]
    [%sign-ship address=@ux]
    [%find-ships ships=(list ship)]
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
++  nimi-domain   minter-contract                
++  nimi-type    (pairs:enjs:format ~[[%ship [%s '@p']] [%salt [%s '@ud']]])  :: everyone just needs to sign/check the same thing
::
++  nft-contract     0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae
++  minter-contract  0x414f.f84c.e3ff.c5e8.74d4.d226.7bcc.e9c4.9759.72e0.dca2.fb5e.5323.0dbb.dd62.93cd
++  uqnames          0xa7.67a4.7079.04ca.de7f.69b7.adb9.d14d.6321.7c8a.39c8.f9d7.4dc8.54a7.7209.2526
::
+$  ship-sig      [p=@ux q=ship r=life]
-- 

