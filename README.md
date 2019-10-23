# FileNamePropertyAppender

I wrote this script based on my company's request to rename files by appending the "date modified" or "content created" property to the new file name

*Without the Get-FileMetaData function from the **Author 'ed wilson, msft'**, this script will never happen*
<br>
[Download the function from here](https://gallery.technet.microsoft.com/scriptcenter/get-file-meta-data-function-f9e8d804)

## How to
- Download the Get-FileMetaDataReturnObject.ps1 from [here](https://gallery.technet.microsoft.com/scriptcenter/get-file-meta-data-function-f9e8d804), and save it to a fully accessibale folder e.g. c:\users\yourname\desktop.
- Download (or git clone) the **cloneappender.ps1** script from the repo and place it on the same folder c:\users\yourname\desktop.
- Open Windows PowerShell ISE as Administrator and in the PowerShell prompt enter **set-executionpolicy unrestricted** to allow the execution of the script in unresitricted mode.
- Now in Windows PowerShell ISE open the downloaded file **Get-FileMetaDataReturnObject.ps1** and run it. This should load the function **Get-FileMetaData** inside the PowerShell in order to use it by the cloneappender.ps1 script later
- Again, in Windows PowerShell ISE open the cloned script cloneappender.ps1 and change the parameters based on your requirements:

      # Change to directory that contains your files 
      $sourcedir = "D:\files" 

      # Define a file property to be appended to file name
      $fileproperty = "content created" # other possible properties are 

      # Extension to look for when using get-filemetadata function and use during the renaming process
      $extension = "docx"

      # Get-FileMetaData function is used here to go through the files inside a directory one by one and get/save their property values
      $a = Get-FileMetaData $sourcedir | select $fileproperty | findstr /r "^[0-9]"

- Before you run the script, make sure the files you would like to rename and append to properties to them are located in an accessible directory (should be the same as the one you used in the $sourcedir parameter), preferrably not the same as the scripts folder.

- Now you should be good to go. Just run the script **cloneappender.ps1** and bob's your uncle, you are done.

## Important
- There are many file properties to pick from and use in this script. It can be checked by accessing the properties of a file then go through the details to see and use them.
- This script is preconfigured to look and append the "Content created" property to file names. You can pick any legit file property you like and substitue the "Content created" with it.
- Each file property has a differnet value style and in order to save the value and use it, you first need to parse it. In this repo, I decided to use "Content created" property and filtered it using **findstr /r "^[0-9]"** which uses regex to look for the date/time line since it starts with numbers then store it in the $a variable.
