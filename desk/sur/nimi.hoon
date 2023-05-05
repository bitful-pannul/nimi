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
++  minter-contract  0x7118.7e23.a8dc.6390.4c0b.f173.f3eb.f8a0.9b69.3597.0c0e.f648.64fc.94c2.6d01.d17b
++  uqnames          0xcbb6.908b.5635.7092.a085.b200.cfd6.2101.1e14.658b.5ef9.10e1.f626.b0d3.2fca.9755
::
+$  ship-sig      [p=@ux q=ship r=life]
-- 

