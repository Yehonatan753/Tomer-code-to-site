$text = [IO.File]::ReadAllText("$(Get-Location)\dump.txt", [Text.Encoding]::UTF8)
$conversations = $text -split "=== CONVERSATION: "
foreach ($c in $conversations) {
    if ($c.Trim() -ne "") {
        $lines = $c -split "`n", 2
        $name = $lines[0].Trim()
        $content = $lines[1]
        if ($content -match "נחיתה" -or $content -match "אסטרטגיה" -or $content -match "html" -or $content -match "landing") {
            Write-Output "Found in: $name"
            $outPath = "$(Get-Location)\$( $name -replace '[\\/:*?"<>|]', '_' ).txt"
            [IO.File]::WriteAllText($outPath, $c, [Text.Encoding]::UTF8)
            Write-Output "Saved to $outPath"
        }
    }
}
