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

group "Timer"

param :timer_limit, "Time when to stop timer", %w(25:00) 

desc "Start timer"
command "start" do |timer_limit|
  puts "Timer started at 00:00"
end

desc "Stop timer"
command "stop" do
  puts "Timer stopped at 25:00"
end

desc "Reset timer"
command "reset" do
  puts "Timer reseted to 00:00"
end

desc "Check timer"
command "check" do
  puts "Timer is at 00:01"
end

group "Service"

desc "Print version"
command "version" do
  puts "rambutan #{Rambutan::VERSION} (c) 2012-2013 Konstantin Lysenko"
end

Prompt::Console.start

=begin
module Rambutan

  class CLIOptions
    include Mixlib::CLI

    option :start_timer,
      :short => "st",
      :long => "start",
      :description => "Starts timer"

    option :stop_timer,
      :short => "sp",
      :long => "stop",
      :description => "Stops timer"

    option :reset_timer,
      :short => "r",
      :long => "reset",
      :description => "Reset timer"

    option :check_timer,
      :short => "c",
      :long => "check",
      :description => "Check timer value and print it"

    option :version,
      :short => "-v",
      :long => "--version",
      :description => "Print version info"
  
    option :help,
      :short => "-h",
      :long => "--help",
      :description => "Show this message",
      :on => :tail,
      :boolean => true,
      :show_options => true,
      :exit => 0
  end
  
  class CLI
    def run
      # Proccess command line parameters
      ## If no arguments - then let's print help
    if ARGV.empty?
      puts "Well, this's embarassing, but you need to specify an option! Please read help:"
      ARGV << "-h"
    end

    cli = CLIOptions.new
    banner = <<-eos
rbtcli is an command line client for rambutan timer

Usage:
user@host:~$ ruby rbtcli
[00:00]> start 25:00
Timer started at 00:00
[00:01]>
...
[03:12]> stop
Timer stoped at 03:12
[03:12]>
...
[12:23]> check
Timer is at 12:23
[12:24]>
...
[21:11]> reset
Timer resetted to 00:00
[00:00]>
...
[25:00]> exit
user@host:~$
eos
    cli.banner=banner
    ## Parse options
    begin
      cli.parse_options
    rescue OptionParser::InvalidOption
      # if we have wrong option, print help.
      puts "Well, this's embarassing, but wrong option! Please read help:"
      ARGV.clear << "-h"
      retry
    end
    cli.config.each do |opt,value|
      if value
        case opt
          when :start_timer
            self.start
          when :stop_timer
            self.stop
          when :reset_timer
            self.reset
          when :check_timer
            self.check
          when :version
          puts "rambutan #{Rambutan::VERSION} (c) 2012-2013 Konstantin Lysenko"
        end
      end
    end

    end
  end
  def start
  end
  def stop
  end
  def check
  end
  def reset
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
# Module end
end

rcli = Rambutan::CLI.new
rcli.run
=end
