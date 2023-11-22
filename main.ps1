Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName PresentationFramework

# Get image from clipboard
$clipboardData = [Windows.Clipboard]::GetDataObject()
if ($clipboardData -and $clipboardData.GetDataPresent('System.Windows.Media.Imaging.BitmapSource')) {
    $image = $clipboardData.GetData('System.Windows.Media.Imaging.BitmapSource')

    # Specify the file path where you want to save the image
    $filePath = "I:\Software Development\imagePadder\image.png"
    # Save the image using PngBitmapEncoder
    $encoder = New-Object Windows.Media.Imaging.PngBitmapEncoder
    $encoder.Frames.Add([Windows.Media.Imaging.BitmapFrame]::Create($image))

    # Use MemoryStream to get the bytes
    $memoryStream = New-Object IO.MemoryStream
    $encoder.Save($memoryStream)
    
    # Write the bytes to a file
    [System.IO.File]::WriteAllBytes($filePath, $memoryStream.ToArray())

    Write-Host "Image saved to $filePath"
}
else {
    Write-Host "Unable to get image from clipboard."
}
