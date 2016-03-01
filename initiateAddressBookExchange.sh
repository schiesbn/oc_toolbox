#!/bin/bash
#
# Preparation:
# ------------
#
# 1. setup two ownClouds
# 2. enable the 'Federation' app on both ownClouds
# 3. configure the cron jobs to use the system's cron service
# 4. configure the trusted servers
# 5. run this script

cd ~/src/owncloud/server

echo "Authenticate servers...";

sudo -u www-data php master/cron.php
sudo -u www-data php federation/cron.php
sudo -u www-data php master/cron.php
sudo -u www-data php federation/cron.php

echo "Create system address books...";

sudo -u www-data ./master/occ dav:sync-system-addressbook
sudo -u www-data ./federation/occ dav:sync-system-addressbook

echo "Sync system address books...";

sudo -u www-data  ./master/occ federation:sync-addressbooks
sudo -u www-data  ./federation/occ federation:sync-addressbooks
