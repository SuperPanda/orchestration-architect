#!/bin/bash

# Base namespace for the project
BASE_NAMESPACE="urn:oa:project"

# Function to generate a Jinja2 template inline
generate_template() {
  cat <<EOF
@prefix project: <$BASE_NAMESPACE#> .

{% for task in tasks %}
project:{{ task.name | replace(" ", "_") }} a project:Task ;
    project:description "{{ task.description }}" ;
    project:status "{{ task.status }}" .
{% endfor %}
EOF
}

# Function to parse YAML and generate the TTL file
generate_ttl() {
  local yaml_file="$1"
  local output_dir="./output"
  local output_file="${output_dir}/kanban.ttl"

  if [ ! -f "$yaml_file" ]; then
    echo "YAML file not found: $yaml_file"
    exit 1
  fi

  mkdir -p "$output_dir"
  j2 --format=yaml <(generate_template) "$yaml_file" > "$output_file"

  echo "Generated TTL file: $output_file"
}

# Main logic
case $1 in
  generate)
    generate_ttl "$2"
    ;;
  *)
    echo "Usage: $0 generate <yaml_file>"
    ;;
esac

