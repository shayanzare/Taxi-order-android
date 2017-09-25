#include "handletextfield.h"
#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

/*
 * This class handles interactions with the text field
 */
HandleTextField::HandleTextField(QObject *parent) :
    QObject(parent)
{
}

void HandleTextField::handleSubmitTextField(const QString &in)
{
    QEventLoop eventLoop;
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));
    QNetworkRequest req( QUrl("http://localhost:1234/count?="));   //DON'T FORGET TO CHANGE
    QNetworkReply *reply = mgr.get(req);
    eventLoop.exec();

    QEventLoop eventLoop2;
    QNetworkAccessManager mgr2;
    QObject::connect(&mgr2, SIGNAL(finished(QNetworkReply*)), &eventLoop2, SLOT(quit()));
    QNetworkRequest req2( QUrl("http://localhost:1234/status?="));   //DON'T FORGET TO CHANGE
    QNetworkReply *reply2 = mgr2.get(req2);
    eventLoop2.exec();

    QEventLoop eventLoop3;
    QNetworkAccessManager mgr3;
    QObject::connect(&mgr3, SIGNAL(finished(QNetworkReply*)), &eventLoop3, SLOT(quit()));
    QNetworkRequest req3( QUrl("http://localhost:1234/price_taxi?="));   //DON'T FORGET TO CHANGE
    QNetworkReply *reply3 = mgr3.get(req3);
    eventLoop3.exec();

    emit setTextField(reply->readAll());
    emit setTextField2(reply2->readAll());
    emit setTextField3(reply3->readAll());
}
