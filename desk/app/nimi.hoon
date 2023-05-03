/-  *nimi, indexer=zig-indexer, wallet=zig-wallet
/+  smart=zig-sys-smart, sig=zig-sig, default-agent, dbug
|%
+$  state-0
  $:
    me=profile  :: unit too?
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
++  on-watch  ::  frontend
  |=  =path
  ^-  (quip card _this)
  ?>  =(src our):bowl
  ?+    path  ~|("watch to erroneous path" !!)
  ::  path for frontend to connect to and receive
  ::  all actively-flowing information. does not provide any initial state.
    [%updates ~]  `this
  ==
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
    :: todo: origin for whodis? so other apps can poke
    :: done in this branch: approve origin poke so mint goes through immediately, can be exploited?
    :: other apps poke /nimi, 
      %whodis
    ::  us asking someone
    ?:  =(src.bowl our.bowl) 
      :_  state  :_  ~
      :*  %pass   /whodis
          %agent  [ship.act %nimi]
          %poke   %nimi-action
          !>(`action`[%whodis ship.act])
      ==
    ::  someone asking us
    ?~  sig.me  `state                    :: might want a "not yet poke"
    ::                                    :: could store map ship unit profile instead
    ::                                    :: maybe reduce amount of extra %whodis pokes from frontends
    ::
    :_  state  :_  ~
    :*  %pass   /disme
        %agent  [src.bowl %nimi]
        %poke   %nimi-action
        !>(`action`[%disme item.me address.me u.sig.me])
    ==
    ::
      %set-profile
    ?>  =(our.bowl src.bowl)
    =/  i  (name-from-item item.act address.act)  :: destructure
    ::
    =/  name  (fall name.i '')
    ::
    :_  state(pending `[name uri.i address.act item.act ~])
    :_  ~
    :*  %pass   /pokeback 
        %agent  [our.bowl %nimi] 
        %poke   %nimi-action 
        !>(`action`[%sign-ship address.act])
    ==
      %disme
    :: check if present in addressbook
    ::
    =/  user=(unit profile)  (~(get by niccbook) src.bowl)
    ::
    ?:  ?&  ?=(^ user)
            =(address.u.user address.act)
            =(item.u.user item.act)
        ==
      `state
    ::
    =/  [cards=(list card) =profile]  (validate-scry +.act)
    [cards state(niccbook (~(put by niccbook) src.bowl profile))]
    ::
    ::
      %sign-ship
    ?>  =(src.bowl our.bowl)
    :_  state  :_  ~
    :*  %pass   /sign-ship
        %agent  [our.bowl %uqbar]
        %poke   %wallet-poke
        !>  ^-  wallet-poke:wallet
        :*  %sign-typed-message
            origin=`[%nimi /sign-ship] 
            from=address.act
            domain=nimi-domain
            type=nimi-type
            message=(cat 3 'nimi' our.bowl)
    ==  ==
    ::
      %mint
    ?>  =(our.bowl src.bowl)
    ::  mint a username/pfp
    ::  note: nft.act gets correctly set upon receipt
    :_  state(pending `[name.act uri.act address.act nft.act ~])  
    :~  :*  %pass   /approve-nimi-origin
            %agent  [our.bowl %wallet]
            %poke   %wallet-poke
            !>([%approve-origin [%nimi /mint-name] [rate=1 bud=1.000.000]])
        ==
        :*  %pass   /nimi-mint
            %agent  [our.bowl %uqbar]
            %poke   %wallet-poke
            !>  ^-  wallet-poke:wallet
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
    ==  ==  ==  ==
    ::    
      %find-ships
    ?>  =(our.bowl src.bowl)
    =/  pokes 
    %+  turn  ships.act
      |=  =ship
      :*  %pass   /disme
          %agent  [ship %nimi]
          %poke   %nimi-action
          !>([%whodis ship])
      ==
    ::
    :_  state
    pokes
    ::
      %tell-ships
    ?>  =(our.bowl src.bowl)
    ?~  sig.me  !!
    =/  pokes 
    %+  turn  ships.act
      |=  =ship
      :*  %pass   /disme
          %agent  [ship %nimi]
          %poke   %nimi-action
          !>([%disme item.me address.me u.sig.me])
      ==
    :_  state
    pokes
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
      =/  modified=(list item:smart)  
        (turn ~(val by modified.output.update) tail)
      ::  
      =|  id=(unit id:smart)
      =.  id
        |-  ^+  id
        ?~  modified  ~
        =/  =item:smart  i.modified
        ?.  ?&  ?=(%& -.item)
                =(holder.p.item address.u.pending)
                =(label.p.item %nft)
                =(source.p.item nft-contract)
            ==
            $(modified t.modified)
        `id.p.item
      ::
      ?~  id  `state
      ::
      =/  new  u.pending
      =.  item.new  u.id
      :_  state(me new, pending ~)  :_  ~
      :*  %pass  /pokeback
          %agent  [our.bowl %nimi]
          %poke   %nimi-action
          !>([%sign-ship address.new])
      ==
    ==
      %signed-message
      ?>  ?=(^ origin.update)
      ?>  =([%nimi /sign-ship] u.origin.update)
      ::
      :: store whole typed-message somewhere? 
      :: or just the `@ux`sham of it like %wallet
      ?~  pending
        ::  %mint case 
        :_  state(sig.me `sig.update)
        :_  ~
        :*  %give  %fact
            ~[/updates]
            %nimi-update
            !>  ^-  ^update
            [%ship our.bowl me]
        ==
      ::  %set-profile-case
      =/  new  u.pending
      =.  sig.new  `sig.update
      :_  state(me new, pending ~)
      :_  ~
      :*  %give  %fact
          ~[/updates]
          %nimi-update
          !>  ^-  ^update
          [%ship our.bowl me]
      ==
  ==
::
++  name-from-item
  |=  [item=@ux address=@ux]
  ^-  [name=(unit @t) uri=@t]
  =/  up  
    .^  update:indexer  %gx
      (scot %p our.bowl)  %uqbar  (scot %da now.bowl)
      /indexer/newest/item/(scot %ux 0x0)/(scot %ux item)/noun
    ==
  ?>  ?=(%newest-item -.up)
  =+  item=item.up
  ::
  ?>  ?=(%.y -.item)                
  ?>  =(holder.p.item address)
  ?>  =(source.p.item nft-contract)
  =/  nft  ;;(nft noun.p.item)
  =/  name  (~(get by properties.nft) %name)
  ::
  [name uri.nft]
  ::
++  validate-scry
  |=  [item-id=@ux address=@ux signature=[@ @ @]]
  ^-  [cards=(list card) =profile]
  ::
  =/  up  
      .^  update:indexer  %gx
        (scot %p our.bowl)  %uqbar  (scot %da now.bowl)
        /indexer/newest/item/(scot %ux 0x0)/(scot %ux item-id)/noun
      ==
  ?>  ?=(%newest-item -.up)
  =+  item=item.up
  ::
  ?>  ?=(%.y -.item)                
  ?>  =(holder.p.item address)
  ?>  =(source.p.item nft-contract)
  ::
  =/  nft  ;;(nft noun.p.item)
  ::
  =/  name  (fall (~(get by properties.nft) %name) '')
  ::  
  ?>  %-  uqbar-validate:sig
      =+  salt=(cat 3 'nimi' src.bowl)
      :+   address
        (sham nimi-domain (sham nimi-type) salt) 
      signature
  ::
  =/  who  [name uri.nft address item-id `signature]
  ::
  =/  effects
    :~  :*  %pass  /add-tag
            %agent  [our.bowl %social-graph]
            %poke   %social-graph-edit
            !>  
            [%nimi [%add-tag /nickname [%ship src.bowl] [%address item-id]]]
        ==
        :*  %pass  /add-tag
            %agent  [our.bowl %social-graph]
            %poke   %social-graph-edit
            !>
            [%nimi [%add-tag /address [%ship src.bowl] [%address address]]]
        ==
        :*  %give  %fact
            ~[/updates]
            %nimi-update
            !>  ^-  update
            [%ship src.bowl name uri.nft item-id address ~]
    ==  ==
  [effects who]
::
++  handle-scry
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  ~|("unexpected scry into {<dap.bowl>} on path {<path>}" !!)
      [%x %user @ ~]
    ::  if you know @t username, and are trying to get associated address & @p  
    =/  username  (slav %tas i.t.t.path)
    =+  lookupitem=(hash-data:smart minter-contract uqnames 0x0 username)
    =/  up
    .^  update:indexer  %gx
        (scot %p our.bowl)  %uqbar  (scot %da now.bowl)
        /indexer/newest/item/(scot %ux 0x0)/(scot %ux lookupitem)/noun
      ==
    ?~  up  ``nimi-update+!>(`update`[%no-user ~])
    ?>  ?=(%newest-item -.up)
    =+  item=item.up
    ?>  ?=(%.y -.item)
    ::
    =/  data  ;;([@ux (unit @p)] noun.p.item)
    ::  
    ::  return @p in update too?
    ``nimi-update+!>(`update`[%user data])
  :: 
      [%x %ship @ ~]
    =/  ship  (slav %p i.t.t.path)
    =/  user  (~(get by niccbook) ship)
    ?~  user  ``nimi-update+!>(`update`[%no-user ~])
    ``nimi-update+!>(`update`[%ship ship name.u.user uri.u.user item.u.user address.u.user ~]) :: check empties
  ::
      [%x %ships @ ~]
    =+  ships=;;((list @p) (cue (slav %ud i.t.t.path))) 
    =/  users 
      %+  turn  ships
      |=  =ship
      [ship (~(get by niccbook) ship)]
    ``nimi-update+!>(`update`[%ships users])
  ::
      [%x %niccbook ~]
    ::  might be quicker here than enjs, we need to wrap profile in unit.
    =/  users  
      %+  turn  ~(tap by niccbook)
      |=  [=ship =profile]  [ship `profile]
    ``nimi-update+!>(`update`[%ships users])
  ::
      [%x %profile ~]
    ?~  sig.me  ``nimi-update+!>(`update`[%no-user ~])  :: check empties
    ``nimi-update+!>(`update`[%ship our.bowl name.me uri.me item.me address.me ~])
  ==
--
