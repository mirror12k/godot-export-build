# Godot Export Action
This GitHub Action automates the process of building and exporting Godot Engine projects.

## Inputs

### `godot-version`

**Required** This input specifies the version of the Godot Engine that should be used for building and exporting the project.

### `project-path`

**Optional** This input specifies the path to the Godot project directory. If not specified, it defaults to the current directory (`.`).

## Example Usage
To use this action, you can create a workflow file (e.g., `.github/workflows/build-and-export.yml`) in your repository:

```yml
name: Build Godot Project

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Check out the repository
      uses: actions/checkout@v2

    - name: Export the godot project
      uses: mirror12k/godot-export-build@v1
      with:
        godot-version: '4.2.1'
        project-path: '.'

    - name: Archive production artifacts
      uses: actions/upload-artifact@v2
      with:
        name: builds
        path: build/*

```


## Contributing

If you have suggestions for how to improve this action, consider opening an issue or pull request in the action's repository.
