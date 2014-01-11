with
====

A simple syntactic sugar to handle files, sockets and dom and automatically clean up resources elegantly

```tcl
with [dom parse "<xml/>"] as doc {
    set root [$doc documentElement]
    puts [$root asXML]
}
```

```tcl
with [open "/tmp/a" "a+"] as file {
   puts $file "hello world"
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
