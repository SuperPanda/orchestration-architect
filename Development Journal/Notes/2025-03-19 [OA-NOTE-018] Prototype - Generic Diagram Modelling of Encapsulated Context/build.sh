diagram_source="$1.d2"
diagram_output="$1.svg"

if [[ -f "$diagram_source" ]]; then
  echo "Converting $diagram_source to $diagram_output"
  d2 --watch=true "$diagram_source" "$diagram_output" --browser=1
else
  echo "not found: $diagram_source"
fi
