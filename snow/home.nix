{ pkgs, ... }:

{
  dconf.settings = {
    "/org/gnome/desktop/input-sources" = {
        xkboptions = "['grp:alt_shift_toggle']";
      } ;
  };
}
