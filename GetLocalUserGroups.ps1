function Get-ValidUser($var) {
    $users = Get-WmiObject win32_useraccount | Select-Object name, caption, localaccount | Where-Object localaccount -like true
    foreach ($user in $users) {
        if ($var -eq $user.name) {
            return $user;
        }
    }
    return "invalid";
} 

$szukany = read-host "Podaj nazwe uzytkownika"; 

if (0 -eq $szukany) {
    $szukany = $env:USERNAME;
}

$groups = Get-LocalGroup;

"`nUzytkownik: {0}`r`n" -f $szukany
"Lista grup uzytkownika {0}:`r`n" -f $szukany

for ($i = 0; $i -lt $groups.Count; $i++) {
    $group = Get-LocalGroupMember -Name $groups[$i];
    $user = Get-ValidUser($szukany);
    if ($group.name -eq $user.caption -and $user -ne "invalid" ) {
        $groups[$i].name;
    }
}
