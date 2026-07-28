cmake_minimum_required(VERSION 3.16)

project(Home3d VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Quick3D Sql WebSockets)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appHome3d
    main.cpp
)

qt_add_qml_module(appHome3d
    URI Home3d
    QML_FILES
        Main.qml
        Main3dScene.qml
        exterior/Exterior.qml
        interior/Interior.qml
        ThermostatTintOverlay.qml
        exterior/ExteriorDoors.qml
    RESOURCES
        day1.webp
        gplus.webp
    SOURCES
        ffmpegstreamer.h ffmpegstreamer.cpp
        devicereceiver.h devicereceiver.cpp
        SOURCES
        SOURCES databasemanager.h databasemanager.cpp
        QML_FILES SmartLight.qml
        QML_FILES Blower.qml
)

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/interior DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/exterior DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

set_target_properties(appHome3d PROPERTIES

    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appHome3d
    PRIVATE Qt6::Quick Qt6::Quick3D Qt6::Sql Qt6::WebSockets
)

include(GNUInstallDirs)
install(TARGETS appHome3d
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Install assets when deploying
install(DIRECTORY interior exterior DESTINATION ${CMAKE_INSTALL_BINDIR})
