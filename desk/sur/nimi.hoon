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
++  zigs-contract    0x74.6361.7274.6e6f.632d.7367.697a
++  dec-18           1.000.000.000.000.000.000
::
++  minter-contract  0xee68.ced7.a4a8.a8f3.2b3f.95f9.1d6f.5247.38a4.d11b.21b6.3099.22a6.b0ef.736e.9e52
++  uqnames          0x2797.07b1.bf2a.af92.baa8.338a.72f5.9561.9b9d.0b49.f0f5.3602.f1f3.6fe2.d35e.421a
::0xebb1.2b42.12e5.d036.b7c1.a5a6.3cf5.1deb.0577.ddbd.1de7.4ee8.e9e4.9a16.394a.fbcb
::
+$  ship-sig      [p=@ux q=ship r=life]
-- 

