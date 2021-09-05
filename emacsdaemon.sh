#!/bin/bash
# This is useful when playing with more than 1 version of emacs. Bad things can happen if an older emacs is linking to a newer
# elpa directory once it has been updated. This keeps seperate versions of the elpa dir and symlinks to the correct one.
EMACSVERSION=$(emacs --version | awk '{print $3 ; exit}')
echo $EMACSVERSION
if [[ -L ~/.emacs.d/elpa ]]
then
    rm ~/.emacs.d/elpa
    case $EMACSVERSION in
        [28]* )
            echo "Found Emacs 28, linking elpa-28."
            ln -s ./elpa-28 ~/.emacs.d/elpa
            ;;
        [27]* )
            echo "Found Emacs 27, linking elpa-27."
            ln -s ./elpa-27 ~/.emacs.d/elpa
            ;;
        *)
            echo "Found emacs version $EMACSVERSION, linking elpa-new. FIX THIS in emacsdaemon.sh and rename!!!"
            ln -s ~/.emacs.d/elpa-new ~/.emacs.d/elpa
    esac
else
    echo "The elpa dir is not a symbolic link. Be careful it matches the version of emacs. There may be problems when reverting to an earlier version"
fi
emacs --daemon
