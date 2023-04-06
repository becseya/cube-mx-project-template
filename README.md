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

# Dev environment
If you have ST's CubeProgrammer installed, You can flash your target with `make flash`.
Install location must be added to `PATH` or specified by `DIR_CUBE_PROGRAMMER` environment variable.

# Documentation

I don't have time to write proper documentation at the moment, the workings can be reverse-engineered from the Makefiles. In the meantime, I recommend [this article](https://www.e-tinkers.com/2022/04/a-better-way-to-setup-stm32cubeide/) whose author probably had similar goals in his mind as me.

## Troubleshooting

### Symptom

Error messages referencing USB connection when flashing the device.

### Solution

```
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="0666"' | sudo tee /etc/udev/rules.d/70-st-link.rules
echo 'SUBSYSTEMS=="usb_device", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="0666"' | sudo tee /etc/udev/rules.d/70-st-link.rules
reboot
```
__Note:__ `idProduct` might differ in your case, use `lsusb` to find out the value for your particular device.
