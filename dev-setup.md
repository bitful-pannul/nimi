### local testing setup

install the %zig desk on a fakeship: [uqbar-dao/uqbar-core](https://github.com/uqbar-dao/uqbar-core)

with |new-desk, |mount and |commit, |install copy and install the files from /desk into %nimi

```
:rollup|activate
:indexer &indexer-action [%set-sequencer 0x0 [our %sequencer]]
:indexer &indexer-action [%set-rollup [our %rollup]]
:sequencer|init our 0x0 0xc9f8.722e.78ae.2e83.0dd9.e8b9.db20.f36a.1bc4.c704.4758.6825.c463.1ab6.daee.e608

:uqbar &wallet-poke [%import-seed 'uphold apology rubber cash parade wonder shuffle blast delay differ help priority bleak ugly fragile flip surge shield shed mistake matrix hold foam shove' 'squid' 'nickname']
```

---

>contracts setup

deploy minter contract & usernames collection
```
=contract-path /=nimi=/con/compiled/minter/jam
=contract-jam .^(@ %cx contract-path)
=contract [- +]:(cue contract-jam)

:uqbar &wallet-poke [%transaction ~ from=0x7a9a.97e0.ca10.8e1e.273f.0000.8dca.2b04.fc15.9f70 contract=0x1111.1111 town=0x0 action=[%noun [%deploy mutable=%.y cont=contract interface=~]]]
:sequencer|batch

:: minter contract address should be: 0x2fe5.7172.1781.4963.f986.5427.0163.2ace.35e3.c887.95ea.73a5.6d65.ea79.afd9.d63c, if not just use what you got.

=smart -build-file /=zig=/lib/zig/sys/smart/hoon

=props (make-pset:smart ~[%name])
=minters (make-pset:smart ~[0x2fe5.7172.1781.4963.f986.5427.0163.2ace.35e3.c887.95ea.73a5.6d65.ea79.afd9.d63c])

:uqbar &wallet-poke [%transaction ~ from=0x7a9a.97e0.ca10.8e1e.273f.0000.8dca.2b04.fc15.9f70 contract=0xc7ac.2b08.6748.221b.8628.3813.5875.3579.01d9.2bbe.e6e8.d385.f8c3.b801.84fc.00ae town=0x0 action=[%noun [%deploy 'UqNames' 'UQN' `@'uqnames' props ~ minters ~]]]

:: uqnames contract address should be 0xcbb6.908b.5635.7092.a085.b200.cfd6.2101.1e14.658b.5ef9.10e1.f626.b0d3.2fca.9755
```

now update the minter-contract and uqnames fields in sur/nimi.hoon if they're not the same as above

then you can 

`:nimi &nimi-action [%mint name='dogg' uri='https://cdn.britannica.com/16/234216-050-C66F8665/beagle-hound-dog.jpg' 0xcbb6.908b.5635.7092.a085.b200.cfd6.2101.1e14.658b.5ef9.10e1.f626.b0d3.2fca.9755 0x7a9a.97e0.ca10.8e1e.273f.0000.8dca.2b04.fc15.9f70 %.y]`

now you can check your wallet for the nft, and :nimi +dbug for your profile.

