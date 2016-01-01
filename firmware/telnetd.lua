require("router")

print("Started telnetd")

s=net.createServer(net.TCP, 180)
s:listen(23, function(c)
   function s_output(str)
      if(c~=nil)
         then c:send(str .. "\n")
      end
   end
   c:on("receive", function(c, l)
	  s_output(router.route(l)) 
   end)
   c:on("disconnection", function(c)
      s_output("OK")
   end)
end)
