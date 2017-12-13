#include "pumpcontroller.h"
#include <QDebug>
#include <QElapsedTimer>

PumpController::PumpController(QObject *parent)
    : QObject(parent)
{
    timer = new QElapsedTimer();

    qDebug() << Q_FUNC_INFO << ": Instantiated pump controller";
}

PumpController::~PumpController()
{

}

void PumpController::startPump(int n)
{
    qDebug() <<  Q_FUNC_INFO << ": Start pump " << n;

    timer->start();
}

void PumpController::stopPump(int n)
{
    qDebug() <<  Q_FUNC_INFO << ": Stop pump " << n;

    emit duration(timer->elapsed());
}

void PumpController::setCalibrationValue(int n, int val)
{
    qDebug() <<  Q_FUNC_INFO << ": Set new calibration value for pump " << n << " to " << val;
}

void PumpController::dispense(int n, int vol)
{
    qDebug() <<  Q_FUNC_INFO << ": Dispense " << vol << " cl on pump " << n;

    emit done(n, true);
}
