with
====

A simple syntactic sugar to handle files, sockets and dom with automatic resource clean up.

```tcl
with [dom parse "<xml/>"] as doc {
    set root [$doc documentElement]
    set xml [$root asXML]
}
puts "here is my xml:\n$xml"
```

```tcl
with [open "/tmp/a" "a+"] as file {
   puts $file "hello world"
}
```

```tcl
# Server
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
with [socket "localhost" 6789] as sock {
    puts $sock "testing"
}
```
Auto clean up of stale handles
```tcl
package require "with"
package require "tdom"

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
