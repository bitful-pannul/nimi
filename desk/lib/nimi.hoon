::  lib wrapper to access usernames
::  
::
::  todo revise bowl necessities => move into wrapper agent/core  
/-  *nimi
|% 
  ::  +$  profile        [name=@t uri=@t address=@ux item=@ux sig=(unit [@ @ @])]
  ::
  ::  todo remove if not used in apps/libs
  ::  ++  wrap-ship
  ::  |=  [=ship our=@p now=@da]
  ::  ^-  (unit profile)
  ::  ::  return ship too? [@p (unit profile)]
  ::  =/  up  .^  *  %gx
  ::        (scot %p our)  %nimi  (scot %da now)
  ::        /ship/(scot %p ship)/noun
  ::      ==
  ::  ::
  ::  ?~  up  ~
  ::  ;;((unit profile) up)
  ::  ::
  ::  ++  wrap-ships
  ::  |=  [ships=(list ship) our=@p now=@da]
  ::  ::
  ::  =/  up  .^  *  %gx
  ::        (scot %p our)  %nimi  (scot %da now)
  ::        /ships/(scot %ud (jam ships))/noun
  ::      ==
  ::  ::
  ::  ?~  up  [~ ships]
  ::  =/  users  ;;((list [ship (unit profile)]) up)
  ::  ::
  ::  =/  unknown
  ::    %+  murn  users
  ::    |=  [=ship us=(unit profile)]
  ::    ?~  us  `ship
  ::    ~
  ::  [users unknown]
  ::
  ::  ++  enjs-username
  ::    |=  [=ship our=@p now=@da]
  ::    =+  user=(wrap-ship ship our now)
  ::    ?~  user  ~
  ::    (scot %t name.u.user)
  ::  ::
  ::  ++  enjs-userpic
  ::    |=  [=ship our=@p now=@da]
  ::    =+  user=(wrap-ship ship our now)
  ::    ?~  user  ~
  ::    (scot %t uri.u.user)
  ::
  ++  enjs-update
    =,  enjs:format
    |=  up=update
    ^-  json
    %+  frond  -.up
    ?-    -.up
        %ships
        ::  TODO handle empty name & uri well
      %-  pairs
      %+  turn  ships.up
      |=  [s=@p p=(unit profile)]
      :-  `@tas`(scot %p s)
      %-  pairs
      :~  ::  ['ship' s+(scot %p ship)]
          ['name' ?~(p [%s ''] s+(scot %tas name.u.p))]
          ['uri' ?~(p [%s ''] s+(scot %tas uri.u.p))]
          ['item' ?~(p [%s ''] s+(scot %ux item.u.p))]
          ::  could add address and sig too.
      ==
    ::
        %ship
      %-  pairs
      :~  [%ship s+(scot %p ship.up)]
          [%name s+(scot %tas name.up)]
          [%uri s+(scot %tas uri.up)]
          [%item s+(scot %ux item.up)]
          ::  add others?
      ==
    ::
        %new-user
      %-  pairs
      :~  [%ship s+(scot %p ship.up)]
          [%name s+(scot %tas name.up)]
          [%uri s+(scot %tas uri.up)]
          [%item s+(scot %ux item.up)]
          ::  add others?
      ==
    ::
        %user
      %-  pairs
      :~  [%address s+(scot %ux address.up)]
          [%ship ?~(ship.up [%s ''] s+(scot %p u.ship.up))]
      ==
    ::
        %no-user    :: fix ~
      (pairs ~[['s' %s '']])
    ==
  ++  dejs-action
    =,  dejs:format
    |=  jon=json
    ^-  action
    =<  (decode jon)
    |%
    ++  decode
      %-  of
      :~  
        [%whodis (se %p)]                     :: maybe tell ships? poke everyone like hey I'm @ass 
        [%disme dejs-disme]    :: shouldn't poke this from frontend, make easier interface poke. 
        [%mint dejs-mint]
        [%set-profile dejs-setprofile]
        [%sign-ship (se %ux)]
        [%find-ships (ar (se %p))]
        [%tell-ships (ar (se %p))]
      ==
    ++  dejs-mint
      %-  ot
      :~  [%name so]
          [%uri so]
          [%nft (se %ux)]
          [%address (se %ux)]
          [%ship bo]
      ==
    ++  dejs-setprofile
      %-  ot 
      :~  [%item (se %ux)]
          [%address (se %ux)]
      ==

    ++  dejs-disme
      %-  ot
      :~  [%item (se %ux)]
          [%address (se %ux)]
          [%sig dejs-sig]
      ==
    ++  dejs-sig
      ^-  $-(json [v=@ r=@ s=@])
      %-  ot
      :~  [%v (se %ud)]
          [%r (se %ud)]
          [%s (se %ud)]
    ==
  --
--