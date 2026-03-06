$text = [IO.File]::ReadAllText("$(Get-Location)\dump.txt", [Text.Encoding]::UTF8)
$conversations = $text -split "=== CONVERSATION: "
foreach ($c in $conversations) {
    if ($c -match "html" -or $c -match "doctype" -or $c -match "landing") {
        $name = ($c -split "`n")[0].Trim() -replace '[\\/:*?"<>|]', '_'
        if ($name) { [IO.File]::WriteAllText("$(Get-Location)\$name.txt", $c, [Text.Encoding]::UTF8) }
    }
}
