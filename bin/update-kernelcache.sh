#!/bin/sh

sudo touch /Library/Extensions
sudo touch /System/Library/Extensions

sudo kextcache -update-volume /
