

class FilesSchemas {

  static  const String getAllfilesFromPath = '''
query getAllFilesFromSamePath(\$filePath: String!,\$traverseFiles: Boolean \$isJSON: Boolean, \$sortBy: String, \$sortOrder: String,\$showHiddenFolder
: Boolean) {
  getAllFilesFromSamePath(
    filePath: \$filePath
    isJSON: \$isJSON
    sortBy: \$sortBy
    sortOrder: \$sortOrder
    traverseFiles: \$traverseFiles
    showHiddenFolder: \$showHiddenFolder
  )
}
''';
  
}