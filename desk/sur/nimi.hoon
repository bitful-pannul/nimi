::  simple nickname & pfp registry
::  contract agnostic
::
::
/+  smart=zig-sys-smart
|%
::
+$  profile  [name=@t uri=@t address=@ux item=@ux sig=(unit sig)]
::  note: sigs not exposed in scries, empty @t:s is this ok? (each @p @t) seems overkill
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
    [%tell-ships ships=(list ship)]
  ==
::
+$  update  :: scries, and sub updates.
  $%
    [%ships ships=(list [ship (unit profile)])]
    [%ship =ship =profile]
    [%user address=@ux item=@ux ship=(unit @p) name=(unit @t) uri=(unit @t)]
    [%no-user ~]
  ==
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
++  minter-contract  0xfb29.54e5.055c.786c.728c.1018.a61c.f33f.e7bb.de88.e5a7.9546.6397.0fe5.d6af.8bd6
++  uqnames          0xc025.cbba.6236.b694.070c.73ee.4d4d.a544.fcdd.a6a0.66bb.4e0e.fca1.6400.f586.43db
::
+$  ship-sig      [p=@ux q=ship r=life]
-- 

