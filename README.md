ProgressQuest v6.3
==================

BUILDING
--------

Requires Free Pascal and Lazarus Component Library.

TODO
--------
- [ ] Portability
  - [ ] Windows
  - [x] macOS Cocoa
  - [ ] Linux/FreeBSD
    - [ ] Gtk+ 2
    - [ ] Qt 4
    - [ ] Qt 5
- [ ] Cleanup code.
  - [ ] Cleanup Delphi-ish code.
  - [x] Fix forms layout.
  - [ ] Remove dead code.
- [ ] Fix bugs.
  - [ ] Fix auto-save when logging-out the system.
  - [x] Make Unroll button works again!
  - [ ] Make save file works again!(Although it is incompatible with the official ones)
    - [ ] Fix zlib compress and decompress
    - [ ] Fix serialization and deserialization
  - [ ] Make tray icon works again!
  - [ ] ~~Make online mode works again!~~(This will never happen...Are you seriously need online mode in this port???)

SCREENSHOTS
--------
![Front](snapshots/Front.png)
![New Guy](snapshots/NewGuy.png)
![Main](snapshots/Main.png)

OLD VCS NOTES
---------

Converted to Mercurial on 1/12/2010 & sent to
http://bitbucket.org/grumdrig/pq/ ; development will continue from
there. If at all. Source opened 5/20/11. The world ends tomorrow anyway.

This project represents an ex post facto rendering of pq6 in its
various versions in version control, so that changes will be trackable
thataway.

(I didn't add this README file in PQ 6.0, but after that you can use
this README to trace the checkin history using version control.)

Subversion revsion numbers vs. versions:

* r321 v6.3 as I found it after a couple years of inactivity
* r320 v6.2 probably as released, though I'm not totally sure
* r318 v6.2 but probably a slightly older version
* r317 v6.1
* r313 v6.0

SEE ALSO
--------

The in-browser edition: this project, ported to JavaScript/HTML
https://bitbucket.org/grumdrig/pq-web
