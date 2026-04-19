{
  sshBin,
  sshKeyAbcValera,
  sshKeyHideez,
  sshKeyValeriyO3c,
}:

{
  "repos/abc-valera/.gitconfig".text = ''
    [user]
        name = abc-valera
        email = valeriy.tymofieiev@gmail.com
        signingKey = ${sshKeyAbcValera}

    [core]
        sshCommand = ${sshBin} -i ${sshKeyAbcValera}

    [github]
        user = abc-valera
  '';

  "repos/hideez/.gitconfig".text = ''
    [user]
        name = abc-valera
        email = valeriy.tymofieiev@gmail.com
        signingKey = ${sshKeyHideez}

    [core]
        sshCommand = ${sshBin} -i ${sshKeyHideez}

    [github]
        user = abc-valera
  '';

  "repos/valeriy-o3c/.gitconfig".text = ''
    [user]
        name = valeriy-o3c
        email = valeriy@o3c.no
        signingKey = ${sshKeyValeriyO3c}

    [core]
        sshCommand = ${sshBin} -i ${sshKeyValeriyO3c}

    [github]
        user = valeriy-o3c
  '';
}
