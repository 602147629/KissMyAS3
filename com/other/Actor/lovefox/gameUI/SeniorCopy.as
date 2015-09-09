package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class SeniorCopy extends Window
    {
        private var _lab:Label;
        private var _pushbtn:PushButton;
        private var _enterbtn:PushButton;
        private var _floor:uint;
        private var _type:int;
        private var _sprite:Sprite;
        private var _backbitmap:Bitmap;
        private var _labstruction1:Label;
        private var _labstruction:Label;
        private var _timesprite:Sprite;
        private var _inforsprite:Sprite;
        private var _count:uint;
        private var _timer:Timer;
        private var _logintime:int;
        private var _shutdown:int;
        private var _timeLB:Label;
        private var tempLBcount:Label;
        private var _tempLab:Label;
        private var _prizecount:int;
        private var myFilters:Array;

        public function SeniorCopy(param1:DisplayObjectContainer = null)
        {
            this.myFilters = [new GlowFilter(0, 1, 2, 2, 10)];
            super(param1);
            resize(490, 360);
            this.initsocket();
            this.init();
            return;
        }// end function

        public function resizeposx()
        {
            if (this._timesprite != null)
            {
                if (this._timesprite.parent != null)
                {
                    this._timesprite.x = (-Config.ui._width) / 2 - 50;
                }
            }
            return;
        }// end function

        public function openseniorcopy() : void
        {
            var _loc_1:* = 0;
            if (this.floor > 0)
            {
                this.open();
                _loc_1 = int(Config.player.level / 10) * 10;
                if (_loc_1 > 130)
                {
                    _loc_1 = 130;
                }
                this._lab.text = Config.language("SeniorCopy", 2, _loc_1, this.floor);
                this._labstruction.text = Config.language("SeniorCopy", 3, this.floor, Config._itemMap[Config._expcopymap[this.type * 10 + this.floor].item1].name, Config._expcopymap[this.type * 10 + this.floor].nub1, Config._expcopymap[this.type * 10 + this.floor].exp);
                this._labstruction1.text = Config.language("SeniorCopy", 4, this.floor, (this.floor + 1), Config._itemMap[Config._expcopymap[this.type * 10 + this.floor].item1].name, Config._expcopymap[this.type * 10 + this.floor].nub1, Config._expcopymap[this.type * 10 + this.floor].exp);
            }
            else
            {
                this.enterfb();
            }
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPCOPY_AWARD_NOTICE, this.receiveprize);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPCOPY_FLOOR, this.getfloor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPCOPY_AWARD_COUNT, this.getprizetimes);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPCOPY_CLOSE, this.receivetimeover);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPCOPY_TIME, this.alltime);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPCOPY_MONSTERS, this.killcount);
            return;
        }// end function

        private function init() : void
        {
            var _loc_1:* = null;
            this.title = Config.language("SeniorCopy", 1);
            _loc_1 = new Sprite();
            this.addChild(_loc_1);
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(16777215, 0.2);
            _loc_2.graphics.drawRoundRect(50, 60, 380, 35, 5);
            _loc_2.graphics.endFill();
            _loc_1.addChild(_loc_2);
            var _loc_3:* = new Shape();
            _loc_3.graphics.beginFill(16777215, 0.2);
            _loc_3.graphics.drawRoundRect(50, 102, 75, 164, 5);
            _loc_3.graphics.endFill();
            _loc_1.addChild(_loc_3);
            var _loc_4:* = new Shape();
            new Shape().graphics.beginFill(16777215, 0.2);
            _loc_4.graphics.drawRoundRect(130, 102, 300, 25, 5);
            _loc_4.graphics.endFill();
            _loc_1.addChild(_loc_4);
            var _loc_5:* = new Shape();
            new Shape().graphics.beginFill(16777215, 0.2);
            _loc_5.graphics.drawRoundRect(130, 132, 300, 54, 5);
            _loc_5.graphics.endFill();
            _loc_1.addChild(_loc_5);
            var _loc_6:* = new Shape();
            new Shape().graphics.beginFill(16777215, 0.2);
            _loc_6.graphics.drawRoundRect(130, 191, 300, 75, 5);
            _loc_6.graphics.endFill();
            _loc_1.addChild(_loc_6);
            this._pushbtn = new PushButton(_loc_1, 225, 235, Config.language("SeniorCopy", 5), this.prizealert);
            this._enterbtn = new PushButton(_loc_1, 190, 315, Config.language("SeniorCopy", 6), this.enterfb);
            this._lab = new Label(this, 60, 75);
            var _loc_7:* = new Bitmap();
            _loc_1.addChild(_loc_7);
            _loc_7.x = 60;
            _loc_7.y = 110;
            _loc_7.bitmapData = Config.findsysUI("acitve/t25", 54, 54);
            this._labstruction = new Label(_loc_1, 135, 105);
            this._labstruction1 = new Label(_loc_1, 50, 275);
            this._labstruction.html = true;
            this._labstruction1.html = true;
            this._timer = new Timer(1000);
            return;
        }// end function

        public function prizealert(event:MouseEvent = null) : void
        {
            if (this.prizecount > 0)
            {
                if (this.floor < 10 && this.floor > 0)
                {
                    AlertUI.alert(Config.language("SeniorCopy", 7), Config.language("SeniorCopy", 10, Config._itemMap[Config._expcopymap[this.type * 10 + this.floor].item1].name, Config._expcopymap[this.type * 10 + this.floor].nub1, Config._expcopymap[this.type * 10 + this.floor].exp), [Config.language("SeniorCopy", 8), Config.language("SeniorCopy", 9)], [this.sendprize]);
                }
                else if (this.floor == 10)
                {
                    this.sendprize();
                }
            }
            return;
        }// end function

        private function enterfb(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ENTER_EXPCOPY);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendprize(event:MouseEvent = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_EXPCOPY_AWARD_GET);
            ClientSocket.send(_loc_2);
            this.close();
            Config.ui._activePanel.close();
            return;
        }// end function

        private function quikcopy(event:MouseEvent)
        {
            this.canseldeath(3);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEAVE_EXPCOPY);
            ClientSocket.send(_loc_2);
            this.removecopyinfor();
            return;
        }// end function

        private function receiveprize(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            AlertUI.alert(Config.language("SeniorCopy", 7), Config.language("SeniorCopy", 11, Config._itemMap[Config._expcopymap[this.type * 10 + 10].item1].name, Config._expcopymap[this.type * 10 + 10].nub1, Config._expcopymap[this.type * 10 + 10].exp), [Config.language("SeniorCopy", 8)], [this.quikcopy]);
            return;
        }// end function

        private function getfloor(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.floor = _loc_2.readUnsignedShort();
            this.type = _loc_2.readUnsignedByte();
            trace(this.type, this.floor);
            if (this.type < 0 || this.type > 3)
            {
                this.type = 1;
            }
            return;
        }// end function

        private function getprizetimes(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.prizecount = _loc_2.readUnsignedByte();
            if (this.prizecount == 0)
            {
                this._pushbtn.buttonMode = false;
                this._pushbtn.enabled = false;
                this._enterbtn.enabled = false;
                this._enterbtn.buttonMode = false;
            }
            else
            {
                this._pushbtn.enabled = true;
                this._pushbtn.buttonMode = true;
                this._enterbtn.enabled = true;
                this._enterbtn.buttonMode = true;
            }
            return;
        }// end function

        private function killcount(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.count = _loc_2.readUnsignedShort();
            if (this.floor < 10)
            {
                if (this.tempLBcount != null)
                {
                    this.tempLBcount.text = Config.language("SeniorCopy", 12, Style.FONT_Green, Config._expcopymap[this.type * 10 + this.floor + 1].monstername, this.count, Config._expcopymap[this.type * 10 + this.floor + 1].monsternub);
                }
                if (this.count == int(Config._expcopymap[this.type * 10 + this.floor + 1].monsternub))
                {
                    Billboard.show(Config.language("SeniorCopy", 13, (this.floor + 1)));
                    if (this._tempLab != null)
                    {
                        this._tempLab.text = Config.language("SeniorCopy", 14, Style.FONT_1_Blue, Config._itemMap[Config._expcopymap[this.type * 10 + this.floor + 1].item1].name, Config._expcopymap[this.type * 10 + this.floor + 1].nub1, Style.FONT_1_Blue, Config._expcopymap[this.type * 10 + this.floor + 1].exp);
                    }
                    if (this._timer != null)
                    {
                        this._timer.stop();
                        this._timer.removeEventListener(TimerEvent.TIMER, this.strattimer);
                        this._timer.addEventListener(TimerEvent.TIMER, this.strattimer);
                        this._shutdown = 60;
                        this._logintime = getTimer();
                        this._timer.start();
                    }
                }
            }
            return;
        }// end function

        private function receivetimeover(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            this.stoptimer();
            var _loc_4:* = "";
            AlertUI.close();
            if (this.floor == 0)
            {
                _loc_4 = Config.language("SeniorCopy", 15);
                AlertUI.alert(Config.language("SeniorCopy", 7), _loc_4, [Config.language("SeniorCopy", 16), Config.language("SeniorCopy", 9)], [this.reenterfb, this.canseldeath]);
            }
            else
            {
                _loc_4 = Config.language("SeniorCopy", 17, this.floor, Config._itemMap[Config._expcopymap[this.type * 10 + this.floor].item1].name, Config._expcopymap[this.type * 10 + this.floor].nub1, Config._expcopymap[this.type * 10 + this.floor].exp);
                AlertUI.alert(Config.language("SeniorCopy", 7), _loc_4, [Config.language("SeniorCopy", 16), Config.language("SeniorCopy", 18), Config.language("SeniorCopy", 9)], [this.reenterfb, this.reprizefb, this.canseldeath]);
            }
            if (_loc_3 == 1)
            {
                this.removecopyinfor();
            }
            return;
        }// end function

        private function reenterfb(event:MouseEvent)
        {
            this.canseldeath(1);
            this.enterfb();
            if (Config.ui._taskpanel._tasktips.opening)
            {
                Config.ui._taskpanel._tasktips.close();
            }
            return;
        }// end function

        private function reprizefb(event:MouseEvent)
        {
            this.canseldeath(2);
            this.sendprize();
            return;
        }// end function

        private function canseldeath(param1)
        {
            if (param1 != 1)
            {
                this.removecopyinfor();
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_EXPCOPY_PLAYER_DEATH);
            if (param1 == 1 || param1 == 2 || param1 == 3)
            {
                _loc_2.add8(param1);
            }
            else
            {
                _loc_2.add8(3);
            }
            ClientSocket.send(_loc_2);
            if (!Config.ui._taskpanel._tasktips.opening)
            {
                Config.ui._taskpanel._tasktips.open();
            }
            return;
        }// end function

        private function alltime(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._shutdown = _loc_2.readUnsignedInt();
            this._logintime = getTimer();
            this.addtimesprite();
            this._timeLB = new Label(this._timesprite, 5, 5);
            this._timeLB.html = true;
            this._timeLB.textColor = 16752190;
            this._timeLB.filters = this.myFilters;
            this._timer.removeEventListener(TimerEvent.TIMER, this.strattimer);
            this._timer.addEventListener(TimerEvent.TIMER, this.strattimer);
            this._timer.start();
            return;
        }// end function

        public function set floor(param1:uint) : void
        {
            this._floor = param1;
            return;
        }// end function

        public function get floor() : uint
        {
            return this._floor;
        }// end function

        private function set type(param1:int) : void
        {
            this._type = param1 - 1;
            return;
        }// end function

        private function get type() : int
        {
            return this._type;
        }// end function

        private function set count(param1:uint) : void
        {
            this._count = param1;
            return;
        }// end function

        private function get count() : uint
        {
            return this._count;
        }// end function

        public function set prizecount(param1:int) : void
        {
            this._prizecount = param1;
            return;
        }// end function

        public function get prizecount() : int
        {
            return this._prizecount;
        }// end function

        public function addbackbtn()
        {
            Config.ui._taskpanel._tasktips.close(true);
            if (this._backbitmap != null)
            {
                if (this._backbitmap.hasOwnProperty("bitmapData"))
                {
                    this._backbitmap.bitmapData.dispose();
                    this._backbitmap = null;
                }
            }
            if (this._sprite != null)
            {
                this.removeAllChildren(this._sprite);
                if (this._sprite.parent != null)
                {
                    this._sprite.parent.removeChild(this._sprite);
                }
            }
            this._sprite = new Sprite();
            this._sprite.graphics.beginFill(16777215, 0);
            this._sprite.graphics.drawCircle(14, 14, 13);
            this._sprite.graphics.endFill();
            this._sprite.x = -200;
            this._sprite.y = 80;
            this._backbitmap = new Bitmap();
            this._backbitmap.bitmapData = Config.findsysUI("acitve/2_2", 28, 28);
            this._sprite.addChild(this._backbitmap);
            this._sprite.addEventListener(MouseEvent.CLICK, this.quikcopy);
            this._sprite.addEventListener(MouseEvent.MOUSE_OVER, this.listenerover);
            this._sprite.addEventListener(MouseEvent.MOUSE_OUT, this.listenerout);
            this._sprite.buttonMode = true;
            Config.ui._radar.addChild(this._sprite);
            if (this._opening)
            {
                this.close();
            }
            if (Config.ui._activePanel._opening)
            {
                Config.ui._activePanel.close();
            }
            this.addstruction();
            return;
        }// end function

        private function addstruction() : void
        {
            var _loc_1:* = null;
            if (this.floor < 10)
            {
                if (this._inforsprite != null)
                {
                    this.removeAllChildren(this._inforsprite);
                    if (this._inforsprite.parent != null)
                    {
                        this._inforsprite.parent.removeChild(this._inforsprite);
                    }
                }
                this._inforsprite = new Sprite();
                this._inforsprite.x = -150;
                this._inforsprite.y = 200;
                Config.ui._radar.addChild(this._inforsprite);
                this.tempLBcount = new Label(this._inforsprite, 0, 0);
                this.tempLBcount.html = true;
                this.tempLBcount.text = Config.language("SeniorCopy", 12, Style.FONT_Green, Config._expcopymap[this.type * 10 + this.floor + 1].monstername, this.count, Config._expcopymap[this.type * 10 + this.floor + 1].monsternub);
                this.tempLBcount.filters = this.myFilters;
                _loc_1 = new Label(this._inforsprite, 0, 50);
                _loc_1.html = true;
                _loc_1.text = Config.language("SeniorCopy", 19, Style.FONT_1_Blue, Config._itemMap[Config._expcopymap[this.type * 10 + 10].item1].name, Config._expcopymap[this.type * 10 + 10].nub1, Style.FONT_1_Blue, Config._expcopymap[this.type * 10 + 10].exp);
                _loc_1.filters = this.myFilters;
                this._tempLab = new Label(this._inforsprite, 0, 110);
                this._tempLab.html = true;
                this._tempLab.filters = this.myFilters;
                if (this.floor > 0)
                {
                    this._tempLab.text = Config.language("SeniorCopy", 14, Style.FONT_1_Blue, Config._itemMap[Config._expcopymap[this.type * 10 + this.floor].item1].name, Config._expcopymap[this.type * 10 + this.floor].nub1, Style.FONT_1_Blue, Config._expcopymap[this.type * 10 + this.floor].exp);
                }
            }
            return;
        }// end function

        private function addtimesprite() : void
        {
            if (this._timesprite != null)
            {
                this.removeAllChildren(this._timesprite);
                if (this._timesprite.parent != null)
                {
                    this._timesprite.parent.removeChild(this._timesprite);
                }
            }
            this._timesprite = new Sprite();
            this._timesprite.x = (-Config.ui._width) / 2 - 50;
            this._timesprite.y = 40;
            Config.ui._radar.addChild(this._timesprite);
            this._timesprite.graphics.beginFill(0, 0);
            this._timesprite.graphics.drawRoundRect(0, 0, 110, 40, 5);
            this._timesprite.graphics.endFill();
            return;
        }// end function

        private function strattimer(event:TimerEvent)
        {
            var _loc_3:* = null;
            var _loc_2:* = Math.max(0, this._shutdown - int((getTimer() - this._logintime) / 1000));
            if (_loc_2 <= 0)
            {
                this.stoptimer();
                this._timeLB.text = "";
                if (this.floor >= 9)
                {
                    this.removecopyinfor();
                }
            }
            else
            {
                _loc_3 = "";
                if (this._shutdown == 60)
                {
                    _loc_3 = Config.language("SeniorCopy", 20);
                }
                else
                {
                    _loc_3 = Config.language("SeniorCopy", 21, (this.floor + 1));
                }
                this._timeLB.text = Config.language("SeniorCopy", 22, _loc_3, Config.timeShow(_loc_2));
            }
            return;
        }// end function

        public function stoptimer()
        {
            if (this._timer != null)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.strattimer);
            }
            if (this._timesprite.parent != null)
            {
                Config.ui._radar.removeChild(this._timesprite);
            }
            return;
        }// end function

        private function removecopyinfor()
        {
            if (this._backbitmap != null)
            {
                if (this._backbitmap.hasOwnProperty("bitmapData"))
                {
                    this._backbitmap.bitmapData.dispose();
                    this._backbitmap = null;
                }
            }
            if (this._sprite != null)
            {
                this.removeAllChildren(this._sprite);
                if (this._sprite.parent != null)
                {
                    this._sprite.parent.removeChild(this._sprite);
                }
            }
            if (this._inforsprite != null)
            {
                this.removeAllChildren(this._inforsprite);
                if (this._inforsprite.parent != null)
                {
                    this._inforsprite.parent.removeChild(this._inforsprite);
                }
            }
            if (this._timesprite != null)
            {
                this.removeAllChildren(this._timesprite);
                if (this._timesprite.parent != null)
                {
                    this._timesprite.parent.removeChild(this._timesprite);
                }
            }
            return;
        }// end function

        private function listenerover(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            Holder.showInfo(Config.language("SeniorCopy", 23), new Rectangle(Config.stage.mouseX + 10, Config.stage.mouseY + 15));
            return;
        }// end function

        private function listenerout(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function removeAllChildren(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

    }
}
