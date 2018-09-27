#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ras19/catkin_ws/src/ras_project/ras_uarm"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ras19/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ras19/catkin_ws/install/lib/python2.7/dist-packages:/home/ras19/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ras19/catkin_ws/build" \
    "/usr/bin/python" \
    "/home/ras19/catkin_ws/src/ras_project/ras_uarm/setup.py" \
    build --build-base "/home/ras19/catkin_ws/build/ras_project/ras_uarm" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/ras19/catkin_ws/install" --install-scripts="/home/ras19/catkin_ws/install/bin"
