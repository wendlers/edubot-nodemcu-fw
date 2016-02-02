reset_reason = node.bootreason()
print("Bootreason: " .. reset_reason)

require("sta")
require("hcsr04")
-- require("mb1000")
require("telnetd")
rf.start()
