function generate_manifest(){
  fd --ignore-file .gitignore | grep -E ".rs|.html" > project-files.manifest
}

function display_files(){
  for i in $(cat project-files.manifest); do
    echo "=== START OF FILE: $i ==="
    cat "$i"
    echo "=== END OF FILE: $i ==="
  done
}

generate_manifest
display_files
