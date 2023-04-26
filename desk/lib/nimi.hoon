::  lib wrapper to access usernames
::  
::
::  todo revise bowl necessities => move into wrapper agent/core  
|% 
  +$  profile        [name=@t uri=@t address=@ux item=@ux sig=(unit [@ @ @])]
  ::
  ++  wrap-ship
  |=  [=ship our=@p now=@da]
  ::  ^-  [@p (unit profile)]
  =/  up  .^  *  %gx
        (scot %p our)  %nimi  (scot %da now)
        /ship/(scot %p ship)/noun
      ==
  ::
  ?~  up  [ship ~]
  =/  prof  ;;((unit profile) up)
  ?~  prof  [ship ~]
  [ship prof]
  ::
  ++  wrap-ships
  |=  [ships=(list ship) our=@p now=@da]
  ::
  =/  up  .^  *  %gx
        (scot %p our)  %nimi  (scot %da now)
        /ships/(scot %ud (jam ships))/noun
      ==
  ::
  ?~  up  [~ ships]
  =/  users  ;;((list [ship (unit profile)]) up)
  ::
  =/  unknown
    %+  murn  users
    |=  [=ship us=(unit profile)]
    ?~  us  `ship
    ~
  [users unknown]
  ::
  ++  enjs-username
    |=  [=ship our=@p now=@da]
    =+  user=+:(wrap-ship ship our now)
    ?~  user  ~
    (scot %t name.u.user)
  ::
  ++  enjs-userpic
    |=  [=ship our=@p now=@da]
    =+  user=+:(wrap-ship ship our now)
    ?~  user  ~
    (scot %t uri.u.user)
  ::
  ::  then in %pongo or %pokur we could import /+  nimi
  ::  then when passing change wrap ships with =/  [users unknown]  (wrap-ships:lib ships our.bowl now.bowl)
  ::  and then also [%pass /find-ships [our.bowl %nimi] %poke %nimi-action !>([%find-ships unknown])]
  ::  mayb...
--