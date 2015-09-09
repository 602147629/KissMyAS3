package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gui.*;
    import lovefox.socket.*;

    public class SellCultivation extends Window
    {
        private var _sprite:Sprite;
        private var _spr:Sprite;
        private var _labArr:Array;
        private var _bitmapArr:Array;
        private var _timeText:Label;
        private var _timer:Timer;
        private var _countDown:int;
        private var _cdStart:int;
        private var _count:uint;
        private var _states:uint;
        private var _alertint:int;
        private var _filters:Array;
        private var _biankuang:GClip;
        private var _pushaddbtn:PushButton;
        private var _flage:Boolean;

        public function SellCultivation(param1:DisplayObjectContainer = null, param2:Number = 180, param3:Number = 120)
        {
            this._bitmapArr = [];
            super(param1, param2, param3);
            resize(410, 220);
            this.initsocket();
            this.initpanel();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_XIUXING_REMAIN, this.startactive);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_XIUXING_AWARD, this.getprize);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_XIUXING_COUNT, this.getcount);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_XIUXING_REFRESH, this.tipsfunc);
            return;
        }// end function

        override public function switchOpen() : void
        {
            if (this.states == 4)
            {
                super.switchOpen();
                if (this._opening)
                {
                    this.setlaber();
                }
            }
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.title = Config.language("SellCultivation", 1);
            this._labArr = [];
            this._filters = [new GlowFilter(0, 1, 2, 2, 10)];
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(16777215, 0.3);
            _loc_1.graphics.drawRoundRect(15, 35, 380, 25, 5);
            _loc_1.graphics.endFill();
            this.addChild(_loc_1);
            _loc_2 = 0;
            while (_loc_2 < 3)
            {
                
                _loc_4 = new Sprite();
                _loc_4.graphics.beginFill(16777215, 0.3);
                _loc_4.graphics.drawRoundRect(0, 0, 120, 130, 5);
                _loc_4.graphics.endFill();
                this.addChild(_loc_4);
                _loc_4.x = 15 + _loc_2 * 130;
                _loc_4.y = 70;
                _loc_5 = new Label(_loc_4, 5, 10);
                _loc_5.html = true;
                this._labArr.push(_loc_5);
                _loc_6 = new PushButton(_loc_4, 30, 100, Config.language("SellCultivation", 2), this.buyexp);
                _loc_6.data = _loc_2;
                _loc_6.width = 60;
                _loc_6.setTable("table18", "table31");
                _loc_6.textColor = Style.GOLD_FONT;
                _loc_2++;
            }
            var _loc_3:* = new Label(this, 20, 40);
            _loc_3.html = true;
            _loc_3.text = Config.language("SellCultivation", 3);
            _loc_3.filters = this._filters;
            this._sprite = new Sprite();
            this._spr = new Sprite();
            this._spr.graphics.beginFill(0, 0);
            this._spr.graphics.drawRoundRect(0, 0, 54, 54, 5);
            this._spr.graphics.endFill();
            this._timer = new Timer(1000);
            this._biankuang = GClip.newGClip("activeborder");
            this._biankuang.mouseChildren = false;
            this._biankuang.mouseEnabled = false;
            this._biankuang.buttonMode = false;
            this._biankuang.x = 5 - 16 - 10;
            this._biankuang.y = -6 - 16;
            return;
        }// end function

        private function buyexp(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (Config.map.id == 489)
            {
                _loc_2 = event.currentTarget.data;
                _loc_3 = "";
                _loc_4 = [Config.language("SellCultivation", 4), Config.language("SellCultivation", 5), Config.language("SellCultivation", 6)];
                _loc_5 = [Config.language("SellCultivation", 12, Config._sellCultivation[Config.player.level].goldValue), Config.language("SellCultivation", 13), Config.language("SellCultivation", 14)];
                _loc_6 = [Config._sellCultivation[Config.player.level].exp, Config._sellCultivation[Config.player.level].halfexp, Config._sellCultivation[Config.player.level].doubleexp];
                _loc_3 = Config.language("SellCultivation", 7, _loc_5[_loc_2], _loc_4[_loc_2], _loc_6[_loc_2]);
                AlertUI.remove(this._alertint);
                this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), _loc_3, [Config.language("SellCultivation", 9), Config.language("SellCultivation", 10)], [this.surebuyexp], (_loc_2 + 1));
            }
            else
            {
                this.close();
                AlertUI.remove(this._alertint);
                this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), Config.language("SellCultivation", 11), [Config.language("SellCultivation", 9)]);
                Config.message(Config.language("SellCultivation", 11));
            }
            return;
        }// end function

        private function surebuyexp(param1:int) : void
        {
            var _loc_2:* = null;
            this.close();
            if (Config.map.id == 489)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_XIUXING_AWARD);
                _loc_2.add8(param1);
                ClientSocket.send(_loc_2);
            }
            else
            {
                AlertUI.remove(this._alertint);
                this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), Config.language("SellCultivation", 11), [Config.language("SellCultivation", 9)]);
                Config.message(Config.language("SellCultivation", 11));
            }
            return;
        }// end function

        private function setlaber() : void
        {
            var _loc_1:* = [Config.language("SellCultivation", 4), Config.language("SellCultivation", 5), Config.language("SellCultivation", 6)];
            var _loc_2:* = [Config.language("SellCultivation", 12, Config._sellCultivation[Config.player.level].goldValue), Config.language("SellCultivation", 13), Config.language("SellCultivation", 14)];
            var _loc_3:* = [Config._sellCultivation[Config.player.level].exp, Config._sellCultivation[Config.player.level].halfexp, Config._sellCultivation[Config.player.level].doubleexp];
            var _loc_4:* = 0;
            while (_loc_4 < 3)
            {
                
                this._labArr[_loc_4].text = Config.language("SellCultivation", 15, _loc_2[_loc_4], _loc_1[_loc_4], _loc_3[_loc_4]);
                _loc_4++;
            }
            return;
        }// end function

        private function startactive(event:SocketEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = event.data;
            this.states = _loc_2.readUnsignedByte();
            this._countDown = _loc_2.readUnsignedInt();
            this.count = _loc_2.readUnsignedByte();
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.enterremaintime);
            this._spr.removeEventListener(MouseEvent.CLICK, this.cultivationfun);
            this._spr.removeEventListener(MouseEvent.CLICK, this.sendprize);
            this._spr.removeEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            this._spr.removeEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            this._spr.buttonMode = false;
            var _loc_3:* = 0;
            while (_loc_3 < this._bitmapArr.length)
            {
                
                if (this._bitmapArr[_loc_3].hasOwnProperty("bitmapData"))
                {
                    this._bitmapArr[_loc_3].bitmapData.dispose();
                }
                _loc_3 = _loc_3 + 1;
            }
            this._bitmapArr = [];
            this.removespritchild(this._sprite);
            Config.ui._radar.addcultivation();
            if (this.states == 3)
            {
                _loc_4 = new Bitmap();
                _loc_4.bitmapData = Config.findsysUI("acitve/over", 54, 54);
                _loc_4.x = 0;
                _loc_4.y = 0;
                this._sprite.addChild(_loc_4);
                this._sprite.addChild(this._spr);
                this._bitmapArr.push(_loc_4);
                this._timeText = new Label(this._sprite, -20, 56, Config.language("SellCultivation", 16));
                this._timeText.textColor = 1636701;
                this._timeText.html = true;
                this._timeText.filters = this._filters;
            }
            else if (this.states == 0)
            {
                _loc_4 = new Bitmap();
                this._sprite.addChild(_loc_4);
                this._sprite.addChild(this._spr);
                _loc_4.x = 0;
                _loc_4.y = 0;
                _loc_4.bitmapData = Config.findsysUI("acitve/black", 54, 54);
                this._spr.addEventListener(MouseEvent.CLICK, this.cultivationfun);
                this._spr.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                this._spr.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                this._spr.buttonMode = true;
                this._bitmapArr.push(_loc_4);
                _loc_5 = new ClickLabel(this._sprite, -10, 56, Config.language("SellCultivation", 17, int(1 - this.count)), this.cultivationfun, true);
                _loc_5.clickColor([Style.FONT_0int_White, Style.FONT_0int_White]);
                _loc_5.filters = this._filters;
            }
            else if (this.states == 1)
            {
                Config.ui._radar.removecultivation();
            }
            else if (this.states == 2)
            {
                BubbleUI.bubble(Config.language("SellCultivation", 18), Style.FONT_5int_Green);
                this._timer.addEventListener(TimerEvent.TIMER, this.enterremaintime);
                this._timer.start();
                this._flage = false;
                this._cdStart = getTimer();
                _loc_4 = new Bitmap();
                this._sprite.addChild(_loc_4);
                this._sprite.addChild(this._spr);
                _loc_4.x = 0;
                _loc_4.y = 0;
                _loc_4.bitmapData = Config.findsysUI("acitve/t24", 54, 54);
                this._bitmapArr.push(_loc_4);
                this._spr.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                this._spr.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                this._timeText = new Label(this._sprite, -10, 56);
                this._timeText.textColor = Style.FONT_0int_White;
                this._timeText.html = true;
                this._timeText.filters = this._filters;
                this._pushaddbtn = new PushButton(this._sprite, 58, 58, "▶▶", this.addspeed);
                this._pushaddbtn.width = 35;
                this._pushaddbtn.height = 15;
                this._pushaddbtn.setTable("table18", "table31");
                this._pushaddbtn.textColor = Style.GOLD_FONT;
            }
            else if (this.states == 4)
            {
                _loc_4 = new Bitmap();
                this._sprite.addChild(_loc_4);
                this._sprite.addChild(this._spr);
                _loc_4.x = 0;
                _loc_4.y = 0;
                _loc_4.bitmapData = Config.findsysUI("acitve/t24", 54, 54);
                this._bitmapArr.push(_loc_4);
                this._spr.addEventListener(MouseEvent.CLICK, this.sendprize);
                this._spr.buttonMode = true;
                _loc_5 = new ClickLabel(this._sprite, -10, 56, Config.language("SellCultivation", 19), this.sendprize, true);
                _loc_5.clickColor([Style.FONT_0int_White, Style.FONT_0int_White]);
                _loc_5.filters = this._filters;
            }
            if (this.states == 4)
            {
                this._sprite.addChild(this._biankuang);
            }
            else if (this._biankuang.parent != null)
            {
                this._biankuang.parent.removeChild(this._biankuang);
            }
            return;
        }// end function

        private function enterremaintime(event:TimerEvent)
        {
            var _loc_2:* = Number(Math.max(0, this._countDown - int(getTimer() - this._cdStart) / 1000));
            this._timeText.text = Config.language("SellCultivation", 20, Config.timeShow(_loc_2));
            if (!this._flage)
            {
                this._flage = true;
                if (this._pushaddbtn != null)
                {
                    if (this._pushaddbtn.parent != null)
                    {
                        this._pushaddbtn.x = this._timeText.x + this._timeText.width + 5;
                    }
                }
            }
            if (_loc_2 <= 0)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.enterremaintime);
                this._timeText.text = "";
            }
            return;
        }// end function

        public function cultivationfun(param1 = null) : void
        {
            if (this.states == 0)
            {
                AlertUI.remove(this._alertint);
                this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), Config.language("SellCultivation", 21), [Config.language("SellCultivation", 22), Config.language("SellCultivation", 10)], [this.sendstartcultive]);
            }
            return;
        }// end function

        private function sendstartcultive(event:MouseEvent)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_XIUXING_START);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendprize(param1) : void
        {
            this.switchOpen();
            return;
        }// end function

        private function addspeed(event:MouseEvent) : void
        {
            this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), Config.language("SellCultivation", 23), [Config.language("SellCultivation", 9), Config.language("SellCultivation", 10)], [this.sureResettime]);
            return;
        }// end function

        private function sureResettime(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_XIUXING_TERMINAL);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function getprize(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedByte();
            var _loc_5:* = int(Number(Config._sellCultivation[Config.player.level].exp) * _loc_4 / 10);
            var _loc_6:* = Config.language("SellCultivation", 24, _loc_4 / 10, _loc_5);
            if (_loc_3 == 1)
            {
                _loc_6 = _loc_6 + Config.language("SellCultivation", 25);
            }
            else if (_loc_3 >= 2)
            {
                _loc_6 = _loc_6 + Config.language("SellCultivation", 26);
            }
            this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), _loc_6, [Config.language("SellCultivation", 9)]);
            return;
        }// end function

        private function tipsfunc(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = "";
            AlertUI.remove(this._alertint);
            if (_loc_3 == 1)
            {
                _loc_4 = Config.language("SellCultivation", 27);
                this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), _loc_4, [Config.language("SellCultivation", 9), Config.language("SellCultivation", 10)], [this.addspeed]);
            }
            else if (_loc_3 == 2)
            {
            }
            else if (_loc_3 == 3)
            {
                _loc_4 = Config.language("SellCultivation", 28);
                this._alertint = AlertUI.alert(Config.language("SellCultivation", 8), _loc_4, [Config.language("SellCultivation", 9)]);
            }
            return;
        }// end function

        public function set count(param1:uint) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : uint
        {
            return this._count;
        }// end function

        private function set states(param1:uint) : void
        {
            this._states = param1;
            return;
        }// end function

        private function get states() : uint
        {
            return this._states;
        }// end function

        private function getcount(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.count = _loc_2.readUnsignedByte();
            this.states = _loc_2.readUnsignedByte();
            return;
        }// end function

        private function removespritchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        public function addcultivationsprite() : Sprite
        {
            return this._sprite;
        }// end function

        private function handleover(event:MouseEvent) : void
        {
            Holder.showInfo(Config.language("SellCultivation", 29), new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 0, 200);
            return;
        }// end function

        private function handleout(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

    }
}
