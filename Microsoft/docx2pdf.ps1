$Files=Get-ChildItem -path '.' -recurse -include "*.doc*"

$counter = 0
$filesProcessed = 0
$Word = New-Object -ComObject Word.Application

Foreach ($File in $Files) {
    $Name="$(($File.FullName).substring(0, $File.FullName.lastIndexOf("."))).pdf"
    if ((Test-Path $Name) -And (Get-Item $Name).length -gt 3kb) {
        echo "skipping $($Name), already exists"
        continue
    }

    echo "$($filesProcessed): processing $($File.FullName)"
    $Doc = $Word.Documents.Open($File.FullName)
    $Doc.SaveAs($Name, 17)
    $Doc.Close()
    if ($counter -gt 100) {
        $counter = 0
        $Word.Quit()
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Word)
        $Word = New-Object -ComObject Word.Application
    }
    $counter = $counter + 1
    $filesProcessed = $filesProcessed + 1
}