#!/bin/bash

LOG_FILE="/home/addo2/auto_push_dotfiles.log"
PROJECT_DIR="/home/addo2/dev/projects/Addonay"
NEXT_SCRIPT="$PROJECT_DIR/next.sh"

echo "Running auto_push_dotfiles.sh at $(date)" >> $LOG_FILE

cd $PROJECT_DIR || { echo "Failed to change directory to $PROJECT_DIR at $(date)" >> $LOG_FILE; exit 1; }

echo -e "\t" >> $NEXT_SCRIPT

if [[ $(git status --porcelain) ]]; then
  git add . >> $LOG_FILE 2>&1
  git commit -m "Auto-update: $(date '+%Y-%m-%d %H:%M:%S')" >> $LOG_FILE 2>&1

  git push origin main >> $LOG_FILE 2>&1

  echo "Committed and pushed changes at $(date)" >> $LOG_FILE
else
  echo "No changes to commit at $(date)" >> $LOG_FILE
fi

echo "Finished running auto_push_dotfiles.sh at $(date)" >> $LOG_FILE

exit 0
