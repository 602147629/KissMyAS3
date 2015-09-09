package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class VipPanel extends Window
    {
        private var lab:Label;
        private var _day:uint = 86400;
        private var _hour:uint = 3600;
        private var _textday:Label;
        private var buftimer:Timer;
        private var longintime:int;
        private var labRight:Label;

        public function VipPanel(param1:DisplayObjectContainer = null)
        {
            super(param1);
            this.vipanelinit();
            this.initsocket();
            return;
        }// end function

        private function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_USE_VIPCARD_RESULT, this.usevipcard);
            return;
        }// end function

        override public function switchOpen() : void
        {
            var _loc_1:* = undefined;
            super.switchOpen();
            if (_opening)
            {
                _loc_1 = Config.ui._shopmail.lostime - int(Config.now.getTime() / 1000);
                if (_loc_1 > 0)
                {
                    if (_loc_1 < this._day)
                    {
                        this.longintime = Config.ui._shopmail.lostime;
                        this.buftimer.start();
                    }
                    else if (_loc_1 >= this._day)
                    {
                        this._textday.text = Config.language("VipPanel", 1, int(_loc_1 / this._day), int(_loc_1 % this._day / this._hour));
                    }
                }
                if (Config.ui._shopmail.vipLv == 0)
                {
                    this.labRight.text = Config.language("VipPanel", 2);
                    this.lab.text = Config.language("VipPanel", 3, Style.FONT_Gray, 0);
                }
                else
                {
                    this.labRight.text = Config.language("VipPanel", 4);
                    this.lab.text = Config.language("VipPanel", 3, Style.FONT_3_Orange, Config.ui._shopmail.vipLv);
                }
            }
            return;
        }// end function

        private function vipanelinit()
        {
            var _loc_2:* = null;
            this.title = "VIP";
            resize(300, 350);
            var _loc_1:* = new Shape();
            _loc_1.alpha = 0.4;
            this.addChild(_loc_1);
            _loc_1.graphics.beginFill(16777215);
            _loc_1.graphics.drawRoundRect(10, 35, 280, 50, 5);
            _loc_1.graphics.beginFill(16777215);
            _loc_1.graphics.drawRoundRect(10, 95, 280, 200, 5);
            _loc_1.graphics.endFill();
            this.lab = new Label(this, 30, 50);
            this.lab.html = true;
            this.labRight = new Label(this, 25, 105);
            this.labRight.html = true;
            _loc_2 = new Label(this, 25, 135);
            _loc_2.html = true;
            _loc_2.text = Config.language("VipPanel", 5);
            _loc_2 = new Label(this, 25, 165);
            _loc_2.html = true;
            _loc_2.text = Config.language("VipPanel", 6);
            _loc_2 = new Label(this, 25, 195);
            _loc_2.html = true;
            _loc_2.text = Config.language("VipPanel", 7);
            this._textday = new Label(this, 25, 270);
            this._textday.html = true;
            var _loc_3:* = new ClickLabel(this, 210, 50, Config.language("VipPanel", 8), this.jumpvipshop, true);
            _loc_3.clickColor([26367, 6837142]);
            var _loc_4:* = new PushButton(this, 195, 310, Config.language("VipPanel", 10), this.sendgetvipgift);
            new PushButton(this, 195, 310, Config.language("VipPanel", 10), this.sendgetvipgift).width = 80;
            this.buftimer = new Timer(1000);
            this.buftimer.addEventListener(TimerEvent.TIMER, this.changebuftime);
            return;
        }// end function

        private function usevipcard(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            return;
        }// end function

        private function sendgetvipgift(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_VIP_GETBOX);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function jumpvipshop(param1) : void
        {
            Config.ui._shopmail.open();
            Config.ui._shopmail.vipshop();
            return;
        }// end function

        private function changebuftime(event:TimerEvent) : void
        {
            var _loc_2:* = true;
            var _loc_3:* = "";
            var _loc_4:* = this.longintime - int(Config.now.getTime() / 1000);
            trace(_loc_4);
            if (_loc_4 > 0)
            {
                _loc_3 = Config.timeShow(_loc_4, 2);
                this._textday.text = Config.language("VipPanel", 11, _loc_3);
            }
            else
            {
                this.buftimer.stop();
            }
            return;
        }// end function

        public function freshviptime(param1:int)
        {
            var _loc_2:* = 0;
            if (this._opening)
            {
                this.buftimer.stop();
                _loc_2 = param1 - int(Config.now.getTime() / 1000);
                this._textday.text = Config.language("VipPanel", 1, int(_loc_2 / this._day), int(_loc_2 % this._day / this._hour));
            }
            return;
        }// end function

    }
}
