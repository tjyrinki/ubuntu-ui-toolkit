TESTS += $$system(ls tst_*.qml)

include(../qmltest-include.pri)

SOURCES += tst_components.cpp

OTHER_FILES += $$system(ls *.qml) \
    tst_ubuntu_namespace_v13.qml
