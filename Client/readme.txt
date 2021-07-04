The install process will create Client and Server subdirectories
in the install directory. You may choose to install either the
client files, the server files, or both. You have the option, if
you wish, to download the MVSDDT package to two different systems,
and install the client files on one system and the server files on
the other. Keep in mind that if you do not install both, that the
DDT client and server must be at the same version and release level,
or the client will refuse to connect to the server.

The significant files included in the Client directory will be
	- lib directory (contains DDT help files)
	- ddt.jar
	- license.txt
	- readme.txt

The Server directory will contain
	- mvsddt.het
	- mvsddt.jcl

The installation process will also create an Uninstaller folder
containing uninstall.jar which may be used to uninstall the DDT
client.

The DDT server still needs to be installed on your MVS system by
customizing and executing the MVSDDT JCL. Depending upon your
configuration, you may need to copy the server files to a location
where they can be accessed by your Hercules and MVS systems.
Information on installing the DDT server can be found in the
"Server Installation" section in the Appendix of the DDT Reference
Manual.

Following the installation process, the client should be ready to
setup. Please refer to the "Configuration Options" section of the
DDT Reference Manual to complete setting up the DDT client, and
specifying the necessary DDT server parameters.

If you have not allowed the install process to create desktop
shortcuts, the DDT Reference Manual is named "ddthelp.jar" and
is located in the "lib" subdirectory of the directory where you
installed DDT.

DDT Prerequisites:

The following are the minimum requirements for running the DDT
client and server:
  - Client Requirements
      * A hardware/software platform which provides a graphical
        user interface (GUI).
      * Java runtime support (JRE-6 or above)

  - Server Requirements
      * A hardware/software platform supported by Hercules (3.07 or above)
      * MVS 3.8J

Installer Restrictions:

1. *** 64-bit Windows Users ***
   The following considerations apply to the installer/uninstaller
   Java application, not DDT itself. If the user performing the DDT
   install does not have administrator privileges and plans to install
   DDT into the default 32-bit folder (C:\Program Files (x86) ), then
   the following conditions apply:
     - Java 6 Runtime, update 35 or above must be installed
     - Both the 32-bit and 64-bit versions of the Java Runtime are installed

   Under the conditions described above, the installer will request
   authorization to run with administrator privileges, however the
   uninstaller will not. If you wish to uninstall DDT from the default
   32-bit folder, you must be running as a user with administrative
   privileges.

2. Currently, the installation program can only create desktop
   shortcuts (if requested) for the Windows environment and
   Linux/Unix environments using the KDE desktop.

3. For Linux/Unix environments using other X11 family desktops
   (such as Gnome), MVS DDT application menu items will be created,
   but desktop shortcuts will not. You can easily add a desktop
   shortcut, however, by selecting an MVS DDT menu item, clicking
   the right mouse button, and selecting the option to add a
   launcher to the desktop.

4. For Mac OS X, the installer will provide all the necessary
   MVS DDT files, but it cannot currently create shortcuts for
   this  environment. All the pieces for creating an OS X bundle
   should be available in the Client installation folder for those
   who know how to work such magic.