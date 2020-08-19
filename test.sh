xcodebuild \
-workspace EmployeeRoster.xcworkspace \
-scheme EmployeeRoster \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.6' \
test | xcpretty
