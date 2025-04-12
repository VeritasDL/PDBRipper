QT += core gui widgets

CONFIG += c++17
CONFIG -= app_bundle

TEMPLATE = app
TARGET = pdbripper

SOURCES += \
    ../qwinpdb.cpp \
    ../pdbprocess.cpp \
    dialogabout.cpp \
    dialogexport.cpp \
    dialogoptions.cpp \
    dialogprocess.cpp \
    guimainwindow.cpp \
    main_gui.cpp \
    ../msdia/diaCreate.cpp

HEADERS += \
    ../global.h \
    ../qwinpdb.h \
    ../qwinpdb_def.h \
    ../pdbprocess.h \
    dialogabout.h \
    dialogexport.h \
    dialogoptions.h \
    dialogprocess.h \
    guimainwindow.h

FORMS += \
    dialogabout.ui \
    dialogexport.ui \
    dialogoptions.ui \
    dialogprocess.ui \
    guimainwindow.ui

RESOURCES += \
    resources.qrc

RC_ICONS = ../icons/main.ico

INCLUDEPATH += ../msdia

# Submodules
!contains(XCONFIG, xoptionswidget) {
    XCONFIG += xoptionswidget
    include(../XOptions/xoptionswidget.pri)
}

!contains(XCONFIG, xwinpdb) {
    XCONFIG += xwinpdb
    include(../XWinPDB/xwinpdb.pri)
}

!contains(XCONFIG, xaboutwidget) {
    XCONFIG += xaboutwidget
    include(../XAboutWidget/xaboutwidget.pri)
}

include(../build.pri)
