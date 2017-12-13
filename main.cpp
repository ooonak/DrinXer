#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>

#include "pumpcontroller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    PumpController pc;

    QQmlApplicationEngine engine;
    QQmlContext *ctxt = engine.rootContext();

    // Add C++ objects to context so we can access it from qml
    ctxt->setContextProperty("pumpController", &pc);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
