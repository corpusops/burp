#!/usr/bin/env bash
set -ex
cd "$(dirname $0)/.."
export W="${PWD}"
export GPG_AGENT_INFO=${GPG_AGENT_INFO:-${HOME}/.gnupg/S.gpg-agent:0:1}
export PACKAGE="burp"
export PPA="${PACKAGE}"
export DEBEMAIL=${DEBEMAIL:-kiorky@cryptelium.net}
export KEY="${KEY:-0x5616F8C2}"
export VER=${VER:-"$(grep "#define NGINX_VERSION" src/core/nginx.h 2>/dev/null|awk '{print $3}'|sed 's/"//g')"}
export VER="2.3.16"
export FLAVORS="vivid trusty precise"
export FLAVORS="trusty xenial bionic disco"
export RELEASES="${RELEASES:-"experimental|stable|unstable|precise|trusty|utopic|vivid|oneric|wily|xenial|artful|bionic|cosmic|disco"}"
if [ -e "${W}/mc_packaging/debian/" ];then
    rsync -av "${W}/mc_packaging/debian/" "${W}/debian/"
fi
#
# CUSTOM MERGE CODE HERE
cd "${W}"
cd debian
echo "3.0 (native)">"${W}/debian/source/format"
cd "${W}"
CHANGES=""
if [ -e $HOME/.gnupg/.gpg-agent-info ];then . $HOME/.gnupg/.gpg-agent-info;fi
# make a release for each flavor
logfile=$W/../log
if [ -e "${logfile}" ];then rm -f "${logfile}";fi
if [ -e "${logfile}.pipe" ];then rm -f "${logfile}.pipe";fi
mkfifo "${logfile}.pipe"
tee < "${logfile}.pipe" "$logfile" &
exec 1> "${logfile}.pipe" 2> "${logfile}.pipe"
for i in $FLAVORS;do
    sed  -i -re "1 s/${PACKAGE} \([0-9]+.[0-9]+.[0-9]+(-(${RELEASES}))?([^)]*\).*)((${RELEASES});)(.*)/${PACKAGE} (${VER}-${i}\3${i};\6/g" debian/changelog
    dch -i -D "${i}" "packaging for ${i}"
    debuild -k${KEY} -S -sa --lintian-opts -i
done
exec 1>&1 2>&2
rm "${logfile}.pipe"
CHANGES=$(egrep "signfile.* dsc " $logfile|awk '{print $3}'|sed -re "s/\.dsc$/_source.changes/g" )
# upload to final PPA
cd "${W}/.."
for i in ${CHANGES};do
    dput "${PPA}" $i
done
# vim:set et sts=4 ts=4 tw=0:
