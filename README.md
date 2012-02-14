# Goal

Simple, robust and handy pomodoro timer for linux.

# Tools

  * Ruby
  * Qt

# Apps list

  * server: pomod
  * CLI server console: pomocli
  * CLI/ncurces client: pomonc
  * QT client: qpomo

# Server/client interconnection

  * Server will open network socket
  * client will connect
  * client and server will use JSON for exchanging commands/data
  * server always should send confirmation and status, like: OK or Fail

