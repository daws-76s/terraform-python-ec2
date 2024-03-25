import requests
import json

# Configuration
github_token = 'your-token'
organization_name = 'daws-76s'
repo_name = 'terraform-python-ec2'
description = 'This repo is to discuss about python usecases'

# GitHub API URL for creating a repository within an organization
url = f'https://api.github.com/orgs/{organization_name}/repos'

# Headers and payload
headers = {
    'Authorization': f'token {github_token}',
    'Accept': 'application/vnd.github.v3+json',
}
# this is the data we are sending to create repo
payload = {
    'name': repo_name,
    'description': description,
    'private': False  # Set to True if you want to create a private repository
}

# Make the request to create a repository
response = requests.post(url, headers=headers, data=json.dumps(payload))

# Check the response
if response.status_code == 201: #201, created. it means success
    print(f'Repository {repo_name} created successfully within {organization_name}.')
    print(f'Repository URL: {response.json()["html_url"]}')
else:
    print(f'Failed to create repository in {organization_name}. Status code: {response.status_code}')
    print(f'Response: {response.text}')
