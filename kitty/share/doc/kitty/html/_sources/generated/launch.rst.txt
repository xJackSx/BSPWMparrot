.. highlight:: sh
.. code-block:: sh

  launch [options] [program-to-run ...]

Launch an arbitrary program in a new kitty window/tab. Note that
if you specify a program-to-run you can use the special placeholder
:code:`@selection` which will be replaced by the current selection.


Options
______________________________
.. option:: --source-window <SOURCE_WINDOW>

    A match expression to select the window from which data such as title, colors, env vars, screen contents, etc. are copied. When not specified the currently active window is used. See :ref:`search_syntax` for the syntax used for specifying windows.

.. option:: --title <WINDOW_TITLE>, --window-title <WINDOW_TITLE>

    The title to set for the new window. By default, title is controlled by the child process. The special value :code:`current` will copy the title from the :option:`source window <launch --source-window>`.

.. option:: --tab-title <TAB_TITLE>

    The title for the new tab if launching in a new tab. By default, the title of the active window in the tab is used as the tab title. The special value :code:`current` will copy the title from the tab containing the :option:`source window <launch --source-window>`.

.. option:: --type <TYPE>

    Where to launch the child process:

    :code:`window`
        A new :term:`kitty window <window>` in the current tab

    :code:`tab`
        A new :term:`tab` in the current OS window. Not available when the :doc:`launch <launch>` command is used in :ref:`startup sessions <sessions>`.

    :code:`os-window`
        A new :term:`operating system window <os_window>`.  Not available when the :doc:`launch <launch>` command is used in :ref:`startup sessions <sessions>`.

    :code:`overlay`
        An :term:`overlay window <overlay>` covering the current active kitty window

    :code:`overlay-main`
        An :term:`overlay window <overlay>` covering the current active kitty window. Unlike a plain overlay window, this window is considered as a :italic:`main` window which means it is used as the active window for getting the current working directory, the input text for kittens, launch commands, etc. Useful if this overlay is intended to run for a long time as a primary window.

    :code:`background`
        The process will be run in the :italic:`background`, without a kitty window. Note that if :option:`kitten @ launch --allow-remote-control` is specified the :envvar:`KITTY_LISTEN_ON` environment variable will be set to a dedicated socket pair file descriptor that the process can use for remote control.

    :code:`clipboard`, :code:`primary`
        These two are meant to work with :option:`--stdin-source <launch --stdin-source>` to copy data to the :italic:`system clipboard` or :italic:`primary selection`.

    :code:`os-panel`
        Similar to :code:`os-window`, except that it creates the new OS Window as a desktop panel. Only works on platforms that support this, such as Wayand compositors that support the layer shell protocol. Use the :option:`kitten @ launch --os-panel` option to configure the panel.


    Default: :code:`window`
    Choices: :code:`background`, :code:`clipboard`, :code:`os-panel`, :code:`os-window`, :code:`overlay`, :code:`overlay-main`, :code:`primary`, :code:`tab`, :code:`window`

.. option:: --dont-take-focus [=no], --keep-focus [=no]

    Keep the focus on the currently active window instead of switching to the newly opened window.

.. option:: --cwd <CWD>

    The working directory for the newly launched child. Use the special value :code:`current` to use the working directory of the :option:`source window <launch --source-window>` The special value :code:`last_reported` uses the last working directory reported by the shell (needs :ref:`shell_integration` to work). The special value :code:`oldest` works like :code:`current` but uses the working directory of the oldest foreground process associated with the currently active window rather than the newest foreground process. Finally, the special value :code:`root` refers to the process that was originally started when the window was created.

    When opening in the same working directory as the current window causes the new window to connect to a remote host, you can use the :option:`--hold-after-ssh` flag to prevent the new window from closing when the connection is terminated.

.. option:: --add-to-session <ADD_TO_SESSION>

    Add the newly created window/tab to the specified session. Use :code:`.` to add to the session of the :option:`source window <launch --source-window>`, if any. See :ref:`sessions` for what a session is and how to use one. By default, the window is added to the session of the :option:`source window <launch --source-window>` when :option:`launch --cwd` is set to use the the working directory from that window, otherwise the newly created window does not belong to any session. To force adding to no session, use the value :code:`!`. Adding a newly created window to a session is purely temporary, it does not change the actual session file, for that you have to resave the session. Note that using this flag in a launch command within a session file has no effect as the window is always added to the session belonging to that file.

.. option:: --env <ENV>

    Environment variables to set in the child process. Can be specified multiple times to set different environment variables. Syntax: :code:`name=value`. Using :code:`name=` will set to empty string and just :code:`name` will remove the environment variable.

.. option:: --var <VAR>

    User variables to set in the created window. Can be specified multiple times to set different user variables. Syntax: :code:`name=value`. Using :code:`name=` will set to empty string.

.. option:: --hold [=no]

    Keep the window open even after the command being executed exits, at a shell prompt. The shell will be run after the launched command exits.

