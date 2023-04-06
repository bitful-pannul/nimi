/-  *nimi
/+  wallet=zig-wallet, smart=zig-sys-smart, sig=zig-sig, default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
::
+$  card  card:agent:gall
::
--
=|  state-0
=*  state  -
=<
%-  agent:dbug
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    hc    ~(. +> [bowl ~])
::
++  on-init  on-init:def
++  on-save  !>(state)
++  on-load
  |=  =old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old-vase))
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  =^  cards  state
  ?+    mark  !!
      %nimi-action
    (handle-poke:hc !<(action vase))
      %wallet-update
    (handle-wallet-update:hc !<(wallet-update:wallet vase))
  ==
  [cards this]
  ::
  --
++  on-watch  on-watch:def
::
++  on-agent  on-agent:def
::
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
|_  [=bowl:gall cards=(list card)]
::
++  handle-poke
  |=  act=action
  ^-  (quip card _state)
  ?-    -.act
      %whodis
    ::  us asking someone
    ?:  =(src.bowl our.bowl)  
      :-  ~[[%pass /whodis %agent [src.bowl %nimi] %poke %nimi-action !>([%whodis ship.act])]]
      state
    ::  someone asking us
    :-  ~[[%pass /disme %agent [src.bowl %nimi] %poke %nimi-action !>([%disme nft.me address.me])]]
    state
    :: 
      %disme
    :: scry chain, validate,
    :: add to social-graph + friends state.
    !!
      %mint
    ?>  =(our.bowl src.bowl)
    :: mint a name nft on the specified contract. todo helper func
    =/  sagg  (sign:sig our.bowl now.bowl address.act)
    =/  sigg  (crip "{<(jam sagg)>}")  :: do better conversion
    :_  state  :_  ~
    :*  %pass  /nimi-mint
        %agent  [our.bowl %uqbar]
        %poke  %wallet-poke
        !>
        :*  %transaction
            origin=`[%nimi /nimi-mint]
            from=address.act
            contract=minter-contract
            town=0x0
            :-  %noun
            :*  %mint
                address=nft.act
                name=name.act
                pfp=pfp.act
                ship-sig=sigg
    ==  ==  ==  
    ::
  ==
::
++  handle-wallet-update
  |=  update=wallet-update:wallet
  ^-  (quip card _state)
  ?+    -.update  `state
      %sequencer-receipt
    ?>  ?=(^ origin.update)
    ::
    ?+    q.u.origin.update  ~|("got receipt from weird origin" !!)
        [%mint ~]
      =/  modified=(list item:smart)  (turn ~(val by modified.output.update) tail)
      ::
      ?.   =(%0 errorcode.output.update)
        :_  state
        ~
      ::  
      ::  do a ~pening-mint, then when successful receipt, can put result into state.
      ::  might need the specific minted @ux item too.
      :_  state
      ~
    ==
  ==
--
