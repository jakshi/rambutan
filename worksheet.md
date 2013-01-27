# Tools

  * Ruby
  * Qt

# Apps list

  * server: rbtd
  * CLI server console: rbtcli
  * CLI/ncurces client: rbtnc
  * QT client: qrbt

# Server/client interconnection

  * Server will open network socket
  * client will connect
  * client and server will use JSON for exchanging commands/data
  * server will store status for command like: OK or Fail, client can check it.

# Useful libraries

  * Ruby
    * cri - library for building easy-to-use commandline tools.
    * json - http://json.rubyforge.org/ library for json in Ruby
