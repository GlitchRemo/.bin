#! /bin/zsh

# SYNOPSIS : restore.sh SOURCE_PATH DESTINATION_PATH
# Restore specified archives from backup directory to restore directory
# Default restore location : present working directory
# Archive format : Archivename_Timestamp.tar.gz
#
# restore will create a restore directory named Archivename_Timestamp in specified restore location 
# and restore contents of specified archive in that directory
#
# TO DO:
# check if restore location is valid or not
# check if restore directory already exists in restore location

# parameters passed
ARCHIVE_PATH=$1
RESTORE_LOCATION=$2
# TIMESTAMP=23022023_1136

# extract restore directory name from archive name
RESTORE_DIRECTORY_NAME=$(echo $ARCHIVE_PATH |  sed "s#.*/\([^/]*\).tar.gz#\1#")

# Set default restore location
if [ ! $RESTORE_LOCATION ]
then
 RESTORE_LOCATION=$PWD
fi

# making restore directory in restore location
mkdir $RESTORE_LOCATION/$RESTORE_DIRECTORY_NAME
#mkdir ~/restore

# Extracting archives 
tar xfz $ARCHIVE_PATH -C $RESTORE_LOCATION/$RESTORE_DIRECTORY_NAME 
