#   Copyright 2012-2013 Konstantin Lysenko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# rbtcli.rb - client side 
# usage: ruby rbtcli.rb --version
# rambutan 0.0.1 (c) 2012-2013 Konstantin Lysenko"
# usage: ruby rbtcli.rb --help
# user@host:~$ ruby rbtcli
# [00:00]> start 25:00
# Timer started at 00:00
# [00:01]>
# ...
# [03:12]> stop
# Timer stoped at 03:12
# [03:12]>
# ...
# [12:23]> check
# Timer is at 12:23
# [12:24]>
# ...
# [21:11]> reset
# Timer resetted to 00:00
# [00:00]>
# ...
# [25:00]> exit
# user@host:~$

# Temporary - need to be here till we transform rambutan app to gem
$LOAD_PATH << '.'

require "socket"
require "prompt"
require "mixlib/config"
require "mixlib/cli"
require "rambutan/version.rb"

extend Prompt::DSL

module Rambutan
  class CLI
    def run
    end
    def start
      puts "Timer started at 00:00"
    end
    def stop
      puts "Timer stopped at 25:00"
    end
    def check
     puts "Timer is at 00:01"
    end
    def reset
      puts "Timer reseted to 00:00"
    end
    def connect
      host = "localhost"
      print("Trying ", host, " ...")
      STDOUT.flush
      s = TCPSocket.open(host, 32768)
      print(" done\n")
      print("addr: ", s.addr.join(":"), "\n")
      print("peer: ", s.peeraddr.join(":"), "\n")
      while line = gets()
        s.write(line)
        print(s.readline)
      end
      s.close
    end
  end
# Module end
end

rcli = Rambutan::CLI.new
rcli.run

group "Timer"

param :timer_limit, "Time when to stop timer", %w(25:00) 

desc "Start timer"
command "start" do |timer_limit|
  rcli.start
end

desc "Stop timer"
command "stop" do
  rcli.stop
end

desc "Reset timer"
command "reset" do
  rcli.reset
end

desc "Check timer"
command "check" do
  rcli.check
end

group "Service"

desc "Print version"
command "version" do
  puts "rambutan #{Rambutan::VERSION} (c) 2012-2013 Konstantin Lysenko"
end

Prompt::Console.start
