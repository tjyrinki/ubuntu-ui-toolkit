TEMPLATE = app
LIBS += -llttng-ust -ldl
CONFIG += -I.
QMAKE_CXXFLAGS += -Werror
HEADERS += app-launch-tracepoints.h
SOURCES += app-launch-tracepoints.c
TARGET = app-launch-tracepoints
installPath = $$[QT_INSTALL_PREFIX]/bin/
app-launch-tracepoints.path = $$installPath
app-launch-tracepoints.files = app-launch-tracepoints
app-launch-scripts.path = $$installPath
app-launch-scripts.files = app-launch-profiler-lttng \
                           profile_appstart.sh \
                           appstart_test
INSTALLS += app-launch-tracepoints
INSTALLS += app-launch-scripts


