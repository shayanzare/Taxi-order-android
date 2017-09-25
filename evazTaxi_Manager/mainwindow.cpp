#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDebug>
#include <QFile>
#include <QTextStream>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QString>
#include <QEventLoop>
#include <QByteArray>
#include <QVariant>
#include <QThread>
#include <QSysInfo>


#define until(x)    while(!(x))
#define unless(x)   if(!(x))


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    //get count of car
    QEventLoop eventLoop;
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QUrl url("http://localhost:1234/count?=");
    QNetworkRequest req(url);
    QNetworkReply *reply = mgr.get(req);

    eventLoop.exec();


    QEventLoop eventLoop2;
    QNetworkAccessManager mgr2;
    QObject::connect(&mgr2, SIGNAL(finished(QNetworkReply*)), &eventLoop2, SLOT(quit()));

    QUrl url2("http://localhost:1234/price_taxi?=");
    QNetworkRequest req2(url2);
    QNetworkReply *reply2 = mgr2.get(req2);

    eventLoop2.exec();

    QEventLoop eventLoop3;
    QNetworkAccessManager mgr3;
    QObject::connect(&mgr3, SIGNAL(finished(QNetworkReply*)), &eventLoop3, SLOT(quit()));

    QUrl url3("http://localhost:1234/status?=");
    QNetworkRequest req3(url3);
    QNetworkReply *reply3 = mgr3.get(req3);

    eventLoop3.exec();

    QString rep2 = reply2->readAll();
    ui->textEdit_4->setText(rep2);
    qDebug() << "Price Taxi : " << rep2;

    QString rep1 = reply->readAll();
    qDebug() << "Count of Car : " << rep1;
    ui->textEdit_5->setText(rep1);

    QString rep3 = reply3->readAll();
    qDebug() << "Status : " << rep3;
    ui->textEdit_3->setText(rep3);

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    while (true) {

        //get message
        QEventLoop eventLoop;
        QNetworkAccessManager mgr;
        QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

        QUrl url("http://localhost:1234/get_message?=");
        QNetworkRequest req(url);
        QNetworkReply *reply = mgr.get(req);

        eventLoop.exec();

        //get taxi
        QEventLoop eventLoop2;
        QNetworkAccessManager mgr2;
        QObject::connect(&mgr2, SIGNAL(finished(QNetworkReply*)), &eventLoop2, SLOT(quit()));

        QUrl url2("http://localhost:1234/get_taxi?=");
        QNetworkRequest req2(url2);
        QNetworkReply *reply2 = mgr2.get(req2);

        eventLoop2.exec();

        //set output
        ui->textEdit->setText(reply2->readAll());
        ui->textEdit_2->setText(reply->readAll());

//        qDebug() << "OS name : " << QSysInfo::productType();

//        unless (reply2->readAll() == ui->textEdit->toPlainText())
//        {
//            system("notify-send 'سفارش جدید' 'سفارشی جدیدی ثبت شده است!' '-t' 5000");
//        }

        if (reply2->readAll() == ui->textEdit->toPlainText()) {

        }
        else{
            system("notify-send 'سفارش جدید' 'سفارشی جدیدی ثبت شده است!' '-t' 5000");
        }


        //set thread sleeps
        QThread::sleep(5);
    }
}

void MainWindow::on_pushButton_2_clicked()
{
    //setting status

    QEventLoop eventLoop;
    QNetworkAccessManager manager;

    QUrl url("http://localhost:1234/setting_status");

    QNetworkRequest request(url);

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QNetworkReply *reply = manager.post(request, "sStatus=" + ui->textEdit_3->toPlainText().toUtf8());

    eventLoop.exec();

    //setting count

    QEventLoop eventLoop2;
    QNetworkAccessManager manager2;

    QUrl url2("http://localhost:1234/setting_count");

    QNetworkRequest request2(url2);

    request2.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QObject::connect(&manager2, SIGNAL(finished(QNetworkReply*)), &eventLoop2, SLOT(quit()));

    QNetworkReply *reply2 = manager2.post(request2, "sCount=" + ui->textEdit_5->toPlainText().toUtf8());

    eventLoop2.exec();

    //setting price

    QEventLoop eventLoop3;
    QNetworkAccessManager manager3;

    QUrl url3("http://localhost:1234/setting_price");

    QNetworkRequest request3(url3);

    request3.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventLoop3, SLOT(quit()));

    QNetworkReply *reply3 = manager3.post(request3, "sPrice=" + ui->textEdit_4->toPlainText().toUtf8());

    eventLoop3.exec();
}
