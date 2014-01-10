with
====

A simpler syntax to handle files sockets and dom

```
with [dom parse "<xml/>"] as doc {
    set root [$doc documentElement]
    puts [$root asXML]
}

with [open "/tmp/a" "a+"] as file {
   puts $file "hello world"
}
```
