from ruamel.yaml import YAML
import sys

def reformat_yaml(input_file_path, output_file_path, indent_mapping=2, indent_sequence=4):
    yaml = YAML()
    # Set the indentation for mappings and sequences
    yaml.indent(mapping=indent_mapping, sequence=indent_sequence, offset=2)

    # Read the original YAML file
    with open(input_file_path, 'r') as input_file:
        data = yaml.load(input_file)

    # Write the reformatted YAML file
    with open(output_file_path, 'w') as output_file:
        yaml.dump(data, output_file)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python reformat_yaml.py <input_file> <output_file>")
        sys.exit(1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]
    # You can adjust the indent levels here
    reformat_yaml(input_path, output_path)
