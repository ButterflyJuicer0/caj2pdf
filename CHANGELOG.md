# Changelog

## [Feature Branch] TXT Support with PyMuPDF

### Added
- **PDF to TXT conversion**: New `pdf2txt.py` tool using pdfplumber
- **Batch conversion script**: `batch_caj2txt.bat` for converting all CAJ files to TXT
- **PyMuPDF integration**: Replaced external mutool dependency with PyMuPDF library

### Changed
- **Dependencies**: Added PyMuPDF and pdfplumber to requirements.txt
- **CAJ Parser**: Modified `cajparser.py` to use PyMuPDF instead of external mutool command
- **Error handling**: Improved error handling with fallback mechanisms

### Fixed
- **Windows compatibility**: Resolved mutool dependency issues on Windows
- **Encoding issues**: Better handling of Chinese filenames and content

### Technical Details
- Replaced `subprocess.check_output(["mutool", ...])` calls with `fitz.open()` and `doc.save()`
- Added fallback file copying when PyMuPDF operations fail
- Maintained backward compatibility with existing CAJ conversion functionality

### Usage
```bash
# Convert single CAJ to TXT
python caj2pdf convert file.caj -o file.pdf
python pdf2txt.py file.pdf -o file.txt

# Batch convert all CAJ files in directory
batch_caj2txt.bat .
```