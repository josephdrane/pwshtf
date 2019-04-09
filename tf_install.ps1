# $test = (Invoke-WebRequest -uri https://www.terraform.io/downloads.html).Links.Href

# $test


class PowerShellTerraform {

    [string]$Os = $this.GetOs()
    [string]$Terraform = $this.CheckTerraform()

    [string]GetOs() {
        if (Get-Variable -name IsMacOS) {
            [string]$result = "Darwin"
        }
        elseif (Get-Variable -name IsLinux) {
            [string]$result = "Linux_amd64"
        }
        elseif (Get-Variable -name IsWindows) {
            [string]$result = "Windows_amd64"
        }
        else {
            [string]$result = "NotDefined"
        }

        return $result
    }

    [string]CheckTerraform() {
        if ( -not ($this.TerraformVersion() -like 'VERSION')) {
            Write-Host "Terraform not found"
            Write-Host "OS Detected is : " + $this.Os
            Write-host "Downloading : " + $this.GetTerraformDownloadLink()
            $this.DownloadTerraform()
            Write-Host "Extracting Zip and testing again"
        }
    }

    [string]TerraformVersion() {
        # TODO : needs to be os agnostic based on file path.
        $test = Invoke-Command -ScriptBlock { ./terraform --version }
        if ($test) {
            return 'VERSION : ' + $test
        }
        else {
            return 'NOT FOUND'
        }
    }

    [string]GetTerraformDownloadLink() {
        try {
            $links = (Invoke-WebRequest -uri https://www.terraform.io/downloads.html).Links.Href
            foreach ($link in $links) {
                if ($link -like '*' + $this.Os + '*') {
                    return [string]$link
                }
            }
            return $link
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Write-Host $ErrorMessage
            return 'Error'
        }
        
    }

    [void]DownloadTerraform() {
        try {
            Invoke-WebRequest $this.GetTerraformDownloadLink() -OutFile ("Terraform-" + $this.GetOs() + ".zip")
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Write-Host $ErrorMessage
        }

    }

}



$pwshtf = [PowerShellTerraform]::new()

$pwshtf.GetOs()
$pwshtf.GetTerraformDownloadLink()
$pwshtf.DownloadTerraform()
$pwshtf.TerraformVersion()