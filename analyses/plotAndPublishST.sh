#! /usr/bin/bash

##########################
# Configuration parameters
##########################

UTILS_FOLDER="./plotAndPublish/"
PUBLUSH_FOLDER="/eos/project/c/cmsweb/www/MUON/dpgdt/sx5/Results/SliceTest"
# PUBLUSH_FOLDER="/eos/user/b/battilan/www/DTDPG/SliceTest/"

PLOTTER_CFGS=("configDigiST.json" "configTriggerST.json" "configSegmentST.json" "configSegmentPh1vsPh2ST.json")
PLOTTER_ROOTS=("results_digi.root" "results_trigger.root" "results_segment.root" "results_segment.root")
PLOTTER_FOLDERS_IN=("digi/" "trigger/" "segment/" "segment/")
PLOTTER_FOLDERS_OUT=("digi/" "trigger/" "segment/" "segment/ph1_vs_ph2/")

PLOTTER_CMD="plotter.py"
PUBLISH_CMD="publishDir.py"

INDEX_FILE="index.php"


##########################
# Commands
##########################

if [ "$#" -ne 1 ]; then
    echo "Usage : $0 PATH_TO_RUN_RESULTS_FILE"
    exit 999
fi

RUN_FOLDER=$1

for index in ${!PLOTTER_CFGS[*]}
do :
    python $UTILS_FOLDER/$PLOTTER_CMD $UTILS_FOLDER/${PLOTTER_CFGS[$index]} $RUN_FOLDER/${PLOTTER_FOLDERS_IN[$index]}/${PLOTTER_ROOTS[$index]} $RUN_FOLDER/${PLOTTER_FOLDERS_OUT[$index]}
done

python $UTILS_FOLDER/$PUBLISH_CMD $RUN_FOLDER $UTILS_FOLDER/$INDEX_FILE

# scp -r $RUN_FOLDER dtdqm@lxplus:$PUBLUSH_FOLDER
cp -r $RUN_FOLDER $PUBLUSH_FOLDER
