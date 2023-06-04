#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh
#
# SPDX-License-Identifier: GPL-3.0-or-later

PATH_TO_INSTALL=""

while [ -n "${1}" ]
do
    case "$1" in
        -d|--debug)
            set -x
        ;;
        -e|--error)
            set -e
        ;;
        *)
            PATH_TO_INSTALL="$1"
        ;;
    esac
    shift
done

if [ -z "${PATH_TO_INSTALL}" ]
then
    echo >&2 "Path to install not specified"
    echo >&2 ""
    echo >&2 "Use $0 <path_to_install>"
    exit 1
fi

if [ ! -d "${PATH_TO_INSTALL}" ]
then
    echo >&2 "${PATH_TO_INSTALL}: is not a directory"
    exit 2
fi

if [ -n "$(ls ${PATH_TO_INSTALL})" ]
then
    echo >&2 "${PATH_TO_INSTALL}: is not empty"
    exit 3
fi

cp -a $(dirname $0)/src/* ${PATH_TO_INSTALL}
