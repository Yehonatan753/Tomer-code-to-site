$path = "C:\Users\Yehonatan\Desktop\Projects_Restored\תומר פרידמן\Claude data extracted\conversations.json"
Add-Type -AssemblyName System.Web.Extensions
$serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$serializer.MaxJsonLength = [int]::MaxValue
$json = Get-Content $path -Raw -Encoding UTF8
$data = $serializer.DeserializeObject($json)

$outPath = "C:\Users\Yehonatan\Desktop\Projects_Restored\תומר פרידמן\extracted_texts.txt"
$content = ""

foreach ($conv in $data) {
    $isMatch = $false
    if ($conv.name -match "תומר" -or $conv.name -match "Tomer" -or $conv.name -match "נחיתה" -or $conv.name -match "אסטרטגיה") {
        $isMatch = $true
    }
    
    # Also check if any message contains the keywords
    if (-not $isMatch) {
        foreach ($msg in $conv.chat_messages) {
            if ($msg.text -and ($msg.text -match "תומר" -or $msg.text -match "נחיתה" -or $msg.text -match "אסטרטגיה")) {
                $isMatch = $true
                break
            }
        }
    }

    if ($isMatch) {
        $content += "=== CONVERSATION: $($conv.name) ===`n"
        foreach ($msg in $conv.chat_messages) {
            if ($msg.text) {
                $content += "--- MESSAGE from $($msg.sender) ---`n$($msg.text)`n"
            }
        }
    }
}

$content | Out-File $outPath -Encoding UTF8
Write-Output "Done"
