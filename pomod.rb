#   Copyright 2012 Konstantin Lysenko
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


# socket example - server side using thread
# usage: ruby tsvr.rb

require "socket"

gs = TCPServer.open(0)
addr = gs.addr
addr.shift
printf("server is on %s\n", addr.join(":"))

loop do
  Thread.start(gs.accept) do |s|
    print(s, " is accepted\n")
    while line = s.gets
      s.write(line)
    end
    print(s, " is gone\n")
    s.close
  end
end
