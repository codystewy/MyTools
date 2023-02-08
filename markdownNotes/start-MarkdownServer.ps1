# Start the Markdown Server in the background via this article 
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/start-job?view=powershell-7.3
# To kill a job run the remove-job -id # -Force command
Start-Job -name MarkdownServer -ScriptBlock {markdownserver.exe} 

