Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/CytrixCode/CDC/main/CDC.ico' -OutFile 'CDC.ico'

$CSCode = (Invoke-webrequest -URI "https://raw.githubusercontent.com/CytrixCode/CDC/main/CDC.cs").Content

$CodeDomProvider = [System.CodeDom.Compiler.CodeDomProvider]::CreateProvider("C#")
$CompilerParametersObject = [System.CodeDom.Compiler.CompilerParameters]
$Parameters = New-Object $CompilerParametersObject
$Parameters.ReferencedAssemblies.AddRange(@('System.dll', 'System.Windows.Forms.dll', 'System.Drawing.dll'))
$Parameters.CompilerOptions = '/optimize /win32icon:'+$PWD+'\CDC.ico'
$Parameters.GenerateInMemory = $false;
$Parameters.GenerateExecutable = $false;
$Parameters.OutputAssembly = "CDC.dll";

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
    $Result.LoadFrom("CDC.dll").GetType('Source.Code').GetMethod('Main').Invoke($Null, $Null);
}
