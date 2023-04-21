#### nicknames master plan

>This is a project with lots of variables, so it is better to define and set some of those variables as we start. Later we can change things. 

One of these is allowing for arbitrary username collections. Essentially passing around nft-metadata-id:s, and factoring in their potential different nouns. 

For now, we'll use UqNames: 
	metadata here: 0x0 /code
	minter.hoon: 0x0 /code

We want this username standard to be used not only by pongo, but by %pokur, and whatever other apps. This means %huudnimi (name tbd), should act as a library, that holds useful state & makes it available for the integrating agent.

This is something of a wrapper agent.

Imagine joining a %pokur table. A friend, ~hidler-hadfun invited you. 4 other players are present, one of which you know from before, ~nut, nickname nutbutter, pfp not appropriate. 3 are new, they show up as ~set, ~rus and ~nec. 

Now, upon joining, when the %pokur agent passes the set of ships in the table to the frontend, it will wrap the ships in the (add-nickname:wrapper {~set ~rus ~nec}). %nimi will first query it's local known nicnkname store (map @p [item=@ux name=@t pfp=@t]) and return appropriate (unit user) for each @p. This way, the frontend can choose whether to display @p, or @t and picture, but they're always together and optional. 

If it doesn't find a user in it's local state mapping, it pokes the new ship with %whodis. If the ship has a nickname minted and signed, it will poke back.

For the user this would mean upon joining a new pokur table (or pongo chat) with 6 new players and 3 old, the old ones would immediately render as nicknames, and the new ones would gradually shift from @p to nicknames within ~2-5seconds. Pretty cool? 

Some final notes:
- this will become smoother with remote scry.
- a local state might become outdated related to chain-state



