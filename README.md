## %nimi

> Simple usernames & pfp:s on uqbar. 

Contracts [`~bacdun` testnet]:
  - minter.hoon `0xd8bf.084a.6e9a.abc0.c0b1.7b54.a05f.7633.e8fa.ddaf.d1df.1cda.2cf8.5f7d.8861.ded7`
  - Uqnames `0x3ee1.a614.06c5.be2f.dfba.f017.39ff.4ecc.0b8f.5a94.b44c.83dc.c6cb.8fb5.3790.cede`

*If you want to build this locally on a fakeship chain, check dev-setup.md*

#### %minter

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
	
