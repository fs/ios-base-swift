#!/bin/sh
#  mogen.sh
#
#  Created by Jean-Denis Muys on 24/02/11.
#  Modified by Ryan Rounkles on 15/5/11 to use correct model version and to account for spaces in file paths
#  Modified by Vyacheslav Artemev on 7/12/11 to use separate folders for machine and human
#  Modyfied by Danis Ziganshin on 14.02.14 for ARC compability

#  Check paths for generated files first! It can be different for every project
#  If something wrong with paths on your machine - use absolute path for mogenerator script
#  for enabling this script you should go to "Project target" -> "Build Rules" -> "Editor" -> "Add build Rule" -> select "Data model files using Script" -> Process = "Data model files" -> add custom script
        #echo "Running mogen"
        #"${SRCROOT}/ios-base/Scripts/mogen.sh"
#  Set Output files = $(DERIVED_FILE_DIR)/${INPUT_FILE_BASE}.mom

mogenerator --swift --model "${INPUT_FILE_PATH}" --machine-dir "${PROJECT_DIR}/Swift-Base/CoreData/Private/" --human-dir "${PROJECT_DIR}/Swift-Base/CoreData/" --template-var arc=true

${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.6 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.mom"

echo "Mogen.sh is done"
