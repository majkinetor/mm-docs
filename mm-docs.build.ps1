param (
    [string] $aTag = 'latest',
    [string] $aCommand,
    [switch] $NoProxy
)

Enter-Build { 
    Write-Host "If you are behind the proxy use http(s)_proxy environment variables"    
    $script:ImageName = 'mm-docs'
    $script:ImageFullName = $(if (!$aTag) { $ImageName } else { "${ImageName}:$aTag" })
    $script:ContainerName = 'docs'
}

# Synopsis: Build docker image, take CLI proxy into account
task DockerBuild {
    $params = @(
        'build'
        '--build-arg',  "http_proxy=$Env:http_proxy"
        '--build-arg',  "https_proxy=$Env:https_proxy"
        '-t',           $ImageFullName
        '.'
    )
    docker $params
}, DockerListImages

# Synopsis: Run docker image, mount project folder as /docs and take CLI proxy into account
task DockerRun { docker-run $aCommand -Interactive }

# Synopsis: List docker images for this project
task DockerListImages { docker images $ImageName --format '{{json .}}' | ConvertFrom-Json | Format-Table REPOSITORY,TAG,IMAGE,ID,CREATEDSINCE,SIZE }

# Synopsis: Serve mkdocs project
task Serve DockerStop, { docker-run mkdocs serve -Detach }

# Synopsis: Build mkdocs project into static site
task Build { docker-run mkdocs build }

# Synopsis: Stop docker image if it is running
task DockerStop {
    $docs = docker ps --format '{{json .}}' | convertfrom-json | ? Names -eq $ContainerName
    if ($docs) { 
        Write-Host "Stopping running container: $ContainerName"
        docker stop $ContainerName 
    } else { Write-Host "No container running: $ContainerName" }
}

function docker-run( [switch] $Interactive, [switch] $Detach) {
    $params = @(
        'run'
        '--rm'
        if ($Interactive) { '--interactive --tty' }
        if ($Detach)      { '--detach' }
        '--name', $ContainerName
        if (!$NoProxy) { '--env', "http_proxy",'--env', "https_proxy" }
        '-v', "${pwd}:/docs"
        '-p', "8000:8000"
        $ImageFullName        
    )

    $cmd = "`ndocker $params $args`n"
    Write-Host $cmd -ForegroundColor yellow
    Invoke-Expression $cmd
    if ($LASTEXITCODE) {throw 1}
}