#!/bin/bash
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
            echo "Found emacs version $EMACSVERSION, linking elpa-new"
            ln -s ~/.emacs.d/elpa-new ~/.emacs.d/elpa
    esac
else
    echo "The elpa dir is not a symbolic link. Be careful it matches the version of emacs. There may be problems when reverting to an earlier version"
fi
emacs --daemon
