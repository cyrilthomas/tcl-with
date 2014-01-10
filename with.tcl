package provide "with" 0.1
package require "tdom"
package require "try"

proc with { handle as variable block } {
    upvar $variable var

    set var $handle
    regexp "(dom|file|sock)" $handle --> handle

    try {
        uplevel $block
    } finally {
        switch $handle {
            dom {
                $var delete
            }
            sock -
            file -
            default {
                close $var
            }
        }
    }
    
    unset var
}


# with [dom parse "<xml/>"] as doc {
#     set root [$doc documentElement]
#     puts [$root asXML]
# }