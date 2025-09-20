If located in the home folder, then can be applied via

```
sudo nixos-rebuild switch --flake ~/configuration-nixos#abc-valera-elitebook25
home-manager switch --flake ~/configuration-nixos#abc-valera
```

If this is the case, then the `/etc/nixos` can be removed entirely

`sudo rm -r /etc/nixos`
