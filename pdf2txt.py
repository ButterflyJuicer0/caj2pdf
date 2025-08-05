#!/usr/bin/env python3
import argparse
import pdfplumber
import sys
from pathlib import Path

def pdf_to_txt(pdf_path, txt_path=None):
    """Convert PDF file to TXT file"""
    pdf_file = Path(pdf_path)
    
    if not pdf_file.exists():
        print(f"Error: File {pdf_path} does not exist")
        return False
    
    if txt_path is None:
        txt_path = pdf_file.with_suffix('.txt')
    
    try:
        with pdfplumber.open(pdf_path) as pdf:
            text_content = []
            
            for page_num, page in enumerate(pdf.pages, 1):
                text = page.extract_text()
                if text:
                    text_content.append(f"--- Page {page_num} ---\n")
                    text_content.append(text)
                    text_content.append("\n\n")
            
            with open(txt_path, 'w', encoding='utf-8') as txt_file:
                txt_file.writelines(text_content)
            
            print(f"Conversion completed: {pdf_path} -> {txt_path}")
            print(f"Processed {len(pdf.pages)} pages")
            return True
            
    except Exception as e:
        print(f"Conversion failed: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Convert PDF file to TXT file')
    parser.add_argument('input', help='Input PDF file path')
    parser.add_argument('-o', '--output', help='Output TXT file path (optional)')
    
    args = parser.parse_args()
    
    success = pdf_to_txt(args.input, args.output)
    sys.exit(0 if success else 1)

if __name__ == '__main__':
    main()