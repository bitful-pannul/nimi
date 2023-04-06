## %nimi

> Simple usernames & pfp:s on uqbar. 

Eventually integrate into pongo, but let's try a naive approach first.

2 main branches currently:
- [mode/ship-sigs](https://github.com/bitful-pannul/nimi/tree/mode/ship-sig)
- [mode/uq-sigs](https://github.com/bitful-pannul/nimi/tree/mode/uq-sig)     <- probably the way forward

Mint a username&picture. 
`:nimi &nimi-action [%mint name=@t pfp=@t nft=@ux address=@ux]`

this handles name, checks src.bowl, signs our-address with ship, then posts a tx to %minter contract

then upon successful sequencer receipt we can store this in profile in our state.


ask someone for his username/pfp
(maybe upon opening profile/first contact on %pongo)
```=hoon
:nimi &nimi-action [%whodis =ship]	
get a poke-back 
[%disme item=@ux address=@ux]
::
=/  i  %-  scry-state  item
?>  =(holder.i address)		:: get address like pongo
=/  data  ;;(nft:sur:nft noun.i)
=/  name  (~(got by properties.data) %name)
=/  sigg  (~(got by properties.data) %ship-sig)  ::  in @t format, there's an atom inside, ..?
::
=/  shipsig  ;;([@ux @p @ud] (cue `atom-format`sigg))
:: 
=/  valid   (validate:sig our.bowl shipsig hash=address now)
?:  =(%.y valid)
	 state(valid valid)
state(couldn't verify)
  ```
	
> verified, store in state&social-graph, display as username, optional back to @p. (settings & default).

%minter/hoon deployed `0xa3fe.e174.a884.4777.41f6.860a.0e8d.ec56.6198.07a8.661a.2cf5.5c65.5ad9.40d4.5916`

nft contract `0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae`

initial nameservice collection `0xf9c0.f5a5.7904.b0e3.42e3.2e55.c4b4.f98f.82cc.fce5.9f34.aa49.917e.4877.3a57.6ddc`

>>> todo: check if `ship-sigs` have nasty edge cases.
	e.g no life / rift, alien not in %jael peers.
