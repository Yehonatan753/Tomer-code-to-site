$path = ".\Claude data extracted\conversations.json"
Add-Type -AssemblyName System.Web.Extensions
$serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$serializer.MaxJsonLength = [int]::MaxValue
$json = Get-Content $path -Raw -Encoding UTF8
$data = $serializer.DeserializeObject($json)

$outPath = ".\dump.txt"

$content = New-Object System.Text.StringBuilder
foreach ($conv in $data) {
    [void]$content.AppendLine("=== CONVERSATION: $($conv.name) ===")
    foreach ($msg in $conv.chat_messages) {
        if ($msg.text) {
            [void]$content.AppendLine("--- MESSAGE START ---")
            [void]$content.AppendLine($msg.text)
            [void]$content.AppendLine("--- MESSAGE END ---")
        }
    }
}

[IO.File]::WriteAllText("$(Get-Location)\dump.txt", $content.ToString(), [Text.Encoding]::UTF8)
Write-Output "Dump completed."
