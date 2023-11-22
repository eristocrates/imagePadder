
# Get image from clipboard
$clipboardData = [Windows.Clipboard]::GetDataObject()
if ($clipboardData -and $clipboardData.GetDataPresent('System.Windows.Media.Imaging.BitmapSource')) {
# Get the clipboard image using ImageMagick
$magickArguments = "clipboard:"
$imageData = magick $magickArguments -format "%wx%h" info:

# Get the current image dimensions
$currentWidth, $currentHeight = $imageData -split 'x'

# Set the desired dimensions
$desiredWidth = 512
$desiredHeight = 512

# Use ImageMagick to add transparent padding
$magickArguments = "convert", "clipboard:", "-background", "none", "-gravity", "center", "-extent", "$desiredWidth x $desiredHeight", "output.png"
magick $magickArguments
    Write-Host "Image saved to $filePath"
}
else {
    Write-Host "Unable to get image from clipboard."
}
