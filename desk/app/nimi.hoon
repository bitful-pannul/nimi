/-  *nimi, indexer=zig-indexer
/+  wallet=zig-wallet, smart=zig-sys-smart, sig=zig-sig, default-agent, dbug
|%
+$  state-0
  $:
    me=profile
    pending=(unit profile)
    =niccbook
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
++  on-peek   handle-scry:hc
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
      :_  state  :_  ~
      :*  %pass   /whodis
          %agent  [ship.act %nimi]
          %poke   %nimi-action
          !>([%whodis our.bowl])
      ==
    ::  someone asking us
    ?~  sig.me  `state
    ::
    :_  state  :_  ~
    :*  %pass   /disme
        %agent  [src.bowl %nimi]
        %poke   %nimi-action
        !>([%disme item.me address.me sig.me])
    ==
    ::
      %set-profile
    ?>  =(our.bowl src.bowl)
    :_  state(me [name.me uri.me address.act item.act ~])
    :~  :*  %pass   /pokeback 
            %agent  [our.bowl %nimi] 
            %poke   %nimi-action 
            !>([%sign-ship address.act])
    ==  ==
      %disme
    :: scry chain, validate,
    =/  up  
      .^  update:indexer  %gx
        (scot %p our.bowl)  %uqbar  (scot %da now.bowl)
        /indexer/newest/item/(scot %ux 0x0)/(scot %ux item.act)/noun
      ==
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
        =+  salt=(cat 3 'nimi' (scot %p src.bowl))
        :+   address.act
          (sham nimi-domain nimi-type [src.bowl salt]) :: signing [=ship salt=@]
        sig.act
    ::
    ::  note: try =.  instead
    :_  %=    state
          niccbook 
          (~(put by niccbook) src.bowl [name uri.nft address.act item.act `sig.act])
        ==
    :~  :*  %pass  /add-tag
            %agent  [our.bowl %social-graph]
            %poke   %social-graph-edit
            !>([%nimi [%add-tag /nickname [%ship src.bowl] [%address item.act]]])
        ==
        :*  %pass  /add-tag
            %agent  [our.bowl %social-graph]
            %poke   %social-graph-edit
            !>([%nimi [%add-tag /address [%ship src.bowl] [%address address.act]]])
    ==  ==
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
            origin=`[%nimi /sign-ship]       :: note needs PR merge 0.1.4
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
                nft.act
                name.act
                uri.act
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
      :_  state(me u.pending)  :_  ~
      :*  %pass  /pokeback
          %agent  [our.bowl %nimi]
          %poke   %nimi-action
          !>([%sign-ship address.u.pending])
      ==
    ==
      %signed-message
      ?>  ?=(^ origin.update)
      ?>  =([%nimi /sign-ship] u.origin.update)
      ::
      :: store whole typed-message somewhere? or just the `@ux`sham of it like %wallet
      ?~  sig.me
        :_  state(sig.me `sig.update, pending ~)
        ~
      :: if sig already exists, more logic needed
      `state
  ==
::
++  handle-scry
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  ~|("unexpected scry into {<dap.bowl>} on path {<path>}" !!)
    [%x %username @ ~]
    ~&  "full path: {<path>}"
    =/  username  (slav %tas i.t.t.path)
    =+  lookupitem=(hash-data:smart minter-contract uqnames 0x0 username)
    =/  up
    .^  update:indexer  %gx
        (scot %p our.bowl)  %uqbar  (scot %da now.bowl)
        /indexer/newest/item/(scot %ux 0x0)/(scot %ux lookupitem)/noun
      ==
    ?>  ?=(%newest-item -.up)
    =+  item=item.up
    ?>  ?=(%.y -.item)
    ::
    =/  data  ;;([@ux (unit @p)] noun.p.item)
    ::  empty @p?
    ``noun+!>(`noun`[%username data])
  ==  
--
