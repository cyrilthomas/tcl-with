with
====

A simple syntactic sugar to handle files, sockets and dom and automatically clean up resources

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
