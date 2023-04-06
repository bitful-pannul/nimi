# %nimi

Simple usernames & pfp:s on uqbar. 

Eventually integrate into pongo, but let's try a naive approach first.

Mint a username/picture. [picture from URI will be a bit of a pain]
call :nimi &nimi-action [%mint name=@t pfp=@t]
	handles name, checks src.bowl, then posts a tx to %minter contract, that will store ship-sig
	done, store (map @p [@ux @t @t])  :: the 2 @t:s are kinda optional, can fetch from chain-state
	store in our %social-graph

ask someone for his username/pfp [eventually w/ remote scry]
opening the profile/first contact on pongo will emit poke:
   ```=hoon
   :nimi &nimi-action [%whodis =ship]
	 we get a pokeback of &nimi-action [%disme item=@ux address=@ux name=@t pfp=@t]
	 boom. we could take this for a source of truth, but some verification would be nice too.
	 =>
	 =/  i  %-  scry-state  item
	 ?>  =(holder.i address)		:: get address too like pongo
	 =/  data  ;;(nft:sur:nft noun.i)
	 =/  name  (~(got by properties.data) %name)
	 =/  sigg  (~(got by properties.data) %ship-sig)  ::  in @t format, there's an atom inside, how to get it?
	 ::
	 =/  shipsig  ;;([@ux @p @ud] (cue `atom-format`sigg))
	 :: 
	 =/  valid   (validate:sig our.bowl shipsig hash=address now)
	 ?:  =(%.y valid)
	 	 state(valid valid)
	 state(couldn't verify)
  ```
	verified, store in state&social-graph, display as username, optional back to @p. (settings & default).


> todo: check if `ship-sig`:s have nasty edge cases.
	e.g no life / rift, alien not in %jael peers.
