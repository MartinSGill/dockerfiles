param(
	[Parameter(Position=0)]
	$Tasks
)

# Direct call: ensure packages and call the local Invoke-Build
if ([System.IO.Path]::GetFileName($MyInvocation.ScriptName) -ne 'Invoke-Build.ps1') {
	$ErrorActionPreference = 'Stop'
	$ib = "$PSScriptRoot/packages/Invoke-Build/tools/Invoke-Build.ps1"

	# install packages
	if (!(Test-Path -LiteralPath $ib)) {
		'Installing packages...'
		& $PSScriptRoot/.paket/paket.exe install
		if ($LASTEXITCODE) {throw "paket exit code: $LASTEXITCODE"}
	}

	# call Invoke-Build
	& $ib -Task $Tasks -File $MyInvocation.MyCommand.Path @PSBoundParameters
	return
}

$images = @('build-dotnet');

Task Build {
    ForEach ($image in $images) {
        $dockerfiles = Get-ChildItem -Recurse -Path (Join-Path $PSScriptRoot $image) -Filter "Dockerfile"
        foreach ($file in $dockerfiles) {
            $pathElements = $file.Fullname -split "\\"
            $repo = "martinsgill"
            $name = $pathElements[-3]
            $version = $pathElements[-2]
            $tag = "{0}/{1}:{2}" -f $repo, $name, $version

            exec { docker build -t $tag ($file.Fullname | Split-Path -Parent) }
            exec { docker push $tag }
        }
    }
}