#!/bin/sh
#  mogend.sh
#
#  Created by Jean-Denis Muys on 24/02/11.
#  Modified by Ryan Rounkles on 15/5/11 to use correct model version and to account for spaces in file paths
#  Modified by Vyacheslav Artemev on 7/12/11 to use separate folders for machine and human
#  Modyfied by Danis Ziganshin on 14.02.14 for ARC compability

#  Check paths for generated files first! It can be different for every project
#  If something wrong with paths on your machine - use absolute path for mogenerator script
#  for enabling this script you should go to "Project target" -> "Build Rules" -> "Editor" -> "Add build Rule" -> select "Data model version files using Script" -> Process = "Data model version files" -> add custom script
        #echo "Running mogend"
        #"${SRCROOT}/ios-base/Scripts/mogend.sh"
#  Set Output files = $(DERIVED_FILE_DIR)/${INPUT_FILE_BASE}.momd

mogenerator --model "${INPUT_FILE_PATH}/" --machine-dir "${PROJECT_DIR}/Swift-Base/" --human-dir "${PROJECT_DIR}/Swift-Base/" --template-var arc=true

${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.7 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.momd"

echo "Mogend.sh is done"