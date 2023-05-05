## %nimi

> Simple usernames & pfp:s on uqbar. 

Contracts enable this: 

#### %resolver
	items, holder & source always the nft-name collection.
	id=(hash-data nft-source nft-source town `@`'the-name.uqq')
	noun: [=address ship=unit(@p) subdomains=(list @t)]

if we mint these resolver items during mint of names, it enables reverse lookup.

#### %minter
	all this does is take in at least a 'name' property, and a 'pfp'/'uri' one too.
	then it posts a mint to the defined nft-item, and mints a resolver for it too.

hmm. source & holder, will they match up if we mint from external contract? 

Mint a username&picture. 
`:nimi &nimi-action [%mint name=@t pfp=@t nft=@ux address=@ux]`

this handles name, checks src.bowl, sends a poke to sign a typed-message to wallet, then posts a tx to %minter contract

then upon successful sequencer receipt&wallet-update we can store this in profile in our state.


ask someone for his username/pfp
(maybe upon opening profile/first contact on %pongo)
```=hoon
:nimi &nimi-action [%whodis =ship]	
get a poke-back 
[%disme item=@ux address=@ux sig=@ux]
::
  =/  up  .^(update:indexer %gx /(scot %p our.bowl)/uqbar/(scot %da now.bowl)/indexer/newest/item/(scot %ux 0x0)/(scot %ux item.act)/noun)
  ::
  ?>  ?=(%newest-item -.up)
  =+  item=item.up
  ::
  ?>  ?=(%.y -.item)
  ?>  =(holder.p.item address.act)
  ?>  =(source.p.item nft-contract)
  ::
  =/  nft  ;;(nft noun.p.item)
  =/  name  (~(got by properties.nft) %name)
  =/  pfp   (~(got by properties.nft) %pfp)
  ::  the rest of properties
  ::
  ?>  %-  uqbar-validate:sig
      :+   address.act
        (sham nimi-domain nimi-type [src.bowl (cat 3 'nimi' (scot %p src.bowl))]) :: signing [=ship salt=@]
      sig.act
::
```
	
> verified, store in state&social-graph, display as username, optional back to @p. (settings & default).

%minter/hoon deployed `0x7118.7e23.a8dc.6390.4c0b.f173.f3eb.f8a0.9b69.3597.0c0e.f648.64fc.94c2.6d01.d17b`

nft contract `0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae`

initial nameservice collection `0xcbb6.908b.5635.7092.a085.b200.cfd6.2101.1e14.658b.5ef9.10e1.f626.b0d3.2fca.9755`

