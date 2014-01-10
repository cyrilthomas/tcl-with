package provide "with" 0.1
package require "try"

proc with { handle as variable block } {
    upvar $variable var

    set var $handle
    regexp "(dom|file|sock)" $handle --> handle

    ::tcl::control::try {
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