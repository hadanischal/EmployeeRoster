#!/bin/sh

# Define output file. Change "$PROJECT_DIR/Tests" to your test's root source folder, if it's not the default name.
PROJECT_DIR="."
PROJECT_NAME="EmployeeRoster"
PROJECT_NAME_TESTS="EmployeeRosterTests"
PODS_ROOT="$PROJECT_DIR/Pods"
OUTPUT_FILE="$PROJECT_DIR/${PROJECT_NAME_TESTS}/GeneratedMocks.swift"
echo "Generated Mocks File = $OUTPUT_FILE"

# Define input directory. Change "$PROJECT_DIR" to your project's root source folder, if it's not the default name.
INPUT_DIR="$PROJECT_DIR/${PROJECT_NAME}"
echo "Mocks Input Directory = $INPUT_DIR"

# Generate mock files, include as many input files as you'd like to create mocks for.
${PODS_ROOT}/Cuckoo/run generate --testable "${PROJECT_NAME}" \
--output "${OUTPUT_FILE}" \
"$INPUT_DIR/Service/WebService/WebServiceProtocol.swift" \
"$INPUT_DIR/Service/WebService/WebService.swift" \
"$INPUT_DIR/Service/ApiHandler/GetEmployeeInfoHandlerProtocol.swift" \
"$INPUT_DIR/Service/ApiHandler/GetEmployeeInfoHandler.swift" \
"$INPUT_DIR/ViewModel/EmployeeViewModelProtocol.swift" \
"$INPUT_DIR/ViewModel/EmployeeListModel.swift" \
# ... and so forth
