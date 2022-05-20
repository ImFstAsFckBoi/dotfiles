Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted


if ( -Not (Get-Command scoop)) {
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
	Invoke-WebRequest get.scoop.sh | Invoke-Expression
	
}

scoop install oh-my-posh
scoop install fzf

Install-Module PSReadline -Force -Confirm:$false
Install-Module Terminal-Icons -Force -Confirm:$false
Install-Module PSFzf -Force -Confirm:$false

Unblock-File ~/.config/pwsh/profile.ps1

echo ". ~/.config/pwsh/profile.ps1" >> $profile
. $profile