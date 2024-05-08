Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CytrixCode/CDC/main/CDC.ico' -OutFile 'CDC.ico'

$CSCode = (Invoke-webrequest -URI "https://raw.githubusercontent.com/CytrixCode/CDC/main/CDC.cs").Content

$CodeDomProvider = [System.CodeDom.Compiler.CodeDomProvider]::CreateProvider("C#")
$CompilerParametersObject = [System.CodeDom.Compiler.CompilerParameters]
$Parameters = New-Object $CompilerParametersObject
$Parameters.ReferencedAssemblies.AddRange(@('System.dll', 'System.Windows.Forms.dll', 'System.Drawing.dll'))
$Parameters.CompilerOptions = '/optimize /win32icon:'+$PWD+'\CDC.ico'
$Parameters.GenerateExecutable = $true;
$Parameters.OutputAssembly = "CDC.exe";

$Result = $CodeDomProvider.CompileAssemblyFromSource($Parameters, $CSCode); 

if ($Result.Errors.HasErrors) 
{
    foreach ($err in $Result.Errors) 
    {
        Write-Host $err 
    }
}
else 
{
    Start-Process -NoNewWindow -FilePath CDC.exe 
}
