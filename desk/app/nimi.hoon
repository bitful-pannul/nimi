/-  *nimi, indexer=zig-indexer
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
      :-  ~[[%pass /whodis %agent [ship.act %nimi] %poke %nimi-action !>([%whodis ship.act])]]
      state
    ::  someone asking us
    ?~  sig.me
      :-  ~[[%pass /disme %agent [src.bowl %nimi] %poke %nimi-action !>([%notyet ~])]]
      state
    ::
    :-  ~[[%pass /disme %agent [src.bowl %nimi] %poke %nimi-action !>([%disme item.me address.me u.sig.me])]]
    state
    ::
      %notyet
    :: perculate up to frontend that @p doesn't have username yet... ahhh wen remote scry
    !! 
      %set-profile
    ?>  =(our.bowl src.bowl)
    :_  state(me [name.me uri.me address.act item.act ~])
    :~  [%pass /pokeback %agent [our.bowl %nimi] %poke %nimi-action !>([%sign-ship address.act])]
    == 
      %disme
    :: scry chain, validate,
    =/  up  .^(update:indexer %gx /(scot %p our.bowl)/uqbar/(scot %da now.bowl)/indexer/newest/item/(scot %ux 0x0)/(scot %ux item.act)/noun)
    ::
    ?>  ?=(%newest-item -.up)
    =+  item=item.up
    ~&  "item: {<item>}"
    ::
    ?>  ?=(%.y -.item)                
    ?>  =(holder.p.item address.act)
    ?>  =(source.p.item nft-contract)
    ::
    =/  nft  ;;(nft noun.p.item)
    ~&  "nounnft: {<nft>}"
    =/  name  (~(got by properties.nft) %name)
    ::  
    ?>  %-  uqbar-validate:sig
        :+   address.act
          (sham nimi-domain nimi-type [src.bowl (cat 3 'nimi' (scot %p src.bowl))]) :: signing [=ship salt=@]
        sig.act
    ::
    :_  state(friends (snoc friends [name uri.nft address.act item.act `sig.act]))
    :~  [%pass /add-tag %agent [our.bowl %social-graph] %poke %social-graph-edit !>([%nimi [%add-tag /nickname src.bowl item.act]])]
        [%pass /add-tag %agent [our.bowl %social-graph] %poke %social-graph-edit !>([%nimi [%add-tag /address src.bowl address.act]])]
    ==
    ::  
    ::
      %sign-ship
    ?>  =(src.bowl our.bowl)
    :_  state  :_  ~
    :*  %pass   /sign-ship
        %agent  [our.bowl %uqbar]
        %poke   %wallet-poke
        !>
        :*  %sign-typed-message
            origin=`[%nimi /signed-message]       :: note needs PR merge for it to work.
            from=address.act
            domain=nimi-domain
            type=nimi-type
            message=[our.bowl (cat 3 'nimi' (scot %p our.bowl))]
    ==  ==
    ::
      %mint
    ?>  =(our.bowl src.bowl)
    ::  mint a username/pfp
    :_  state(pending `[name.act uri.act address.act nft.act ~])  
    :_  ~
    :*  %pass   /nimi-mint
        %agent  [our.bowl %uqbar]
        %poke   %wallet-poke
        !>
        :*  %transaction
            origin=`[%nimi /mint-name]
            from=address.act
            contract=minter-contract
            town=0x0
            :-  %noun
            :*  %mint
                nft=nft.act
                uri=uri.act
                name=name.act
                ship=?:(ship.act `our.bowl ~)
    ==  ==  ==
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
        [%mint-name ~]
      ?.  =(%0 errorcode.output.update)
        `state(pending ~)
      ::
      ?~  pending  `state
      ::
      :_  state(me u.pending)
      :~  [%pass /pokeback %agent [our.bowl %nimi] %poke %nimi-action !>([%sign-ship address.u.pending])]
      ==
    ==
      %signed-message
      ::
      :: store whole typed-message somewhere? or just the `@ux`sham of it like %wallet
      ?~  sig.me
        :_  state(sig.me `sig.update)
        ~
      :: if sig already exists, more logic needed
      `state
  ==
--
