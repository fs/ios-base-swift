#!/bin/sh

mogenerator --swift --model "$PWD/TwiageEMS/CoreData/TwiageEMS.xcdatamodeld" --machine-dir "$PWD/TwiageEMS/CoreData/Private/" --human-dir "$PWD/TwiageEMS/CoreData"

sleep 3