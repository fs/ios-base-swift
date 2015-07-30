#!/bin/sh
xcodebuild -workspace Swift-Base.xcworkspace -scheme Staging -destination 'platform=iOS Simulator,name=iPhone 6,OS=8.1' test | xcpretty -c -t && exit ${PIPESTATUS[0]}

#Available destinations for the "Staging" scheme:
#{ platform:iOS Simulator, id:9D4669A0-72AF-41A9-AB8A-14914D7A502F, OS:8.2, name:iPad 2 }
#{ platform:iOS Simulator, id:D1F3629A-4698-4DF4-813B-16E944D958C6, OS:8.2, name:iPad Air }
#{ platform:iOS Simulator, id:F16D6604-4C3C-46CF-B268-904093D42D28, OS:8.2, name:iPad Retina }
#{ platform:iOS Simulator, id:83BEC35E-D369-4CF5-BDB8-DB76DC1F1F1A, OS:8.2, name:iPhone 4s }
#{ platform:iOS Simulator, id:45F13142-6870-4DF5-AA02-DC5AB4549EDD, OS:8.2, name:iPhone 5 }
#{ platform:iOS Simulator, id:3A52861B-7E7A-43E8-9026-DFF899543071, OS:8.2, name:iPhone 5s }
#{ platform:iOS Simulator, id:2A8A340C-42BF-4045-B008-3868F8E082BA, OS:8.2, name:iPhone 6 Plus }
#{ platform:iOS Simulator, id:F651D749-67FD-4093-A9AE-C386E3858632, OS:8.2, name:iPhone 6 }
#{ platform:iOS Simulator, id:DB1FB84A-7F74-4042-B0E3-01B05B730FE7, OS:8.2, name:Resizable iPad }
#{ platform:iOS Simulator, id:90301A80-5A1B-4C4F-9433-D31A113FE314, OS:8.2, name:Resizable iPhone }
