#!/bin/bash

# Copyright (C) 2015-2017  Unreal Arena
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Travis CI support script


################################################################################
# Setup
################################################################################

# Arguments parsing
if [ $# -ne 1 ]; then
	echo "Usage: ${0} <STEP>"
	exit 1
fi


################################################################################
# Routines
################################################################################

# before_install
before_install() {
	sudo apt-get -qq update
}

# install
install() {
	true
}

# before_script
before_script() {
	true
}

# script
script() {
	git diff --name-only\
	         --diff-filter=d\
	         "$(git describe --abbrev=0 HEAD^ | cut -d- -f1)" | fgrep -v -e .gitattributes\
	                                                                     -e .travis.sh\
	                                                                     -e .travis.yml\
	                                                                     -e README.md | zip -9 unrealarena-data.pre.zip -@
}

# before_deploy
before_deploy() {
	true
}


################################################################################
# Main
################################################################################

# Arguments check
if ! `declare -f "${1}" > /dev/null`; then
	echo "Error: unknown step \"${1}\""
	exit 1
fi

# Enable exit on error & display of executing commands
set -ex

# Run <STEP>
${1}
