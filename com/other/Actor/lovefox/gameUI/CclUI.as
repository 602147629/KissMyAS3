package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class CclUI extends Window
    {
        private var _slots:Array;
        private var _titleLB:Label;
        private var mesCanvas:CanvasUI;
        private var mesText:TextAreaUI;
        private var _firstLog:Boolean = true;
        private var _disturb1:Boolean = false;
        private var _disturbCB1:CheckBox;
        private var _disturb2:Boolean = false;
        private var _disturbCB2:CheckBox;
        private var _money1:int;
        private var _money2:int;
        private var _timeLeftLB:Label;
        private var _moneyLB:Label;
        private var _loopTimer:Number;

        public function CclUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this._slots = [];
            super(param1, param2, param3);
            title = Config.language("CclUI", 1);
            this.init();
            return;
        }// end function

        private function init()
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            resize(417, 361);
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(13545363, 1);
            _loc_1.graphics.drawRect(0, 0, 220, 40);
            _loc_1.x = 17;
            _loc_1.y = 301;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(13545363, 1);
            _loc_1.graphics.drawRect(0, 0, 146, 290);
            _loc_1.x = 259;
            _loc_1.y = 59;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(7427649, 1);
            _loc_1.graphics.drawRect(0, 0, 2, 334);
            _loc_1.x = 249;
            _loc_1.y = 23;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.lineStyle(0, 6441562, 1, true);
            _loc_1.graphics.beginFill(9863837, 1);
            _loc_1.graphics.drawRect(0, 0, 101, 21);
            _loc_1.x = 283;
            _loc_1.y = 30;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.lineStyle(0, 11373691, 1, true);
            _loc_1.graphics.beginFill(7623502, 1);
            _loc_1.graphics.drawRect(0, 0, 100, 22);
            _loc_1.x = 27;
            _loc_1.y = 310;
            addChild(_loc_1);
            _loc_1 = new Shape();
            _loc_1.graphics.beginFill(7689037, 1);
            _loc_1.graphics.drawRect(0, 0, 146, 23);
            _loc_1.x = 259;
            _loc_1.y = 58;
            addChild(_loc_1);
            _loc_2 = new Label(this, 290, 31, Config.language("CclUI", 2));
            this._titleLB = new Label(this, 80, 31, Config.language("CclUI", 3));
            var _loc_3:* = new PushButton(this, 155, 310, Config.language("CclUI", 4), this.handleRefresh);
            _loc_3.width = 72;
            var _loc_4:* = 0;
            while (_loc_4 < 6)
            {
                
                _loc_6 = 0;
                while (_loc_6 < 6)
                {
                    
                    _loc_7 = _loc_4 * 6 + _loc_6;
                    _loc_8 = new CclSlot(_loc_7, 32);
                    _loc_8.addEventListener(MouseEvent.CLICK, this.handleClick);
                    _loc_8.x = _loc_4 * 37 + 16 + 2;
                    _loc_8.y = _loc_6 * 37 + 61 + 2;
                    this.addChild(_loc_8);
                    this._slots.push(_loc_8);
                    _loc_6++;
                }
                _loc_4++;
            }
            new CanvasUI();
            new TextAreaUI();
            this.mesCanvas = new CanvasUI(this, 259, 81, 145, 267);
            this.mesText = new TextAreaUI(null, 0, 0, 145, 267);
            this.mesText.autoHeight = true;
            this.mesText.mytext.selectable = true;
            this.mesCanvas.addChildUI(this.mesText);
            _loc_2 = new Label(this, 262, 60, Config.language("CclUI", 4));
            _loc_2.textColor = 16776960;
            this._timeLeftLB = new Label(this, 262, 60, "");
            this._timeLeftLB.autoSize = true;
            this._timeLeftLB.textColor = 16776960;
            var _loc_5:* = new Bitmap(BitmapLoader.pick(String(Config.findUI("bagui").money2.dir)));
            new Bitmap(BitmapLoader.pick(String(Config.findUI("bagui").money2.dir))).x = 31;
            _loc_5.y = 314;
            addChild(_loc_5);
            this._moneyLB = new Label(this, 69, 312, "");
            this._moneyLB.autoSize = true;
            this._moneyLB.textColor = 16776960;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_POKINGFUN_INFO, this.handleInfo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_POKINGFUN, this.handleRS);
            return;
        }// end function

        private function handleRefresh(param1)
        {
            if (this._disturb1)
            {
                this.refreshConfirm(false);
            }
            else
            {
                if (this._disturbCB1 == null)
                {
                    this._disturbCB1 = new CheckBox(null, 0, 0, Config.language("CclUI", 6));
                }
                this._disturbCB1.selected = false;
                AlertUI.alert(Config.language("CclUI", 7), Config.language("CclUI", 8, this._money2), [Config.language("CclUI", 9), Config.language("CclUI", 10)], [this.refreshConfirm], true, false, true, false, this._disturbCB1);
            }
            return;
        }// end function

        private function refreshConfirm(param1:Boolean)
        {
            if (param1)
            {
                this._disturb1 = this._disturbCB1.selected;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_POKINGFUN_REFRESH);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function doRefresh()
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._slots.length)
            {
                
                this._slots[_loc_1].reset();
                _loc_1++;
            }
            return;
        }// end function

        public function addHistory(param1:String) : void
        {
            if (this._firstLog)
            {
                this.mesText.mytext.text = "";
                this.mesText.mytext.defaultTextFormat = new TextFormat(null, null, Style.WINDOW_FONT);
                this.mesText.mytext.appendText(param1);
                this._firstLog = false;
            }
            else
            {
                this.mesText.mytext.appendText("\n" + param1);
            }
            this.mesText.height = this.mesText.mytext.textHeight + 10;
            this.mesCanvas.reFresh();
            this.mesCanvas.verticalScrollPosition = 100;
            return;
        }// end function

        private function loop()
        {
            var _loc_1:* = Config.now.getTime() / 1000;
            var _loc_2:* = Config.ui._recomPanel._onlineActives[3001].endTime - _loc_1;
            if (_loc_2 > 0)
            {
                this._timeLeftLB.text = Config.timeShow(_loc_2, 3);
            }
            else
            {
                this._timeLeftLB.text = "0";
            }
            this._timeLeftLB.x = 400 - this._timeLeftLB.width;
            this._moneyLB.text = Config.coinShow(Config.player.money4);
            this._moneyLB.x = 125 - this._moneyLB.width;
            return;
        }// end function

        override public function close()
        {
            super.close();
            clearInterval(this._loopTimer);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open(event);
            clearInterval(this._loopTimer);
            this.loop();
            this._loopTimer = setInterval(this.loop, 500);
            var _loc_2:* = 0;
            while (_loc_2 < this._slots.length)
            {
                
                this._slots[_loc_2].setState();
                _loc_2++;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_POKINGFUN_INFO);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function handleRS(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            this._slots[_loc_3].setOpenEffect(_loc_4, _loc_5);
            this.addHistory(Config._itemMap[_loc_4].name + "×" + _loc_5);
            return;
        }// end function

        private function handleInfo(event:SocketEvent)
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUnsignedShort();
            this._titleLB.text = Config.language("CclUI", 11, _loc_3, _loc_4);
            this._money1 = _loc_2.readUnsignedInt();
            this._money2 = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedByte();
            var _loc_6:* = {};
            _loc_7 = 0;
            while (_loc_7 < _loc_5)
            {
                
                _loc_8 = _loc_2.readUnsignedByte();
                trace("handleInfo", _loc_8);
                _loc_6[_loc_8] = true;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < this._slots.length)
            {
                
                if (_loc_6[_loc_7])
                {
                    this._slots[_loc_7].setOpened();
                }
                else
                {
                    this._slots[_loc_7].reset();
                }
                _loc_7++;
            }
            return;
        }// end function

        private function handleClick(event:MouseEvent)
        {
            var _loc_2:* = CclSlot(event.currentTarget);
            if (this._disturb2)
            {
                this.clickConfirm({slot:_loc_2});
            }
            else
            {
                if (this._disturbCB2 == null)
                {
                    this._disturbCB2 = new CheckBox(null, 0, 0, Config.language("CclUI", 6));
                }
                this._disturbCB2.selected = false;
                AlertUI.alert(Config.language("CclUI", 7), Config.language("CclUI", 12, this._money1), [Config.language("CclUI", 9), Config.language("CclUI", 10)], [this.clickConfirm], {hasDisturb:true, slot:_loc_2}, false, true, false, this._disturbCB2);
            }
            return;
        }// end function

        private function clickConfirm(param1)
        {
            if (param1.hasDisturb)
            {
                this._disturb2 = this._disturbCB2.selected;
            }
            var _loc_2:* = param1.slot;
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_POKINGFUN);
            _loc_3.add8(_loc_2._id);
            ClientSocket.send(_loc_3);
            return;
        }// end function

    }
}
