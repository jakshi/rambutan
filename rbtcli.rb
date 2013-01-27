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
# usage: ruby rbtd.rb [host] port

require "socket"

if ARGV.length >= 2
  host = ARGV.shift
else
  host = "localhost"
end
print("Trying ", host, " ...")
STDOUT.flush
s = TCPSocket.open(host, ARGV.shift)
print(" done\n")
print("addr: ", s.addr.join(":"), "\n")
print("peer: ", s.peeraddr.join(":"), "\n")
while line = gets()
  s.write(line)
  print(s.readline)
end
s.close
