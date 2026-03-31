# PowerShell WebView2 Application
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$htmlPath = Join-Path $scriptDir "index.html"

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "工作日志系统"
$form.Size = New-Object System.Drawing.Size(1280, 850)
$form.StartPosition = "CenterScreen"
$form.MinimumSize = New-Object System.Drawing.Size(1000, 700)

# Create WebView2
Add-Type -Path "$env:LOCALAPPDATA\Microsoft\EdgeWebView\Manager\*\Microsoft.Web.WebView2.Core.dll" -ErrorAction SilentlyContinue
Add-Type -Path "$env:ProgramFiles(x86)\Microsoft\EdgeWebView\Manager\*\Microsoft.Web.WebView2.Core.dll" -ErrorAction SilentlyContinue

try {
    $webView = New-Object Microsoft.Web.WebView2.WinForms.WebView2
    $webView.Size = New-Object System.Drawing.Size(1260, 810)
    $webView.Location = New-Object System.Drawing.Point(0, 0)
    
    $form.Controls.Add($webView)
    
    $env:WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS = "--disable-infobars"
    $webView.Source = [System.Uri]::new("file:///$htmlPath")
    
    # Menu bar
    $menu = New-Object System.Windows.Forms.MenuStrip
    $fileMenu = New-Object System.Windows.Forms.ToolStripMenuItem("文件")
    $exitItem = New-Object System.Windows.Forms.ToolStripMenuItem("退出")
    $exitItem.Add_Click({ $form.Close() })
    $fileMenu.DropDownItems.Add($exitItem)
    $menu.Items.Add($fileMenu)
    $form.MainMenuStrip = $menu
    $form.Controls.Add($menu)
    
    $webView.Size = New-Object System.Drawing.Size(1260, 780)
    $webView.Location = New-Object System.Drawing.Point(0, 24)
} catch {
    # Fallback if WebView2 fails
    $form.Text = "工作日志系统 (浏览器模式)"
    $browser = New-Object System.Windows.Forms.WebBrowser
    $browser.Size = New-Object System.Drawing.Size(1260, 810)
    $browser.Location = New-Object System.Drawing.Point(0, 0)
    $browser.Url = New-Object System.Uri("file:///$htmlPath")
    $form.Controls.Add($browser)
}

[void]$form.ShowDialog()
