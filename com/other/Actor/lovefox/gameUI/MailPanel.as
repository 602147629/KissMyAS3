package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class MailPanel extends Window
    {
        public var sendpanel:MailSend;
        public var getmailpanel:MailList;
        private var mainpanel:Sprite;
        private var topbar:ButtonBar;
        private var tabcanvas:TabNavigatorUI;
        private var mailtime:Timer;
        private var timeNum:int = 0;

        public function MailPanel(param1)
        {
            super(param1);
            this.initDraw();
            this.initpanel();
            return;
        }// end function

        private function initDraw() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RECEIVE_MASS_MAIL, this.receiveMail);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RECEIVE_NEW_MAIL, this.getmailmes);
            this.addEventListener(MailEvent.TO_MAIL, this.tomailpanel);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = null;
            resize(400, 300);
            title = Config.language("MailPanel", 1);
            _loc_1 = new Shape();
            _loc_1.x = 5;
            _loc_1.y = 265;
            _loc_1.graphics.beginFill(Style.WINDOW_OVERCOLOR, 0.5);
            _loc_1.graphics.drawRoundRect(0, 0, 390, 30, 5);
            _loc_1.graphics.endFill();
            this.addChild(_loc_1);
            this.topbar = new ButtonBar(this, 15, 25);
            this.topbar.addTab(Config.language("MailPanel", 2), Config.create(this.getmailshow, 0));
            this.topbar.addTab(Config.language("MailPanel", 3), Config.create(this.getmailshow, 1));
            this.topbar.addTab(Config.language("MailPanel", 4), this.sendmailshow);
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this.mainpanel.x = 10;
            this.mainpanel.y = 45;
            this.sendpanel = new MailSend();
            this.getmailpanel = new MailList();
            this.mailtime = new Timer(1000);
            this.mailtime.addEventListener(TimerEvent.TIMER, this.changeMailTime);
            return;
        }// end function

        public function sendmailshow(event:MouseEvent = null, param2:String = "") : void
        {
            this.topbar.selectpage = 2;
            this.removeallchild(this.mainpanel);
            this.mainpanel.addChild(this.sendpanel);
            this.sendpanel.refreshFriends();
            this.sendpanel.settomail(param2);
            dispatchEvent(new ObEvent("page:2"));
            return;
        }// end function

        public function getmailshow(event:MouseEvent = null, param2:int = 0) : void
        {
            this.removeallchild(this.mainpanel);
            this.mainpanel.addChild(this.getmailpanel);
            this.getmailpanel.sendmailliet(param2);
            this.topbar.selectpage = param2;
            dispatchEvent(new ObEvent("page:" + param2));
            return;
        }// end function

        public function showsend(param1:String, param2:String = "") : void
        {
            this.removeallchild(this.mainpanel);
            var _loc_3:* = new Label(this.mainpanel, 30, 80, param1);
            var _loc_4:* = new PushButton(this.mainpanel, 80, 220, Config.language("MailPanel", 5), this.getmailshow);
            new PushButton(this.mainpanel, 80, 220, Config.language("MailPanel", 5), this.getmailshow).width = 80;
            var _loc_5:* = new PushButton(this.mainpanel, 190, 220, Config.language("MailPanel", 6), Config.create(this.sendmailshow, param2));
            new PushButton(this.mainpanel, 190, 220, Config.language("MailPanel", 6), Config.create(this.sendmailshow, param2)).width = 80;
            return;
        }// end function

        private function tomailpanel(event:MailEvent) : void
        {
            this.topbar.selectpage = 2;
            this.sendmailshow();
            this.sendpanel.settomail(event.data.tomailname);
            this.sendpanel.setmailTitle(event.data.mailTitle);
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            if (this.parent != null)
            {
                this.topbar.selectpage = 0;
                this.getmailshow();
            }
            return;
        }// end function

        override public function close()
        {
            super.close();
            this.sendpanel.itemunlock();
            this.removeallchild(this.mainpanel);
            return;
        }// end function

        public function getRequest(param1:int) : void
        {
            if (this.sendpanel != null)
            {
                if (this.sendpanel.parent != null)
                {
                    this.sendpanel.getrequest(param1);
                }
            }
            return;
        }// end function

        public function sendItemBack(param1) : void
        {
            if (param1 == 0)
            {
                if (this.getmailpanel != null)
                {
                    if (this.getmailpanel.parent != null)
                    {
                        this.getmailpanel.sendItemBack();
                    }
                }
            }
            return;
        }// end function

        private function getmailmes(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = new Object();
            new Object().type = 4;
            _loc_4.fname = "mail";
            _loc_4.status = _loc_3;
            ListTip.addList(_loc_4);
            Config.ui._radar.setmail(true);
            if (_loc_3 == 3)
            {
                trace("系统带附件邮件");
                GuideUI.testDoId(230, Config.ui._radar._mailBtn, this);
            }
            return;
        }// end function

        override public function testGuide()
        {
            GuideUI.testDoId(231, this.topbar.tabarr[1]);
            return;
        }// end function

        public function openMail(param1:int) : void
        {
            if (param1 == 0)
            {
                this.getmailshow();
                Config.message(Config.language("MailPanel", 7));
            }
            else if (param1 == 1)
            {
                this.getmailshow();
            }
            else if (param1 == 2 || param1 == 3)
            {
                this.getmailshow(null, 1);
            }
            open();
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        public function receiveMail(event:SocketEvent) : void
        {
            this.timeNum = int(Math.random() * 600);
            this.mailtime.start();
            return;
        }// end function

        private function changeMailTime(event:TimerEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.timeNum - 1;
            _loc_2.timeNum = _loc_3;
            if (this.timeNum < 0)
            {
                this.mailtime.stop();
                this.sendMailTip();
            }
            return;
        }// end function

        private function sendMailTip() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_QUERY_MASS_MAIL);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        override protected function doOb(param1:Array) : Boolean
        {
            if (super.doOb(param1))
            {
                return true;
            }
            switch(param1[0])
            {
                case "page":
                {
                    if (int(param1[1]) < 2)
                    {
                        this.getmailshow(null, int(param1[1]));
                    }
                    else
                    {
                        this.sendmailshow();
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

    }
}