.. option:: --copy-colors [=no]

    Set the colors of the newly created window to be the same as the colors in the :option:`source window <launch --source-window>`.

.. option:: --copy-cmdline [=no]

    Ignore any specified command line and instead use the command line from the :option:`source window <launch --source-window>`.

.. option:: --copy-env [=no]

    Copy the environment variables from the :option:`source window <launch --source-window>` into the newly launched child process. Note that this only copies the environment when the window was first created, as it is not possible to get updated environment variables from arbitrary processes. To copy that environment, use either the :ref:`clone-in-kitty <clone_shell>` feature or the kitty remote control feature with :option:`kitten @ launch --copy-env`.

.. option:: --location <LOCATION>

    Where to place the newly created window when it is added to a tab which already has existing windows in it. :code:`after` and :code:`before` place the new window before or after the active window. :code:`neighbor` is a synonym for :code:`after`. Also applies to creating a new tab, where the value of :code:`after` will cause the new tab to be placed next to the current tab instead of at the end. The values of :code:`vsplit`, :code:`hsplit` and :code:`split` are only used by the :code:`splits` layout and control if the new window is placed in a vertical, horizontal or automatic split with the currently active window. The default is to place the window in a layout dependent manner, typically, after the currently active window. See :option:`--next-to <launch --next-to>` to use a window other than the currently active window.
    Default: :code:`default`
    Choices: :code:`after`, :code:`before`, :code:`default`, :code:`first`, :code:`hsplit`, :code:`last`, :code:`neighbor`, :code:`split`, :code:`vsplit`

.. option:: --next-to <NEXT_TO>

    A match expression to select the window next to which the new window is created. See :ref:`search_syntax` for the syntax for specifying windows. If not specified defaults to the active window. When used via remote control and a target tab is specified this option is ignored unless the matched window is in the specified tab. When using :option:`--type <launch --type>` of :code:`tab`, the tab will be created in the OS Window containing the matched window.

.. option:: --bias <BIAS>

    The bias used to alter the size of the window. It controls what fraction of available space the window takes. The exact meaning of bias depends on the current layout.

    * Splits layout: The bias is interpreted as a percentage between 0 and 100. When splitting a window into two, the new window will take up the specified fraction of the space allotted to the original window and the original window will take up the remainder of the space.

    * Vertical/horizontal layout: The bias is interpreted as adding/subtracting from the normal size of the window. It should be a number between -90 and 90. This number is the percentage of the OS Window size that should be added to the window size. So for example, if a window would normally have been size 50 in the layout inside an OS Window that is size 80 high and --bias -10 is used it will become *approximately* size 42 high. Note that sizes are approximations, you cannot use this method to create windows of fixed sizes.

    * Tall layout: If the window being created is the *first* window in a column, then the bias is interpreted as a percentage, as for the splits layout, splitting the OS Window width between columns. If the window is a second or subsequent window in a column the bias is interpreted as adding/subtracting from the window size as for the vertical layout above.

    * Fat layout: Same as tall layout except it goes by rows instead of columns.

    * Grid layout: The bias is interpreted the same way as for the Vertical and Horizontal layouts, as something to be added/subtracted to the normal size. However, the since in a grid layout there are rows *and* columns, the bias on the first window in a column operates on the columns. Any later windows in that column operate on the row. So, for example, if you bias the first window in a grid layout it will change the width of the first column, the second window, the width of the second column, the third window, the height of the second row and so on.

    The bias option was introduced in kitty version 0.36.0.
    Default: :code:`0`

.. option:: --allow-remote-control [=no]

    Programs running in this window can control kitty (even if remote control is not enabled in :file:`kitty.conf`). Note that any program with the right level of permissions can still write to the pipes of any other program on the same computer and therefore can control kitty. It can, however, be useful to block programs running on other computers (for example, over SSH) or as other users. See :option:`--remote-control-password` for ways to restrict actions allowed by remote control.

.. option:: --remote-control-password <REMOTE_CONTROL_PASSWORD>

    Restrict the actions remote control is allowed to take. This works like :opt:`remote_control_password`. You can specify a password and list of actions just as for :opt:`remote_control_password`. For example::

        --remote-control-password '"my passphrase" get-* set-colors'

    This password will be in effect for this window only. Note that any passwords you have defined for :opt:`remote_control_password` in :file:`kitty.conf` are also in effect. You can override them by using the same password here. You can also disable all :opt:`remote_control_password` global passwords for this window, by using::

        --remote-control-password '!'

    This option only takes effect if :option:`--allow-remote-control` is also specified. Can be specified multiple times to create multiple passwords. This option was added to kitty in version 0.26.0

