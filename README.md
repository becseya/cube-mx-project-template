# Cube MX project template

This is a template repository for setting up an embedded project with Cube MX and VS Code under Linux. The goal is to have a headless build environment besides the initial code generation.

### Ejecting the template:
- Open CubeMX, create a new project and select your board.
- Click _File_ -> _Save Project as_ and save the project to a temporary location
- Locate the freshly created __.ioc__ project file and open it in a text editor
- Click _"Use this template"_ on GitHub
- Open __project.ioc__ in the cloned repo
- Merge the two project files by copying and overwriting lines starting with `Mcu.`
- Save __project.ioc__
- Call `make download-firmware`
- Goto CubeMX, _File_ -> _Load Project_, and load __project.ioc__
- Click _Generate_
- Call `make` from the repo
