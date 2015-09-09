package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class Choujiang extends Sprite
    {
        private var moneylabel:Label;
        private var _slots:Array;
        private var _goButtonSprite:Sprite;
        private var _goButtonEnabled:Bitmap;
        private var _goButtonDisabled:Bitmap;
        private var _runIndex:int = 11;
        private var _runTimer:Number;
        private var _runCount:int = 0;
        private var _runStopped:Boolean = false;
        private var _rsIndex:int = 0;
        private var _rsSlowed:Boolean = false;
        private var _emptyMap:Object;
        private var _moreCoinSprite:Sprite;
        private var _notTimeSprite:Sprite;
        private var _emptySprite:Sprite;
        private var _getSprite:Sprite;
        private var _getSpriteSlot:CloneSlot;
        private var _getNameTf:TextField;
        private var _coinSprt:Sprite;
        private var _coinBmp:Bitmap;
        private var _coinTf:TextField;
        private var _startTime:int;
        private var _stopTime:int;
        private var _nothingIcon:BitmapData;
        private var _borderIcon:Bitmap;

        public function Choujiang()
        {
            this._slots = [];
            this._emptyMap = {};
            Config.startLoop(this.initUI);
            return;
        }// end function

        private function initUI(event:Event)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            Config.stopLoop(this.initUI);
            this.graphics.beginFill(7689037);
            this.graphics.drawRoundRect(10, 28, 520, 34, 5);
            this.graphics.beginFill(13545363);
            this.graphics.drawRoundRect(10, 100, 520, 295, 5);
            this.graphics.endFill();
            this.graphics.beginFill(16777215, 0.4);
            this.graphics.drawRect(21, 108, 313, 278);
            this.graphics.endFill();
            this.graphics.beginFill(16777215, 0.4);
            this.graphics.drawRect(351, 108, 168, 278);
            this.graphics.endFill();
            this.graphics.beginFill(13545363);
            this.graphics.drawRoundRect(15, 31, 200, 28, 2);
            var _loc_2:* = new Label(this, 20, 35, Config.language("ShopMall", 4));
            _loc_2.textColor = 7689037;
            this.moneylabel = new Label(this, 40, 35);
            this.moneylabel.textColor = 7689037;
            var _loc_3:* = new ButtonBar(this, 15, 70, 522);
            _loc_3.addTab(Config.language("Choujiang", 1), null, 80);
            var _loc_4:* = new PushButton(this, 360, 35, Config.language("ShopMall", 24), Config.ui._shopmail.backshopmail);
            var _loc_5:* = new Label(this, 380, 130, Config.language("Choujiang", 2).replace(/\\\
n""\\n/g, "\n"));
            new Label(this, 380, 130, Config.language("Choujiang", 2).replace(/\\\
n""\\n/g, "\n")).html = true;
            _loc_5.tf.setTextFormat(new TextFormat(null, 12, null, null, null, null, null, null, null, null, null, null, 7));
            var _loc_6:* = 0;
            while (_loc_6 < 12)
            {
                
                _loc_9 = new CloneSlot(_loc_6, 32);
                this.addChild(_loc_9);
                this._slots[_loc_6] = _loc_9;
                if (_loc_6 < 3)
                {
                    _loc_9.x = 10 + 60 + 60 * _loc_6;
                    _loc_9.y = 100 + 37;
                }
                else if (_loc_6 < 6)
                {
                    _loc_9.x = 10 + 60 + 60 * 3;
                    _loc_9.y = 100 + 37 + 60 * (_loc_6 - 3);
                }
                else if (_loc_6 < 9)
                {
                    _loc_9.x = 10 + 60 + 60 * (9 - _loc_6);
                    _loc_9.y = 100 + 37 + 60 * 3;
                }
                else
                {
                    _loc_9.x = 10 + 60;
                    _loc_9.y = 100 + 37 + (12 - _loc_6) * 60;
                }
                _loc_9.addEventListener(MouseEvent.ROLL_OVER, this.handleRollover);
                _loc_9.addEventListener(MouseEvent.ROLL_OUT, this.handleRollout);
                _loc_6++;
            }
            this._goButtonSprite = new Sprite();
            this._goButtonSprite.x = 108 + 10;
            this._goButtonSprite.y = 98 + 100;
            this._goButtonSprite.buttonMode = true;
            this._goButtonSprite.addEventListener(MouseEvent.CLICK, this.handleGo);
            addChild(this._goButtonSprite);
            this._goButtonEnabled = new Bitmap(Config.findsysUI("choujiang/go0", 121, 90));
            this._goButtonDisabled = new Bitmap(Config.findsysUI("choujiang/go1", 121, 90));
            this._goButtonSprite.addChild(this._goButtonDisabled);
            this._goButtonSprite.addChild(this._goButtonEnabled);
            _loc_7 = new TextFormat(null, 12, Style.WINDOW_FONT, null, null, null, null, null, null, null, null, null, 7);
            this._moreCoinSprite = new Sprite();
            _loc_8 = Config.getSimpleTextField();
            _loc_8.x = 20;
            _loc_8.defaultTextFormat = _loc_7;
            _loc_8.htmlText = Config.language("Choujiang", 3).replace(/\\\
n""\\n/g, "\n");
            this._moreCoinSprite.addChild(_loc_8);
            this._notTimeSprite = new Sprite();
            _loc_8 = Config.getSimpleTextField();
            _loc_8.x = 50;
            _loc_8.defaultTextFormat = _loc_7;
            _loc_8.htmlText = Config.language("Choujiang", 4).replace(/\\\
n""\\n/g, "\n");
            this._notTimeSprite.addChild(_loc_8);
            this._emptySprite = new Sprite();
            _loc_8 = Config.getSimpleTextField();
            _loc_8.x = 20;
            _loc_8.defaultTextFormat = _loc_7;
            _loc_8.htmlText = Config.language("Choujiang", 5).replace(/\\\
n""\\n/g, "\n");
            this._emptySprite.addChild(_loc_8);
            this._getSprite = new Sprite();
            _loc_8 = Config.getSimpleTextField();
            _loc_8.defaultTextFormat = new TextFormat(null, 12, 7353600);
            _loc_8.x = 20;
            _loc_8.htmlText = Config.language("Choujiang", 6).replace(/\\\
n""\\n/g, "\n");
            this._getSprite.addChild(_loc_8);
            _loc_8 = Config.getSimpleTextField();
            _loc_8.x = 20;
            _loc_8.y = 80;
            _loc_8.defaultTextFormat = _loc_7;
            _loc_8.htmlText = Config.language("Choujiang", 7).replace(/\\\
n""\\n/g, "\n");
            this._getSprite.addChild(_loc_8);
            this._getSpriteSlot = new CloneSlot(0);
            this._getSpriteSlot.x = 30;
            this._getSpriteSlot.y = 40;
            this._getSpriteSlot.addEventListener(MouseEvent.ROLL_OVER, this.handleRollover);
            this._getSpriteSlot.addEventListener(MouseEvent.ROLL_OUT, this.handleRollout);
            this._getSprite.addChild(this._getSpriteSlot);
            this._getNameTf = Config.getSimpleTextField();
            this._getNameTf.x = 70;
            this._getNameTf.y = 45;
            this._getNameTf.defaultTextFormat = _loc_7;
            this._getSprite.addChild(this._getNameTf);
            this._coinSprt = new Sprite();
            this._coinSprt.x = 10 + 20;
            this._coinSprt.y = 100 + 252;
            this._coinSprt.buttonMode = true;
            this._coinSprt.addEventListener(MouseEvent.ROLL_OVER, this.handleCoinRollover);
            this._coinSprt.addEventListener(MouseEvent.ROLL_OUT, this.handleCoinRollout);
            this._coinBmp = new Bitmap(Config.findIcon(Config._itemMap[10223].icon));
            this._coinTf = Config.getSimpleTextField();
            this._coinTf.x = 10 + 20 + 32;
            this._coinTf.y = 100 + 252 + 7;
            this._coinTf.defaultTextFormat = new TextFormat(null, 14, 16711680, true);
            addChild(this._coinSprt);
            this._coinSprt.addChild(this._coinBmp);
            addChild(this._coinTf);
            this._nothingIcon = Config.findIcon("i00121", 32, 32);
            this._borderIcon = new Bitmap(Config.findIcon("i00119", 46, 46));
            addChild(this._borderIcon);
            this._borderIcon.x = CloneSlot(this._slots[0]).x - 7;
            this._borderIcon.y = CloneSlot(this._slots[0]).y - 7;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LOTTERY_INFO, this.handleInfo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LOTTERY, this.handleRs);
            return;
        }// end function

        private function handleCoinRollover(event:MouseEvent)
        {
            var _loc_2:* = new Point(this._coinSprt.x, this._coinSprt.y);
            _loc_2 = this._coinSprt.parent.localToGlobal(_loc_2);
            Holder.showInfo(Config._itemMap[10223].name + "\n\n" + Config._itemMap[10223].description, new Rectangle(_loc_2.x, _loc_2.y, this._coinSprt.width, this._coinSprt.height));
            return;
        }// end function

        private function handleCoinRollout(event:MouseEvent)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function resetCoin()
        {
            this._coinTf.text = "×" + Config.ui._charUI.getItemAmount(10223);
            return;
        }// end function

        private function handleRs(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            this._rsIndex = _loc_3 - 1;
            this._runStopped = true;
            this.resetCoin();
            return;
        }// end function

        private function handleInfo(param1)
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            this._emptyMap = {};
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedByte();
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = this._slots[(_loc_5 - 1)];
                if (_loc_6 != 0)
                {
                    _loc_9 = Item.newItem(Config._itemMap[_loc_6], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, _loc_4);
                    _loc_9.display();
                    _loc_9.amount = _loc_7;
                    _loc_8.item = _loc_9;
                }
                else
                {
                    this._emptyMap[(_loc_5 - 1)] = true;
                    _loc_8._icon.bitmapData = this._nothingIcon;
                }
                _loc_4++;
            }
            this._startTime = _loc_2.readUnsignedInt();
            this._stopTime = _loc_2.readUnsignedInt();
            return;
        }// end function

        public function testInTime() : Boolean
        {
            var _loc_1:* = int(Config.now.getTime() / 1000);
            if (_loc_1 >= this._startTime && _loc_1 <= this._stopTime)
            {
                return true;
            }
            return false;
        }// end function

        private function handleRollover(event:MouseEvent)
        {
            var _loc_3:* = null;
            var _loc_2:* = CloneSlot(event.currentTarget);
            if (_loc_2.parent != null && _loc_2.item != null)
            {
                _loc_3 = new Point(_loc_2.x, _loc_2.y);
                _loc_3 = _loc_2.parent.localToGlobal(_loc_3);
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleRollout(event:MouseEvent)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleGo(event:MouseEvent)
        {
            this.resetCoin();
            if (Config.ui._charUI.getItemAmount(10223) <= 0)
            {
                this.jumpMoreCoin();
                return;
            }
            this._goButtonEnabled.visible = false;
            this._goButtonSprite.mouseEnabled = false;
            this._goButtonSprite.mouseChildren = false;
            Config.startLoop(this.loop);
            this._runStopped = false;
            this._rsSlowed = false;
            this._runCount = 3;
            clearTimeout(this._runTimer);
            this._runTimer = setTimeout(this.stopLoop, 2500);
            return;
        }// end function

        public function jumpNotTime()
        {
            this._goButtonEnabled.visible = true;
            this._goButtonSprite.mouseEnabled = true;
            this._goButtonSprite.mouseChildren = true;
            Config.stopLoop(this.loop);
            AlertUI.alert(Config.language("Choujiang", 1), "", [Config.language("Choujiang", 8)], null, null, false, true, false, this._notTimeSprite);
            return;
        }// end function

        public function jumpMoreCoin()
        {
            this._goButtonEnabled.visible = true;
            this._goButtonSprite.mouseEnabled = true;
            this._goButtonSprite.mouseChildren = true;
            Config.stopLoop(this.loop);
            AlertUI.alert(Config.language("Choujiang", 1), "", [Config.language("Choujiang", 8)], null, null, false, true, false, this._moreCoinSprite);
            return;
        }// end function

        private function loop(event:Event) : void
        {
            var _loc_2:* = 0;
            if (this._runCount > 0)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._runCount - 1;
                _loc_3._runCount = _loc_4;
                return;
            }
            this._runCount = 3;
            if (this._runStopped)
            {
                _loc_2 = this._rsIndex - this._runIndex;
                if (_loc_2 < 0)
                {
                    _loc_2 = _loc_2 + 12;
                }
                if (_loc_2 == 6)
                {
                    this._rsSlowed = true;
                }
                if (this._rsSlowed && _loc_2 < 6)
                {
                    this._runCount = this._runCount + (6 - _loc_2) * 2;
                }
            }
            var _loc_3:* = this;
            var _loc_4:* = this._runIndex + 1;
            _loc_3._runIndex = _loc_4;
            if (this._runIndex >= 12)
            {
                this._runIndex = 0;
            }
            this._borderIcon.x = CloneSlot(this._slots[this._runIndex]).x - 7;
            this._borderIcon.y = CloneSlot(this._slots[this._runIndex]).y - 7;
            if (this._runStopped && this._rsSlowed)
            {
                if (this._rsIndex == this._runIndex)
                {
                    this._goButtonEnabled.visible = true;
                    this._goButtonSprite.mouseEnabled = true;
                    this._goButtonSprite.mouseChildren = true;
                    Config.stopLoop(this.loop);
                    if (this._emptyMap[this._rsIndex])
                    {
                        AlertUI.alert(Config.language("Choujiang", 1), "", [Config.language("Choujiang", 8)], null, null, false, true, false, this._emptySprite);
                    }
                    else
                    {
                        this._getSpriteSlot.item = this._slots[this._rsIndex].item;
                        this._getNameTf.text = this._slots[this._rsIndex].item._itemData.name;
                        AlertUI.alert(Config.language("Choujiang", 1), "", [Config.language("Choujiang", 8)], null, null, false, true, false, this._getSprite);
                    }
                }
            }
            return;
        }// end function

        private function stopLoop()
        {
            clearTimeout(this._runTimer);
            if (Config.ui._charUI.getItemAmount(10223) <= 0)
            {
                this.jumpMoreCoin();
                return;
            }
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_LOTTERY);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public function open()
        {
            this.moneylabel.text = Config.coinShow(Config.player.money1);
            this.moneylabel.x = 180 - (160 - this.moneylabel.width) / 2;
            Config.player.removeEventListener("update", this.updatemoney);
            Config.player.addEventListener("update", this.updatemoney);
            this.resetCoin();
            return;
        }// end function

        public function close()
        {
            Config.player.removeEventListener("update", this.updatemoney);
            return;
        }// end function

        private function updatemoney(event:UnitEvent) : void
        {
            if (event.param == "money1")
            {
                this.moneylabel.text = Config.coinShow(event.value);
                this.moneylabel.x = 180 - (160 - this.moneylabel.width) / 2;
            }
            return;
        }// end function

    }
}
