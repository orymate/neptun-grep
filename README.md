Install
=======

1. Copy grep.* to ~/.irssi/scripts/ or ~/.irssi/scripts/autorun/
2. Set paths in grep.pl
3. Load module to irssi.

        /SCRIPT LOAD grep

Remove
======

1. Unload module from irssi.

        /SCRIPT UNLOAD grep
2. Remove script file.

        find ~/.irssi/scripts -name grep.\* -print0 | xargs -0 rm

Usage
=====

This irssi will answer all privmsgs (both private and public) starting with
".nep ".
