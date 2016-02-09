-- EDU Bot NodeMCU Lua firmware, 2016 sw@kaltpost.de
-- MIT License (MIT)
-- See LICENSE file for details

reset_reason = node.bootreason()
print("Bootreason: " .. reset_reason)

require("sta")
require("hcsr04")
-- require("mb1000")
require("telnetd")
