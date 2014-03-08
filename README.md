# with

A simple syntactic sugar to handle files, sockets and dom with automatic resource clean up.

###### DOM example
```tcl
package require "tdom"
package require "with"

with [dom parse "<xml/>"] as doc {
    set root [$doc documentElement]
    set xml [$root asXML]
}
puts "here is my xml:\n$xml"
```

###### File example
```tcl
package require "with"

with [open "/tmp/a" "a+"] as file {
   puts $file "hello world"
}
```

###### Socket example

```tcl
# Server
package require "with"

proc connected { channel addr port } {
    with $channel as chan {
        fconfigure $chan -buffering none -blocking 0
        
        puts "hello client $chan $addr $port"
        puts "recieved message ... [read $chan]"
    }
    puts "closed client $chan"
}

after 60000 { set shutdown 1 }

with [socket -server connected 6789] as sock {
    vwait shutdown
}

# Client
package require "with"

with [socket "localhost" 6789] as sock {
    puts $sock "testing"
}
```
###### Nested channel types example
*Auto clean up of stale handles*
```tcl
package require "tdom"
package require "with"

with [open "/tmp/a.xml"] as file {
    with [dom parse [read $file]] as doc {
        puts [$doc asXML]
        some_broken_code
    }
}
```

Dependencies
=====
tcllib - try
