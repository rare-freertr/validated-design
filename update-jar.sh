#!/bin/bash
wget -O rtr.jar src.freertr.org/src/rtr.jar
git add .
git commit -m "updating jar"
git push
