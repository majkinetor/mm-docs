<# .SYNOPSIS 
    Invoke-Build build script
#>
param (
    # Tag to use when building a new docker image, by default 'latest'
    [string] $aTag = 'latest',

    # Command to execute when running docker image
    [string] $aCommand,

    # Do not pass proxy environment variables to the docker container
    [switch] $aNoProxy,

    # Registry and path to use to get mm-docs image, by default majkinetor from Docker Hub
    [string] $aRegistry = (property MM_DOCS_REGISTRY_PATH 'majkinetor')
)

Enter-Build { 
    Write-Host "If you are behind the proxy use http(s)_proxy environment variables"
    $script:ImageName     = "$aRegistry/mm-docs"
    $script:ImageFullName = if (!$aTag) { $ImageName } else { "${ImageName}:$aTag" }
    $script:ContainerName = 'docs'    
}

# Synopsis: Build docker image
task DockerBuild {
    $params = @(
        'build'
        '--pull'
        '--build-arg',  "http_proxy=$Env:http_proxy"
        '--build-arg',  "https_proxy=$Env:https_proxy"
        '-t',           $ImageFullName
        '.'
    )
    docker $params
}, DockerListImages

# Synopsis: List docker images for docs project
task DockerListImages { docker images $ImageName --format '{{json .}}' | ConvertFrom-Json | Format-Table REPOSITORY,TAG,IMAGE,ID,CREATEDSINCE,SIZE }

# Synopsis: Stop docker docs container if it is running
task DockerStop {
    $docs = docker ps --format '{{json .}}' | convertfrom-json | ? Names -eq $ContainerName
    if ($docs) { 
        Write-Host "Stopping running container: $ContainerName"
        docker stop $ContainerName 
    } else { Write-Host "No container running: $ContainerName" }
}

# Synopsis: Run docker image interactivelly with given command
task Run { docker-run $aCommand -Interactive }

# Synopsis: Serve docs project on http://localhost:8000
task Serve DockerStop, {
    $url = "http://localhost:8000"
    docker-run mkdocs serve -Detach -Expose 

    Write-Host "Waiting for server to start ..."
    1..5 | % { 
        try { $status = iwr $url -Method Head -UseBasicParsing | % StatusCode } catch {}
        if (($_ -eq 5) -and ($status -ne 200)) { throw "Serving failed - invalid status $status" }
        sleep 1
    }
    
    Write-Host "Serving from docs, container, mapped to host on $url"
}

# Synopsis: Build mkdocs project into static site
task Build DockerStop, { docker-run mkdocs build }

function docker-run( [switch] $Interactive, [switch] $Detach, [switch] $Expose) {
    $params = @(
        'run'
        '--rm'
        '-v', "${pwd}:/docs"
        '--name', $ContainerName

        if ($Interactive) { '--interactive --tty' }
        if ($Detach)      { '--detach' }
        if ($Expose)      { '-p', "8000:8000" }
        if (!$aNoProxy -and $Env:HTTP_PROXY) { '--env', "http_proxy",'--env', "https_proxy" }

        $ImageFullName        
    )

    $cmd = "`ndocker $params $args`n"
    Write-Host $cmd -ForegroundColor yellow
    Invoke-Expression $cmd
    if ($LASTEXITCODE) { throw "Last exit code was $LastExitCode" }
}