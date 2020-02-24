#!/bin/sh

GAME_SETUP=$PWD
CDROM_FILE="[Kk][Ii][Nn][Gg][Pp][Ii][Nn]/data1.cab"
DISC="Disc"
ARCH=`uname -m | sed -e s/i.86/x86/`
UNSHIELD_BINARY=${GAME_SETUP}/setup.data/unshield

if [ -x "${UNSHIELD_BINARY}.${ARCH}" ]
then
	UNSHIELD_BINARY=$UNSHIELD_BINARY.${ARCH}
else
	echo
	echo "ERROR - no suitable unshield binary for: ${ARCH} found" 
	echo

	exit 1
fi

if [ -e $SETUP_CDROMPATH/$CDROM_FILE ]
then
	echo
  	echo "Extracting files from $DISC"
  	echo
	
	$UNSHIELD_BINARY -d ${GAME_SETUP}/data -g "Common Files" -L x ${SETUP_CDROMPATH}/${CDROM_FILE} > /dev/null
        $UNSHIELD_BINARY -d ${GAME_SETUP}/data -g "Mature Files" -L x ${SETUP_CDROMPATH}/${CDROM_FILE} > /dev/null 
        $UNSHIELD_BINARY -d ${GAME_SETUP}/data -g "Program Executable Files" -L x ${SETUP_CDROMPATH}/${CDROM_FILE} > /dev/null
        rm -f ${GAME_SETUP}/data/program_executable_files/main/gamex86.dll
	cd ${GAME_SETUP}/data/common_files/main/models/actors/runt/
	ln -s r_pstl.mdx R_pstl.mdx
	ln -s l_pstl.mdx L_pstl.mdx
	cd ${GAME_SETUP}/data/common_files/main/models/actors/thug/
	ln -s r_pstl.mdx R_pstl.mdx
	ln -s l_pstl.mdx L_pstl.mdx
else
  	echo
  	echo "ERROR - can't extract files from $DISC"
  	echo
  	exit 1
fi
