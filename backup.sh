#! /bin/zsh

# SYNOPSIS: backup ARCHIVE_NAME LOCATION_TO_ARCHIVE [ARCHIVE_LOCATION]
# Backing up a directory
# create a backup file with timestamp
# to give the backup file a context
# archive file name : languages_ddmmyyy_HHMM.tar.gz
#
# Missing Features:
# backup a file

#  parameters passed
ARCHIVE_NAME=$1
LOCATION_TO_ARCHIVE=$2
ARCHIVE_LOCATION=$3

# setting default archive location
if [ ! $ARCHIVE_LOCATION ]
then
  ARCHIVE_LOCATION=~/.Backup
fi

# check if location to archive is a valid directory
if [ ! -d $LOCATION_TO_ARCHIVE ]
then
  echo "$LOCATION_TO_ARCHIVE : not found "
  exit 1;
fi

# check if archive location is a valid directory
if [ ! -d $ARCHIVE_LOCATION ]
then
  echo "$ARCHIVE_LOCATION : not found "
  exit 1;
fi

# adding timestamp to archive name
TIMESTAMP=$(date "+%d%m%Y_%H%M")
ARCHIVE=$ARCHIVE_NAME\_$TIMESTAMP.tar.gz

tar cfz $ARCHIVE_LOCATION/$ARCHIVE -C $LOCATION_TO_ARCHIVE . 

exit 0;
