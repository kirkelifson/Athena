# Athena

*Athena* is a plugin for source mod which monitors the live gamestate of a counter-strike source server, and updates an online scoreboard accordingly.

The PHP and Sourcemod files will need to be edited to reflect the paths you wish to set for the match log file for both reading (php) and writing (sourcemod).

athena.sp, line 28
```c
  new String:filename[10] = "match.log";
```

cstrike.php, line 14
```php
  $file = "/opt/HLDS/css/css/cstrike/match.log";
```

Replace both variables with the name and location you wish to use. Sourcemod chroot's to your cstrike folder, so you'll have to change the path relative to said folder.

Athena was created by Sam Edley and Kirk Elifson.

Sam: sedly@unallocatedmemory.net

Kirk: kirk@parodybit.net

# todo
- Convert output to json
- incorporate ajax for content updating
- use nosql to keep the data stored for offline usage
- use steam web api to grab profile data for players in server
