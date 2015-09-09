package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class InterBigWar extends Window
    {
        private var sprArr:Array;
        private var labArr:Array;
        private var _page:int = 1;
        private var _id:int;
        private var _n:int = 0;
        private var _waralert:Object;
        private var injionbtn:PushButton;
        private var label:Label;
        private var timerr:Timer;
        private var _sprit:Sprite;
        private var _timeLB:Label;
        private var pageup:PushButton;
        private var pagedown:PushButton;
        private var _totlapage:int;
        private var _currentTime:int = 5;

        public function InterBigWar(param1:DisplayObjectContainer = null, param2:Number = 150, param3:Number = 50)
        {
            super(param1, param2, param3);
            this.initsocket();
            this.initpanel();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_GUILDVS_ENROLL, this.jioninterwar);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_GUILDVS_LIST, this.interwarList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_GUILDVS_CANCEL, this.canseljion);
            return;
        }// end function

        public function openwarpanel()
        {
            this.open();
            this._n = 0;
            this.sendpage(this._page);
            return;
        }// end function

        private function initpanel()
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            resize(390, 320);
            this.title = Config.language("InterBigWar", 1);
            this.sprArr = new Array();
            this.labArr = new Array();
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                _loc_5 = new Sprite();
                this.addChild(_loc_5);
                _loc_5.graphics.beginFill(14463830);
                if (_loc_1 < 3)
                {
                    _loc_5.x = 15 + _loc_1 * 120;
                    _loc_5.y = 30;
                    _loc_5.graphics.drawRoundRect(0, 0, 115, 105, 5);
                    _loc_4 = new Label(_loc_5, 15, 10);
                    _loc_4.html = true;
                }
                else
                {
                    _loc_5.x = 15 + (_loc_1 - 3) * 120;
                    _loc_5.y = 140;
                    _loc_5.graphics.drawRoundRect(0, 0, 115, 105, 5);
                    _loc_4 = new Label(_loc_5, 15, 10);
                    _loc_4.html = true;
                }
                _loc_5.alpha = 0.5;
                _loc_5.graphics.endFill();
                _loc_5.addEventListener(MouseEvent.CLICK, Config.create(this.clicksp, _loc_1));
                this.sprArr.push(_loc_5);
                this.labArr.push(_loc_4);
                _loc_1 = _loc_1 + 1;
            }
            this.injionbtn = new PushButton(this, 160, 282, Config.language("InterBigWar", 2), this.sendjion);
            this.injionbtn.width = 60;
            this.pageup = new PushButton(this, 80, 282, Config.language("InterBigWar", 3), Config.create(this.page, -1));
            this.pageup.width = 60;
            this.pagedown = new PushButton(this, 240, 282, Config.language("InterBigWar", 4), Config.create(this.page, 1));
            this.pagedown.width = 60;
            this.label = new Label(this, 20, 255);
            this.label.html = true;
            this._sprit = new Sprite();
            var _loc_3:* = [new GlowFilter(0, 1, 2, 2, 10)];
            _loc_2 = new Label(this._sprit, -130, 200, Config.language("InterBigWar", 5));
            _loc_2.textColor = 16752190;
            _loc_2.filters = _loc_3;
            _loc_2 = new Label(this._sprit, -130, 200, "__________________");
            _loc_2.textColor = 16752190;
            _loc_2.filters = _loc_3;
            _loc_2 = new Label(this._sprit, -120, 225);
            _loc_2.html = true;
            _loc_2.textColor = 16777215;
            _loc_2.filters = _loc_3;
            _loc_2.text = Config.language("InterBigWar", 6);
            this._timeLB = new Label(this._sprit, -240, 60);
            this._timeLB.textColor = Style.WHITE_FONT;
            this._timeLB.filters = [new GlowFilter(0, 1, 1.5, 1.5, 5)];
            this.timerr = new Timer(1000);
            return;
        }// end function

        private function clicksp(event:MouseEvent, param2:int)
        {
            trace(param2, event.currentTarget.alpha, event.target.alpha);
            var _loc_3:* = 0;
            while (_loc_3 < 6)
            {
                
                this.sprArr[_loc_3].alpha = 0.5;
                _loc_3 = _loc_3 + 1;
            }
            this.sprArr[param2].alpha = 1;
            this._n = param2 + 1;
            return;
        }// end function

        private function sendjion(event:MouseEvent) : void
        {
            if (this._id == 0)
            {
                if (this._n == 0)
                {
                    Config.message(Config.language("InterBigWar", 7));
                }
                else
                {
                    if (this._waralert != null)
                    {
                        AlertUI.remove(this._waralert);
                    }
                    this._waralert = AlertUI.alert(Config.language("InterBigWar", 8), Config.language("InterBigWar", 9, int(this._n + (this._page - 1) * 6)), [Config.language("InterBigWar", 10), Config.language("InterBigWar", 11)], [this.sendjionalert]);
                }
            }
            else
            {
                if (this._waralert != null)
                {
                    AlertUI.remove(this._waralert);
                }
                this._waralert = AlertUI.alert(Config.language("InterBigWar", 10), Config.language("InterBigWar", 12, this._currentTime), [Config.language("InterBigWar", 10), Config.language("InterBigWar", 11)], [this.sendcanseljion]);
            }
            return;
        }// end function

        private function sendjionalert(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2B_GUILDVS_ENROLL);
            _loc_2.add32(this._n + (this._page - 1) * 6);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendcanseljion(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2B_GUILDVS_CANCEL);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function page(event:MouseEvent, param2:int) : void
        {
            if (this._waralert != null)
            {
                AlertUI.remove(this._waralert);
            }
            this._page = this._page + param2;
            if (this._page <= 0)
            {
                this._page = 1;
            }
            else if (this._page >= (this._totlapage + 1))
            {
                this._page = this._totlapage;
            }
            else
            {
                this._n = 0;
                this.sendpage(this._page);
            }
            return;
        }// end function

        private function sendpage(param1:int)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2B_GUILDVS_LIST);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function jioninterwar(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.sendpage(this._page);
            Config.message(Config.language("InterBigWar", 13));
            return;
        }// end function

        private function interwarList(event:SocketEvent) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            this._totlapage = _loc_2.readByte();
            this._id = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            if (this._totlapage <= 1)
            {
                this.pagedown.visible = false;
                this.pageup.visible = false;
            }
            else
            {
                this.pagedown.visible = true;
                this.pageup.visible = true;
            }
            this._page = _loc_3;
            if (_loc_4 == 1)
            {
                this.injionbtn.visible = true;
                if (this._id == 0)
                {
                    this.label.text = Config.language("InterBigWar", 14);
                    this.injionbtn.label = Config.language("InterBigWar", 2);
                    this.injionbtn.enabled = true;
                }
                else
                {
                    this.label.text = Config.language("InterBigWar", 15, this._id);
                    this.injionbtn.label = Config.language("InterBigWar", 16);
                    if (this._currentTime == 0)
                    {
                        this.injionbtn.enabled = false;
                    }
                    else
                    {
                        this.injionbtn.enabled = true;
                    }
                }
            }
            else
            {
                if (this._id == 0)
                {
                    this.label.text = Config.language("InterBigWar", 17);
                }
                else
                {
                    this.label.text = Config.language("InterBigWar", 15, this._id);
                }
                this.injionbtn.visible = false;
            }
            var _loc_6:* = 0;
            while (_loc_6 < 6)
            {
                
                this.sprArr[_loc_6].alpha = 0.5;
                this.sprArr[_loc_6].visible = false;
                _loc_6 = _loc_6 + 1;
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                this.sprArr[_loc_6].visible = true;
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_9 = _loc_2.readUnsignedShort();
                this.labArr[_loc_6].text = Config.language("InterBigWar", 18, _loc_7, _loc_8, _loc_9);
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        public function goininterwar()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2B_GUILDVS_ENTER);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function cdgo(param1)
        {
            var _loc_2:* = new Date();
            _loc_2.setTime(Config.now.getTime());
            var _loc_3:* = int(_loc_2.getTime() / 1000);
            _loc_2.setHours(20, 30, 0);
            var _loc_4:* = int(_loc_2.getTime() / 1000);
            var _loc_5:* = Number(Math.max(0, _loc_4 - _loc_3));
            this._timeLB.text = Config.language("PkraceUI", 13) + Config.timeShow(_loc_5);
            if (_loc_5 <= 0)
            {
                this.stoptimer();
                this._timeLB.text = "";
            }
            return;
        }// end function

        public function starttimer()
        {
            Config.ui._taskpanel._tasktips.close(true);
            if (this._sprit.parent == null)
            {
                Config.ui._radar.addChild(this._sprit);
            }
            this.timerr.stop();
            this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
            this.timerr.addEventListener(TimerEvent.TIMER, this.cdgo);
            this.timerr.start();
            return;
        }// end function

        public function stoptimer()
        {
            if (this._sprit.parent != null)
            {
                Config.ui._radar.removeChild(this._sprit);
            }
            if (Config.ui._taskpanel._tasktips.opening)
            {
                Config.ui._taskpanel._tasktips.open();
            }
            this.timerr.stop();
            this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
            return;
        }// end function

        private function canseljion(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this._n = 0;
            this.sendpage(this._page);
            Config.message(Config.language("PkraceUI", 19));
            Config.message(Config.language("PkraceUI", 20, this._currentTime));
            return;
        }// end function

        public function set time(param1:int)
        {
            this._n = 0;
            this._currentTime = 5 - param1;
            return;
        }// end function

    }
}