.. option:: --stdin-source <STDIN_SOURCE>

    Pass the screen contents as :file:`STDIN` to the child process.

    :code:`@selection`
        is the currently selected text in the :option:`source window <launch --source-window>`.

    :code:`@screen`
        is the contents of the :option:`source window <launch --source-window>`.

    :code:`@screen_scrollback`
        is the same as :code:`@screen`, but includes the scrollback buffer as well.

    :code:`@alternate`
        is the secondary screen of the :option:`source window <launch --source-window>`. For example if you run a full screen terminal application, the secondary screen will be the screen you return to when quitting the application.

    :code:`@first_cmd_output_on_screen`
        is the output from the first command run in the shell on screen.

    :code:`@last_cmd_output`
        is the output from the last command run in the shell.

    :code:`@last_visited_cmd_output`
        is the first output below the last scrolled position via :ac:`scroll_to_prompt`, this needs :ref:`shell integration <shell_integration>` to work.


    Default: :code:`none`
    Choices: :code:`@alternate`, :code:`@alternate\_scrollback`, :code:`@first\_cmd\_output\_on\_screen`, :code:`@last\_cmd\_output`, :code:`@last\_visited\_cmd\_output`, :code:`@screen`, :code:`@screen\_scrollback`, :code:`@selection`, :code:`none`

.. option:: --stdin-add-formatting [=no]

    When using :option:`--stdin-source <launch --stdin-source>` add formatting escape codes, without this only plain text will be sent.

.. option:: --stdin-add-line-wrap-markers [=no]

    When using :option:`--stdin-source <launch --stdin-source>` add a carriage return at every line wrap location (where long lines are wrapped at screen edges). This is useful if you want to pipe to program that wants to duplicate the screen layout of the screen.

.. option:: --marker <MARKER>

    Create a marker that highlights text in the newly created window. The syntax is the same as for the :ac:`toggle_marker` action (see :doc:`/marks`).

.. option:: --os-window-class <OS_WINDOW_CLASS>

    Set the :italic:`WM_CLASS` property on X11 and the application id property on Wayland for the newly created OS window when using :option:`--type=os-window <launch --type>`. Defaults to whatever is used by the parent kitty process, which in turn defaults to :code:`kitty`.

.. option:: --os-window-name <OS_WINDOW_NAME>

    Set the :italic:`WM_NAME` property on X11 for the newly created OS Window when using :option:`--type=os-window <launch --type>`. Defaults to :option:`--os-window-class <launch --os-window-class>`.

.. option:: --os-window-title <OS_WINDOW_TITLE>

    Set the title for the newly created OS window. This title will override any titles set by programs running in kitty. The special value :code:`current` will copy the title from the OS Window containing the :option:`source window <launch --source-window>`.

.. option:: --os-window-state <OS_WINDOW_STATE>

    The initial state for the newly created OS Window.
    Default: :code:`normal`
    Choices: :code:`fullscreen`, :code:`maximized`, :code:`minimized`, :code:`normal`

.. option:: --logo <LOGO>

    Path to a PNG image to use as the logo for the newly created window. See :opt:`window_logo_path`. Relative paths are resolved from the kitty configuration directory.

.. option:: --logo-position <LOGO_POSITION>

    The position for the window logo. Only takes effect if :option:`--logo` is specified. See :opt:`window_logo_position`.

.. option:: --logo-alpha <LOGO_ALPHA>

    The amount the window logo should be faded into the background. Only takes effect if :option:`--logo` is specified. See :opt:`window_logo_alpha`.
    Default: :code:`-1`

.. option:: --color <COLOR>

    Change colors in the newly launched window. You can either specify a path to a :file:`.conf` file with the same syntax as :file:`kitty.conf` to read the colors from, or specify them individually, for example::

        --color background=white --color foreground=red

.. option:: --spacing <SPACING>

    Set the margin and padding for the newly created window. For example: :code:`margin=20` or :code:`padding-left=10` or :code:`margin-h=30`. The shorthand form sets all values, the :code:`*-h` and :code:`*-v` variants set horizontal and vertical values. Can be specified multiple times. Note that this is ignored for overlay windows as these use the settings from the base window.

.. option:: --watcher <WATCHER>, -w <WATCHER>

    Path to a Python file. Appropriately named functions in this file will be called for various events, such as when the window is resized, focused or closed. See the section on watchers in the launch command documentation: :ref:`watchers`. Relative paths are resolved relative to the :ref:`kitty config directory <confloc>`. Global watchers for all windows can be specified with :opt:`watcher` in :file:`kitty.conf`.

.. option:: --os-panel <OS_PANEL>

    Options to control the creation of desktop panels. Takes the same settings as the :doc:`panel kitten </kittens/panel>`, except for :option:`--override <kitty +kitten panel --override>` and :option:`--config <kitty +kitten panel --config>`. Can be specified multiple times. For example, to create a desktop panel at the bottom of the screen two lines high::

        launch --type os-panel --os-panel lines=2 --os-panel edge=bottom sh -c "echo; echo; echo hello; sleep 5s"

.. option:: --hold-after-ssh [=no]

    When using :option:`--cwd`:code:`=current` or similar from a window that is running the ssh kitten, the new window will run a local shell after disconnecting from the remote host, when this option is specified.
