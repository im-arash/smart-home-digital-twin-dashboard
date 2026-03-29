cmake_minimum_required(VERSION 3.16)

project(guide VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Sql WebSockets)

qt_standard_project_setup(REQUIRES 6.8)


set_source_files_properties(Style.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_executable(appguide
    main.cpp
)

qt_add_qml_module(appguide
    URI guide
    QML_FILES
        Main.qml
        Style.qml
        resources/components/MainMenu.qml
        resources/components/MaterialIcon.qml
        resources/components/ThermostatDial.qml
        resources/components/MembersWidget.qml
        resources/components/TopMenu.qml
        resources/components/WeatherWidget.qml
        resources/components/LockWidget.qml
        resources/components/EnergyGraphWidget.qml
        resources/components/CCTVWidget.qml

        RESOURCES
        resources/icons/MaterialSymbolsSharp.ttf
        resources/images/members/daughter.webp
        resources/images/members/father.webp
        resources/images/members/son.webp
        resources/images/members/mom.webp
        resources/images/lock.png
        SOURCES
        SOURCES
        SOURCES devicecontroller.h devicecontroller.cpp
        QML_FILES resources/components/DeviceCTRLWidget.qml


)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appguide PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appguide
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appguide
    PRIVATE Qt6::Quick Qt6::Sql Qt6::WebSockets
)

include(GNUInstallDirs)
install(TARGETS appguide
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
