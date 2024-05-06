Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CytrixCode/CDC/main/CDC.ico' -OutFile 'CDC.ico'
$CSCode = (Invoke-webrequest -URI "https://raw.githubusercontent.com/CytrixCode/CDC/main/CDC.cs").Content

$CompilerParametersObject = [System.CodeDom.Compiler.CompilerParameters]
$Parameters = New-Object $CompilerParametersObject
$Parameters.ReferencedAssemblies.AddRange(@('System.dll', 'System.Windows.Forms.dll', 'System.Drawing.dll'))
$Parameters.CompilerOptions = '/optimize /win32icon:'+$PWD+'\CDC.ico'
$Parameters.GenerateExecutable = $true
$Parameters.OutputAssembly = 'CDC.exe';

Add-Type -AssemblyName Microsoft.CSharp
$CodeProviderObject = [Microsoft.CSharp.CSharpCodeProvider]
$CSharp = New-Object $CodeProviderObject
$Result = $CSharp.CompileAssemblyFromSource($Parameters, $CSCode); 

if ($Result.Errors.HasErrors) { Break }
Start-Process -NoNewWindow -FilePath $Parameters.OutputAssembly 
