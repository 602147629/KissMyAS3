package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gui.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class AwardPanel extends Sprite
    {
        private var _pickNum:int = 0;
        private var _timeNum:int = 0;
        private var _writeTime:Number = 0;
        private var _clickNum:int = 100;
        private var awardtime:Timer;
        private var icon:Bitmap;
        private var tlabel:ClickLabel;
        private var itemsprite:Sprite;
        private var slot1:CloneSlot;
        private var slot2:CloneSlot;
        private var s1:Label;
        private var s2:Label;
        private var contain:DisplayObjectContainer;
        private var btd1:BitmapData;
        private var btd2:BitmapData;
        private var iconsp:Sprite;
        private var linghtsp:Sprite;

        public function AwardPanel(param1:DisplayObjectContainer)
        {
            this.contain = param1;
            this.initpanel();
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        private function initpanel() : void
        {
            this.awardtime = new Timer(1000);
            this.awardtime.removeEventListener(TimerEvent.TIMER, this.timeAdd);
            this.awardtime.addEventListener(TimerEvent.TIMER, this.timeAdd);
            this.btd1 = BitmapLoader.pick(String(Config.findUI("active").award1.dir));
            this.btd2 = BitmapLoader.pick(String(Config.findUI("active").award2.dir));
            this.iconsp = new Sprite();
            this.addChild(this.iconsp);
            this.iconsp.removeEventListener(MouseEvent.CLICK, this.pickAward);
            this.iconsp.removeEventListener(MouseEvent.ROLL_OUT, this.iconRollOut);
            this.iconsp.removeEventListener(MouseEvent.ROLL_OVER, this.iconRollOver);
            this.iconsp.addEventListener(MouseEvent.CLICK, this.pickAward);
            this.iconsp.addEventListener(MouseEvent.ROLL_OUT, this.iconRollOut);
            this.iconsp.addEventListener(MouseEvent.ROLL_OVER, this.iconRollOver);
            this.iconsp.buttonMode = true;
            this.iconsp.filters = [new GlowFilter(6038897, 1, 3, 3, 5, 1)];
            this.icon = new Bitmap();
            this.icon.bitmapData = this.btd1;
            this.iconsp.addChild(this.icon);
            this.linghtsp = new Sprite();
            var _loc_1:* = GClip.newGClip("shining");
            this.linghtsp.addChild(_loc_1);
            _loc_1.x = 30;
            _loc_1.y = 20;
            var _loc_2:* = GClip.newGClip("shining");
            this.linghtsp.addChild(_loc_2);
            _loc_2.x = 15;
            _loc_2.y = 30;
            this.linghtsp.mouseChildren = false;
            this.linghtsp.mouseEnabled = false;
            var _loc_3:* = [new GlowFilter(6038897, 1, 2, 2, 10)];
            this.tlabel = new ClickLabel(this, 0, this.icon.height - 8, "", this.pickAward);
            this.tlabel.filters = _loc_3;
            this.tlabel.clickColor([16777215, 15590819]);
            this.itemsprite = new Sprite();
            this.slot1 = new CloneSlot(0, 32);
            this.itemsprite.addChild(this.slot1);
            this.slot1.x = 10;
            this.slot1.y = 15;
            this.slot1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.slot1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.slot2 = new CloneSlot(0, 32);
            this.itemsprite.addChild(this.slot2);
            this.slot2.x = 10;
            this.slot2.y = 50;
            this.slot2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.slot2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.s1 = new Label(this.itemsprite, 50, 20);
            this.s2 = new Label(this.itemsprite, 50, 55);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GIFT_BAG_COUTDOWN, this.backTime);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RECEIVE_GIFT_BAG, this.backItem);
            return;
        }// end function

        public function get timeNum() : int
        {
            return this._timeNum;
        }// end function

        public function set timeNum(param1:int) : void
        {
            this._timeNum = param1;
            this._writeTime = Config.now.getTime() + param1 * 1000;
            this.awardtime.stop();
            if (param1 > 0)
            {
                this.awardtime.start();
                this.icon.bitmapData = this.btd1;
                if (this.linghtsp.parent != null)
                {
                    this.linghtsp.parent.removeChild(this.linghtsp);
                }
            }
            else
            {
                this.timeNum = 5;
            }
            return;
        }// end function

        private function timeAdd(event:TimerEvent) : void
        {
            if (this._timeNum <= 0)
            {
                this.awardtime.stop();
                this.icon.bitmapData = this.btd2;
                this.addChild(this.linghtsp);
                this.tlabel.text = "<font size=\'14\'>" + Config.language("AwardPanel", 1) + "</font>";
                this.tlabel.mouseEnabled = true;
                this.tlabel.mouseChildren = true;
                GuideUI.testDoId(222, this.icon);
            }
            else
            {
                var _loc_2:* = this;
                var _loc_3:* = this._timeNum - 1;
                _loc_2._timeNum = _loc_3;
                this.tlabel.text = this.checkTime();
                this.tlabel.mouseEnabled = false;
                this.tlabel.mouseChildren = false;
            }
            this.tlabel.x = (this.icon.width - this.tlabel.width) / 2;
            return;
        }// end function

        private function checkTime() : String
        {
            var _loc_1:* = "";
            if (this._clickNum <= 0)
            {
                this._timeNum = int((this._writeTime - Config.now.getTime()) / 1000);
                this._clickNum = 100;
            }
            else
            {
                var _loc_2:* = this;
                var _loc_3:* = this._clickNum - 1;
                _loc_2._clickNum = _loc_3;
            }
            _loc_1 = "<font size=\'12\'>" + Config.timeShow(this._timeNum) + "</font>";
            return _loc_1;
        }// end function

        private function pickAward(param1) : void
        {
            var _loc_2:* = null;
            if (this._timeNum > 0)
            {
                Config.message(Config.language("AwardPanel", 2));
            }
            else
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_RECEIVE_GIFT_BAG);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function backTime(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._pickNum = _loc_2.readByte();
            this.timeNum = _loc_2.readUnsignedInt();
            if (this._pickNum >= 7)
            {
                this.contain.removeChild(this);
                if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                {
                    Config.ui._qqVipPanel.reSetXY(false);
                }
            }
            else
            {
                this.contain.addChild(this);
                if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                {
                    Config.ui._qqVipPanel.reSetXY(true);
                }
            }
            return;
        }// end function

        private function backItem(event:SocketEvent) : void
        {
            if (this.slot1.item != null)
            {
                this.slot1.item.destroy();
                this.slot1.item = null;
            }
            if (this.slot2.item != null)
            {
                this.slot2.item.destroy();
                this.slot2.item = null;
            }
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            _loc_4.amount = _loc_2.readByte();
            this.slot1.item = _loc_4;
            this.s1.text = _loc_4.name + "[×" + _loc_4.amount + "]";
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            _loc_6.amount = _loc_2.readByte();
            this.slot2.item = _loc_6;
            this.s2.text = _loc_6.name + "[×" + _loc_6.amount + "]";
            this._pickNum = _loc_2.readByte();
            this.timeNum = _loc_2.readUnsignedInt();
            AlertUI.alert(Config.language("AwardPanel", 3), Config.language("AwardPanel", 4), [Config.language("AwardPanel", 5)], null, null, false, true, false, this.itemsprite, false, null, null, null, 342, 190);
            if (this._pickNum >= 7)
            {
                this.contain.removeChild(this);
            }
            else
            {
                this.contain.addChild(this);
            }
            GuideUI.testDoId(223, AlertUI._ui._btnArray[0]);
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function iconRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            if (this._timeNum > 0)
            {
                _loc_2 = event.currentTarget;
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(Config.language("AwardPanel", 6), new Rectangle(_loc_3.x, _loc_3.y, 100, 100), true, 0, 220);
            }
            return;
        }// end function

        private function iconRollOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

    }
}
