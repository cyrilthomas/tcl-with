package provide "with" 0.1
package require "try"

proc with { channel as variable block } {
    upvar $variable var

    set var $channel
    if { ![regexp "(dom|file|sock)" $channel --> channel] } {
        error "Unknown channel type - '$channel'! "
    }

    ::tcl::control::try {
        uplevel $block
    } finally {
        switch $channel {
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
}