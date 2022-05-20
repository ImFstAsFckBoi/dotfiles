Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None

oh-my-posh init pwsh | Invoke-Expression

Import-Module Terminal-Icons

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'


function SHA256 ([string]$file) {
	Get-FileHash -Path $file -Algorithm SHA256
}


function Compare-Hash ([string]$file1, [string]$file2) {
	$a = Get-FileHash -Path $file1 -Algorithm SHA256 | Write-Output
	$b = Get-FileHash -Path $file2 -Algorithm SHA256 | Write-Output
	return ($a.Hash -eq $b.Hash)
}


function Set-Prompt([string]$name) {
	
	if ($name -eq "random") {
		$file = Get-Random -InputObject (Get-ChildItem ~/scoop/apps/oh-my-posh/current/themes/)
		$name = $file.BaseName.replace(".omp", "")
		echo $name 
	}
	
	oh-my-posh init pwsh --config "${oh_my_posh_install}/themes/${name}.omp.json" | Invoke-Expression
}


function sudo() {
	$pwshargs = @("-noprofile", "-NoExit", "cd $(pwd);")
	
	foreach ( $idx in ($args.count -1)) {
		if ($args[$idx].IndexOf(" ") -ne -1) {
			$old = $args[$idx]
			$args[$idx] = "'${old}'"
		}
	}
	
	if ($args[0] -eq "!!") {
		$pwshargs += @((Get-History)[-1], "; echo 'Done! Press any key to exit!'; Read-Host; exit")
	} elseif ($args) {
		$pwshargs += @(($args -join " "), "; echo 'Done! Press any key to exit!'; Read-Host; exit")
	}

	Start-Process "powershell.exe" -Verb RunAs -ArgumentList $pwshargs
} 


function ssh-copy-id([string]$remotehost, [string]$file = "${env:USERPROFILE}\.ssh\id_rsa.pub") {
	type $file | ssh $remotehost "mkdir -p .ssh && cat >> .ssh/authorized_keys"
}


Set-Alias -Name "vim"        -Value "nvim"
Set-Alias -Name "m"          -Value "micro"
Set-Alias -Name "neofetch"   -Value "winfetch"
Set-Alias -Name "edit"       -Value "notepad++.exe"
Set-Alias -Name "npp"        -Value "notepad++.exe"
Set-Alias -Name "grep"       -Value "findstr.exe"
Set-Alias -Name "which"      -Value "where.exe"


$psconf             = "~/.config/pwsh"
$psprof             = "${psconf}/porfile.ps1"
$oh_my_posh_install	= "~/scoop/apps/oh-my-posh/current"


Set-Prompt("montys")
git whoami

