<# .SYNOPSIS
    Invoke-Build build script
#>
param (
    # Tag to use when building a new docker image, by default 'latest'
    [string] $aTag = 'latest',

    # Use latest versions of all included components
    [switch] $aLatestModules
)

Enter-Build {
    Write-Host "If you are behind the proxy use http(s)_proxy environment variables"
    $script:ImageName     = "majkinetor/mm-docs"
    $script:ImageFullName = if (!$aTag) { $ImageName } else { "${ImageName}:$aTag" }
}

function Get-PlantUmlVersion {
    function Get-GitHubReleaseUrl( $GitHubRepositoryUrl, $Pattern='\.exe$') {
        $latestReleases = "$GitHubRepositoryUrl/releases/latest"
        $latestPage = Invoke-WebRequest -Uri $latestReleases -UseBasicParsing
        $latestPage.Content -match '(?<=src=")[^"]+expanded_assets[^"]+' | Out-Null
        $assetsUrl = $Matches[0]
        if (!$assetsUrl) { throw "Can't find assets URL" }

        $domain  = $GitHubRepositoryUrl -split '(?<=//.+)/' | Select-Object -First 1
        $assetsPage = Invoke-WebRequest -Uri $assetsUrl -UseBasicParsing
        $assetsPage.links | ? href -match $Pattern | Select-Object -expand href | % { $domain + $_ }
    }

    $GitHubRepositoryUrl = 'https://github.com/plantuml/plantuml'
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl 'plantuml-[0-9.]+\.jar$' | select -Last 1
    $version = $url -split '-|.jar' | select -First 1 -Skip 1
    $version
}

# Synopsis: Build docker image
task Build {
    if ($aLatestModules) {
        if (!(Test-Path requirements.txt.bak)) { Copy-Item requirements.txt requirements.txt.bak }
        Write-Host "Removing versions from requirements.txt file" -ForegroundColor yellow
        ((Get-Content requirements.txt).Trim() -replace '=.+') + " "*(Get-Random 10) | Set-Content -Encoding Ascii requirements.txt

        $plantuml_version = Get-PlantUmlVersion
        Write-Host "Setting latest PlantUML version:" $plantuml_version -ForegroundColor yellow
        (Get-Content Dockerfile) -replace  '(PLANTUML_VERSION)=(.+)', "`$1=$plantuml_version" | Set-Content .\Dockerfile
    }

    $params = @(
        'build'
        if ($Env:http_proxy)   { '--build-arg', "http_proxy=$Env:http_proxy" }
        if ($Env:https_proxy)  { '--build-arg', "https_proxy=$Env:https_proxy" }
        '-t', $ImageFullName
        '.'
    )

    Write-Host "Cmd:  " docker $params -ForegroundColor green
    exec { docker $params }
}

# Synopsis: Update docker image with latest dependencies
task Update { $script:aLatestModules = $true }, Build, GetVersions

# Synopsis: Run interactive session
task RunShell { docker run -it --rm $ImageFullName sh }

# Synopsis: Publish docker
task Publish {
    if ($aTag -eq 'latest') { throw "aTag is required" }

    exec {
        docker tag majkinetor/mm-docs:latest majkinetor/mm-docs:$aTag
        docker login
        docker push majkinetor/mm-docs:$aTag
    }
}

# Synopsis: Generate latest python requirement versions
task GetVersions {
    Write-Host "Setting container versions in requirements.txt file" -ForegroundColor yellow

    $cVersions = exec {
        docker run -it --rm $ImageFullName pip list -l --format=json --disable-pip-version-check
    }
    $cVersions = $cVersions | ConvertFrom-Json
    (Get-Content requirements.txt) | % {
        $version = $cVersions | ? name -eq $_ | % version
        if ($version) { "$_==$version" } else { $_ }
    } | Set-Content -Encoding Ascii requirements.txt

    Get-Content requirements.txt
}

# Synopsis: Remove docker images
task Clean {
    docker rmi $script:ImageName
}