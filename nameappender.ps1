# Change to directory that contains your files
$sourcedir = "D:\files" 

# Define a file property to be appended to file name
$fileproperty = "content created" # other possible properties are 

# Extension to look for when using get-filemetadata function and use during the renaming process
$extension = "docx" 

# Starting value to use when recurse among the results of the Get-FileMetaData 
$stepper = 0 

# Recurse files in the directory to do the renaming 
Get-ChildItem $source -Recurse -Include *.$extension | % {
    # Get-FileMetaData function is used here to go through the files inside a directory one by one and get/save their property values
    $a = Get-FileMetaData $sourcedir | select $fileproperty | findstr /r "^[0-9]"
    $a = $a -replace '\?',''
    $a = $a -replace '/','-'
    
    # Whe select to use the "content created" property, this will get the date only
    $untilspace = $a[$stepper].IndexOf(" ")
    $newname = $a.Substring(0, $untilspace)
    $name = $_.Name.Split(".")[0] + "_" + $newname[$stepper] + "." + $extension
   
    try {
        Rename-Item $_ -NewName $name -ErrorAction Stop
        $stepper = $stepper + 1
        Write-Host "File successfully renamed to:" -ForegroundColor Green 
        echo $name ' '
        }
    Catch {
        Write-Host "Something wrong: " $_.Exception.Message -ForegroundColor Red 
        Write-Host ""
          }
}
