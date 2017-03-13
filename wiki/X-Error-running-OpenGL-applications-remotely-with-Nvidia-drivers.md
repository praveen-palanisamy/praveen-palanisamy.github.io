## X Error when running OpenGL applications remotely through ssh -X on Ubuntu with Nvidia drivers
Running OpenGL based applications on a remote computer through a ssh tunnel with X11 forwarding (`ssh -X userName@remoteIpAddress` or `ssh -Y userName@remoteIpAddress`), might not be successful and result in `X Error` like below:

```bash
X Error: BadValue (integer parameter out of range for operation) 2
  Extension:       154 (Uknown extension)
  Minor opcode:  3 (Unknown request)
  Resource id:     0x0
```

The OpenGL based rendering application may also complain that it is `Unable to create GL context`. For example (using Qt):
> QGLTempContext: Unable to create GL context.

### Some background about `ssh -X` and OpenGL rendering
By default if Nvidia's graphics driver is in use by the computer, *direct rendering* is enabled. You can check this by running `glxinfo |grep rendering` OR `nvidia-settings --glxinfo |grep rendering`. If the result says `direct rendering: Yes`, then direct rendering is the default mode.
If *direct rendering* is enabled then the function calls made by the rendering applications are directly sent to the GPU for execution. If *direct rendering* is set to false, *indirect rendering* mode (`iglx`) is used in which case the function calls made by the rendering applications are sent to `X.org` using the `GLX` protocol and then `X.org` makes the function calls on the GPU to draw and render. 

When we  establish a remote connection with x11 forwarding using `ssh -X userName@serveerIpAddress` OR `ssh -Y userName@serverIpAddress`, the x11 forwarding setup uses GLX (indirect rendering?) for any OpenGL calls. The Nvidia libGL (at least by default) does not allow indirect GLX calls. Preventing the application that uses OpenGL to be run on the remote computer through the secure shell with x11 forwarding and authentication.

### Troubleshooting the issue
If you are on Ubuntu and have mesa-utils  installed, run `glxinfo` to get information about the display, GLX version and the supported glx extensions on the server and client.
If you are using Nvidia's driver then the equivalent is to run `nvidia-settings --glxinfo`.
If you get the following error:
```bash
X Error of failed request:  BadValue (integer parameter out of range for operation)
  Major opcode of failed request:  154 (GLX)
  Minor opcode of failed request:  3 (X_GLXCreateContext)
  Value in failed request:  0x0
  Serial number of failed request:  563
  Current serial number in output stream:  564
GLX Information for localhost:10.0:
```

Then, it probably means that the OpenGL implementations on the local machine and the remote machine are different. In most cases this arises because either the local machine or the remote machine is using Nvidia's `libGL.so` while the other machine is using mesa's `libGL.so`.

### The solution
Make sure that both the local and the remote machines are using mesa's libGL.
One way to figure out which libGL implementation the system is currently using is by running `ldconfig -p |grep libGL.so`
This is a sample output from an Ubuntu machine that uses mesa's libGL with Nivdia discrete GPU and Nvidia drivers.:
```bash
libGL.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libGL.so.1
	libGL.so.1 (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/mesa/libGL.so.1
	libGL.so.1 (libc6,x86-64) => /usr/lib/libGL.so.1
	libGL.so.1 (libc6) => /usr/lib32/libGL.so.1
	libGL.so (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/libGL.so
	libGL.so (libc6,x86-64) => /usr/lib/x86_64-linux-gnu/mesa/libGL.so
	libGL.so (libc6) => /usr/lib32/libGL.so
```
