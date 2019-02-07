param (
    [string] $aTag = 'latest',
    [string[]] $aCommand
)

Enter-Build { 
    Write-Host "If you are behind the proxy use http(s)_proxy environment variables"
    $script:ImageName = 'mm-docs'
    $script:ImageFullName = $(if (!$aTag) { $ImageName } else { "${ImageName}:$aTag" })
}

# Synopsis: Build docker image, take CLI proxy into account
task Build {


    $params = @(
        'build'
        '--build-arg',  "http_proxy=$Env:http_proxy"
        '--build-arg',  "https_proxy=$Env:https_proxy"
        '-t',           $ImageFullName
        '.'
    )
    docker $params
}, ListImages

# Synopsis: Run docker image, mount project folder as /docs and take CLI proxy into account
task Run {
    $params = @(
        'run', '--rm', '-it'
        '--name',   'docs'        
        '--env',    "http_proxy",
        '--env',    "https_proxy"
        '-v',       "${pwd}:/docs"
        $ImageFullName        
    )    
    docker $params $aCommand
}

# Synopsis: List docker images for this project
task ListImages {
    docker images $ImageName
}