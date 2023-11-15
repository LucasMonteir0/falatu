String getDocumentExtensionIcon(String extension){
 switch(extension.toLowerCase()) {
   case 'pdf':
    return 'assets/icons/documents/pdf.png';
   case 'doc':
      return 'assets/icons/documents/docs.png';
    case 'docx':
      return 'assets/icons/documents/docs.png';
    case 'xls':
      return 'assets/icons/documents/sheets.xls';
    case 'xlsx':
      return 'assets/icons/documents/sheets.xlsx';
    case 'csv':
      return 'assets/icons/documents/sheets.csv';
    case 'txt':
      return 'assets/icons/documents/txt2.png';
   case 'ppt':
      return 'assets/icons/documents/slides.png';
    default:
      return 'assets/icons/documents/default.png';
 }

}