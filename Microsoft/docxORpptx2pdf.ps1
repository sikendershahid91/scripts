$docxFiles = Get-ChildItem -Path . -Filter *.docx
$pptxFiles = Get-ChildItem -Path . -Filter *.pptx

# Create a new instance of Word application
$wordApp = New-Object -ComObject Word.Application

# Create a new instance of PowerPoint application
$pptApp = New-Object -ComObject PowerPoint.Application

# Convert DOCX files to PDF
foreach ($docxFile in $docxFiles) {
    # Open the document in Word
    $document = $wordApp.Documents.Open($docxFile.FullName)

    # Check if the document is in review mode
    if ($document.Revisions.Count -gt 0) {
        # Disable review mode
        $document.TrackRevisions = $false
        $document.AcceptAllRevisions()
    }

    # Generate the PDF file path
    $pdfFilePath = [System.IO.Path]::ChangeExtension($docxFile.FullName, "pdf")

    # Save the document as PDF
    $document.SaveAs([ref]$pdfFilePath, [ref]17)  # 17 represents PDF format

    # Close the document
    $document.Close()
}

# Convert PPTX files to PDF
foreach ($pptxFile in $pptxFiles) {
    # Open the presentation in PowerPoint
    $presentation = $pptApp.Presentations.Open($pptxFile.FullName)

    # Generate the PDF file path
    $pdfFilePath = [System.IO.Path]::ChangeExtension($pptxFile.FullName, "pdf")

    # Save the presentation as PDF
    $presentation.SaveAs([ref]$pdfFilePath, [ref]32)  # 32 represents PDF format

    # Close the presentation
    $presentation.Close()
}

# Quit Word application
$wordApp.Quit()

# Quit PowerPoint application
$pptApp.Quit()

# Release the COM objects
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($document) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($wordApp) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($presentation) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($pptApp) | Out-Null

# Display a success message
Write-Host "Conversion complete. All DOCX and PPTX files in the current directory have been converted to PDF."
