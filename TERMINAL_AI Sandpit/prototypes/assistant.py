# Extend this to allow the create a default assistant called TerminalAI if it does not already exists, include the send_post_requests
import http.client
import urllib.parse
import json
import os
OPENAI_ENV_PATH = '/root/keystore/api-keys/openai'


def send_get_requests(url, headers):
    parsed_url = urllib.parse.urlparse(url)
    conn = http.client.HTTPSConnection(parsed_url.netloc)
    conn.request("GET", parsed_url.path, headers=headers)
    # Get the response
    response = conn.getresponse()
    
    # Read and decode the response
    response_data = response.read().decode('utf-8')
    
    # Close the connection
    conn.close()
    
    # Optionally, parse the JSON response
    try:
        return json.loads(response_data)
    except json.JSONDecodeError:
        return response_data

def send_post_requests(url, headers, body):
    parsed_url = urllib.parse.urlparse(url)
    conn = http.client.HTTPSConnection(parsed_url.netloc)
    conn.request("GET", parsed_url.path, headers=headers)
    # Get the response
    response = conn.getresponse()
    
    # Read and decode the response
    response_data = response.read().decode('utf-8')
    
    # Close the connection
    conn.close()
    
    # Optionally, parse the JSON response
    try:
        return json.loads(response_data)
    except json.JSONDecodeError:
        return response_data


def source_env_file(filepath = OPENAI_ENV_PATH):
    if not os.path.isfile(filepath):
        raise FileNotFoundError(f"The file {filepath} does not exist")

    with open(filepath) as file:
        for line in file:
            # Remove comments and empty lines
            line = line.strip()
            if not line or line.startswith('#'):
                continue

            # Split the line into key and value
            key, value = line.split('=', 1)
            key = key.strip()
            value = value.strip().strip('"').strip("'")  # Handle quotes

            # Set the environment variable
            os.environ[key] = value

def get_headers():
    source_env_file()
    return {
        "Authorization": f"Bearer {os.environ['OPENAI_API_KEY']}",
        "OpenAI-Project": f"{os.environ['OPENAI_PROJECT_ID']}",
        "Content-Type": "application/json",
        "OpenAI-Beta": "assistants=v2"
    }

def get_models():
    url = "https://api.openai.com/v1/models"
    headers = get_headers()
    response = send_get_requests(url, headers)
    return response

def get_assistants():
    url = "https://api.openai.com/v1/assistants"
    headers = get_headers()
    response = send_get_requests(url, headers)
    return response


responses = [
        get_models(),
        get_assistants()
        ]
for response in responses:
    print(response)


