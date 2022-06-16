<#
.EXAMPLE
PS> invoke-psake build

Creates the symplr:latest image.

.EXAMPLE
PS> invoke-psake terminal

Starts a PowerShell (v5) session in the container.

.EXAMPLE
PS> invoke-psake run

Starts the application.

.LINK
https://hub.docker.com/_/microsoft-windows-servercore-iis

.NOTES

To use the build-automation file (Psakefile.ps1), the Psake module needs to be installed, then imported.

PS> install-module psake -scope currentuser
PS> import-module psake
#>

Properties {
    $APP_NAME = 'symplr-help'
}

Task Build {
    Write-Host 'Building image...'
    docker build --tag ghcr.io/$($env:GITHUB_ACCOUNT)/$($APP_NAME) --tag "$APP_NAME`:latest" .
}

Task Terminal {
    docker run -it --rm "$APP_NAME`:latest" powershell
}

Task Run {
    Write-Host 'Running container...'
    docker run -dit --rm -p 8080:80 "$APP_NAME`:latest"

    Start-Process "http://localhost:8080/default.html"
}

Task Publish {
	Write-Host 'Publishing image to Github...'
	echo $($env:GITHUB_TOKEN) | docker login ghcr.io -u $env:GITHUB_ACCOUNT --password-stdin
	docker push ghcr.io/$($env:GITHUB_ACCOUNT)/$($APP_NAME):latest
}
