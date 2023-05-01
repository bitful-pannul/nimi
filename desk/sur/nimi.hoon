::  simple nickname & pfp registry
::  contract agnostic
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
    [%tell-ships ships=(list ship)]
    ::  how about poke => effects + give-fact?
  ==
::
+$  update  :: scries, and sub updates.
  $%
    [%ships ships=(list [ship (unit profile)])]
    [%ship =ship name=@t uri=@t item=@ux]
    [%new-user =ship name=@t uri=@t item=@ux]
    [%user address=@ux ship=(unit @p)]
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
++  minter-contract  0x2fe5.7172.1781.4963.f986.5427.0163.2ace.35e3.c887.95ea.73a5.6d65.ea79.afd9.d63c
++  uqnames          0xcbb6.908b.5635.7092.a085.b200.cfd6.2101.1e14.658b.5ef9.10e1.f626.b0d3.2fca.9755
::
+$  ship-sig      [p=@ux q=ship r=life]
-- 

