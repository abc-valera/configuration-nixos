If located in the home folder, then can be applied via

```
sudo nixos-rebuild switch --flake ~/configuration-nixos#abc-valera-elitebook25
```

If this is the case, then the `/etc/nixos` can be removed entirely

`sudo rm -r /etc/nixos`

To update the flake's inputs (separate inputs can be specified), don't forget to **rebuild after the update**:

`sudo nix flake update --flake ~/configuration-nixos`
