import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Material 2.1


ApplicationWindow {
    visible: true
    width: 350
    height: 480
    title: qsTr("اوز تاکسی")
    id: appWindow
    font.family: "Aria"

//    property string count_car: text11.text

    MessageDialog {
        id: verMessage
        title: "ورژن جدید!"
        text: "لطفا ورژن جدید را از کانال رسمی ما دانلود کنید."
        onAccepted: {
            Qt.openUrlExternally("http://t.me/msf_payload");
        }
    }


    signal submitTextField(string txt)
    signal submitTextField2(string text)
    signal submitTextField3(string txt)

    // this function is our QML slot
    function setTextField(text){
        console.log("setTextField: " + text)
        text1.text = text
    }

    function setTextField2(text){
        console.log("setTextField: " + text)
        text2.text = text
    }

    function setTextField3(text){
        console.log("setTextField: " + text)
        text3.text = text
    }

    Component.onCompleted: {
        var doc = new XMLHttpRequest();

        doc.onreadystatechange = function() {
         if (doc.readyState == XMLHttpRequest.DONE) {
            // otput response of request
            console.log(doc.responseText);

            text1.text = doc.responseText;
         }
        }
        doc.open("GET", "http://localhost:1234/count?=");
        doc.send();

        //status
        var status = new XMLHttpRequest();

        status.onreadystatechange = function() {
            if (status.readyState == XMLHttpRequest.DONE) {
                console.log(status.responseText);
                text3.text = status.responseText;
            }
        }
        status.open("GET", "http://localhost:1234/status?=");
        status.send();

        //price taxi
        var price = new XMLHttpRequest();

        price.onreadystatechange = function() {
            if (price.readyState == XMLHttpRequest.DONE)
            {
                console.log(price.responseText);
                text2.text = price.responseText;
            }
        }
        price.open("GET", "http://localhost:1234/price_taxi?=");
        price.send();

        //checking version
        var version = new XMLHttpRequest();

        var vs = "0.1";

        version.onreadystatechange = function() {
            if (version.readyState == XMLHttpRequest.DONE)
            {
                console.log("App Version : " + version.responseText);
                if (vs == version.responseText)
                {
                    console.log("have a last version");
                }
                else
                {
                    verMessage.open();
                }
            }
        }
        version.open("GET", "http://localhost:1234/get_version?=");
        version.send();
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        MessageDialog {
            id: messageDialog
            title: "عملیات با موفقیت انجام شد!"
            text: "سفارش شما ثبت شد!لطفا در صورت دیر کرد یا مشکل با تاکسی تماس بگیرید."
            onAccepted: {
                console.log("sho message box")
            }
//            Component.onCompleted: visible = true
        }

        MessageDialog {
            id: errorMessage
            title: "خطا!"
            text: "لطفا تمام قسمت ها را پر کنید!"
        }

        Page1 {
            Label {
                id: label
                x: 155
                y: 239
                width: 187
                height: 21
                text: "تعداد ماشین های موجود"
            }

            Text {
                id: text1
                x: 33
                y: 238
                width: 79
                height: 24
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
                color: "#F44336"
            }

            Label {
                id: label1
                x: 155
                y: 298
                width: 187
                height: 21
                text: "نرخ هزینه در سطح شهر"
            }

            Text {
                id: text2
                x: 33
                y: 297
                width: 79
                height: 24
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#F44336"
            }

            Label {
                id: label2
                x: 155
                y: 363
                width: 187
                height: 21
                text: "وضعیت"
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text3
                x: 33
                y: 362
                width: 79
                height: 24
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#F44336"
            }

            Image {
                id: image
                x: 33
                y: 25
                width: 284
                height: 104
                fillMode: Image.PreserveAspectCrop
                source: "qrc:/Image/image/taxi_logos_PNG17.png"
            }
        }

        GetTaxiForm{
            Text {
                id: text11
                x: 186
                y: 95
                width: 149
                height: 20
                color: "#ffc107"
                text: qsTr("نام و نام خانوادگی ")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
            }

            Text {
                id: text22
                x: 114
                y: 33
                width: 122
                height: 36
                color: "#f40f0f"
                text: qsTr("سفارش تاکسی")
                font.bold: true
                font.family: "Tahoma"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 16
            }

            Text {
                id: text33
                x: 190
                y: 159
                width: 154
                height: 20
                color: "#ffc107"
                text: qsTr("تعداد ماشین درخواستی")
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text44
                x: 205
                y: 221
                width: 112
                height: 20
                color: "#ffc107"
                text: qsTr("شماره تماس")
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text55
                x: 186
                y: 281
                width: 150
                height: 20
                color: "#ffc107"
                text: qsTr("آدرس دقیق")
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                id: button
                x: 125
                y: 357
                text: qsTr("تایید سفارش")

                highlighted: true
                Material.accent: Material.color("#FF9800")

                onClicked: {
                    var get_taxi = new XMLHttpRequest();

                    get_taxi.onreadystatechange = function() {
                        if (get_taxi.readyState == XMLHttpRequest.DONE)
                        {
                            console.log(get_taxi.responseText);
                            messageDialog.open();
                        }
                    }

                    get_taxi.open("POST", "http://localhost:1234/get_taxi");
                    var param = 'name=' + textField.text + '&count=' + textField1.text + '&num=' + textField2.text + "&location=" + textField3.text;
                    get_taxi.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    if (textField.text == "" || textField1.text == "" || textField2.text == "" || textField3.text == "")
                    {
                        errorMessage.open();
                    }
                    else
                    {
                        get_taxi.send(param);
                    }
                }
            }

            TextField {
                id: textField
                x: 19
                y: 85
                width: 166
                height: 50
            }

            TextField {
                id: textField1
                x: 19
                y: 149
                width: 166
                height: 50
            }

            TextField {
                id: textField2
                x: 19
                y: 211
                width: 166
                height: 50
            }

            TextField {
                id: textField3
                x: 19
                y: 271
                width: 166
                height: 50
            }
        }

        Page1Form{
            Rectangle {
                id: rectangle111
                x: 36
                y: 60
                width: 278
                height: 181
                color: "#1a1817"

                border.color: "black"

                TextEdit {
                    id: textEdit1
                    x: 0
                    y: 0
                    width: rectangle111.width
                    height: rectangle111.height
                    color: "#ffc107"
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 12
                }
            }

            Label {
                id: label111
                x: 203
                y: 33
                width: 111
                height: 21
                text: qsTr("متن پیام شما ")
            }

            MessageDialog {
                id: aboutMessage
                title: "درباره ما"
                text: "سازنده : شایان زارع \n ای دی تلگرام سازنده : @Msf_Payload \n ایمیل سازنده : virus007@protonmail.com";
            }

            Button {
                id: button111
                x: 63
                y: 363
                text: qsTr("درباره ما")
                highlighted: true
        //        Material.accent: Material.color("#FF9800")
                onClicked: {
                    aboutMessage.open();
                }
            }

            Button {
                id: button222
                x: 208
                y: 363
                text: qsTr("ارسال پیام")
                highlighted: true
        //        Material.accent: Material.color("#FF9800")

                onClicked: {
                    var msg = new XMLHttpRequest();

                    msg.onreadystatechange = function() {
                        if (msg.readyState == XMLHttpRequest.DONE)
                        {
                            console.log(msg.responseText);
                            messageDialog.open();
                        }
                    }

                    msg.open("POST", "http://localhost:1234/message");
                    var param = 'name=' + textInput333.text + '&num=' + textInput334.text + '&msg=' + textEdit1.text;
                    msg.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    if (textInput333.text == "" || textInput334.text == "" || textEdit1.text == "")
                    {
                        errorMessage.open();
                    }
                    else
                    {
                        msg.send(param);
                    }

                }
            }
            Label {
                id: label333
                x: 280
                y: 263
                text: qsTr("نام ")
            }

            Label {
                id: label334
                x: 229
                y: 303
                text: qsTr("شماره تماس")
            }

            TextField {
                id: textInput333
                x: 36
                y: 255
                width: 166
                height: 50
                font.pixelSize: 12
            }

            TextField {
                id: textInput334
                x: 36
                y: 294
                width: 166
                height: 50
                font.pixelSize: 12
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("صفحه اصلی")
        }
        TabButton {
            text: qsTr("سفارش")
        }
        TabButton {
            text: qsTr("تماس با ما")
        }
    }
}
