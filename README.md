# Goal

Simple, robust and handy pomodoro timer for linux.

# Tools

  * Ruby
  * Qt

# Apps list

  * server: pomod
  * CLI server console: pomocli
  * CLI/ncurces client
  * QT client

# Server/client interconnection

  * Server will open network socket
  * client will connect
  * client and server will use JSON for exchanging commands/data
  * server always should send confirmation and status, like: OK or Fail

# Useful libraries

  * Ruby
    * cri - library for building easy-to-use commandline tools.
    * json - http://json.rubyforge.org/ library for json in Ruby
