package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class AutoDrug extends Window
    {
        private var hpIcon:ProgressBar;
        private var mpIcon:ProgressBar;
        private var hpbm:Bitmap;
        private var mpbm:Bitmap;
        private var hpBar:ProgressBar;
        private var hpBarLabel:Label;
        private var mpBar:ProgressBar;
        private var mpBarLabel:Label;
        private var hSlot1:CloneSlot;
        private var hSlot2:CloneSlot;
        private var mSlot1:CloneSlot;
        private var mSlot2:CloneSlot;
        private var hclick:ClickLabel;
        private var mclick:ClickLabel;
        private var hclick2:ClickLabel;
        private var mclick2:ClickLabel;
        private var hItemarr:Array;
        private var mItemarr:Array;
        public static var canBuy:Boolean = true;

        public function AutoDrug(param1:DisplayObjectContainer)
        {
            var _loc_2:* = null;
            super(param1);
            this.title = Config.language("AutoDrug", 1);
            resize(350, 200);
            this.initPanel();
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            if (this.stage != null)
            {
                this.setvalue();
            }
            return;
        }// end function

        private function initPanel() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PLAYER_HPMP_UPDATE_NOTICE, this.updateHM);
            var _loc_1:* = new Shape();
            this.addChild(_loc_1);
            _loc_1.graphics.beginFill(0, 0.2);
            _loc_1.graphics.drawRoundRect(10, 120, 325, 60, 5);
            _loc_1.graphics.endFill();
            this.hpIcon = new ProgressBar(this, 13, 54);
            this.hpIcon.gradientFillDirection = Math.PI;
            this.hpIcon.roundCorner = 5;
            this.hpIcon.color = 103481221;
            this.hpIcon.subColor = 1681495;
            this.hpIcon.width = 15;
            this.hpIcon.height = 10;
            this.hpIcon.bgColor = 5459528;
            this.hpIcon.maximum = 2;
            this.hpIcon.value = 2;
            this.mpIcon = new ProgressBar(this, 13, 94);
            this.mpIcon.gradientFillDirection = Math.PI;
            this.mpIcon.roundCorner = 5;
            this.mpIcon.color = 4972287;
            this.mpIcon.subColor = 26519;
            this.mpIcon.width = 15;
            this.mpIcon.height = 10;
            this.mpIcon.bgColor = 5459528;
            this.mpIcon.maximum = 2;
            this.mpIcon.value = 2;
            this.hpbm = new Bitmap();
            this.addChild(this.hpbm);
            this.hpbm.x = 10;
            this.hpbm.y = 50;
            this.hpbm.bitmapData = Config.findsysUI("headui/hm", 21, 17);
            this.mpbm = new Bitmap();
            this.addChild(this.mpbm);
            this.mpbm.x = 10;
            this.mpbm.y = 90;
            this.mpbm.bitmapData = Config.findsysUI("headui/hm", 21, 17);
            var _loc_2:* = new Label(this, 40, 50, Config.language("AutoDrug", 2));
            var _loc_3:* = new Label(this, 40, 90, Config.language("AutoDrug", 3));
            this.hpBar = new ProgressBar(this, 100, 50);
            this.hpBar.height = 20;
            this.hpBar.width = 140;
            this.hpBar.gradientFillDirection = Math.PI;
            this.hpBar.roundCorner = 1;
            this.hpBar.color = 103481221;
            this.hpBar.subColor = 1681495;
            this.hpBarLabel = new Label(this, 100, 50);
            this.hpBarLabel.textColor = 16777215;
            this.hpBarLabel.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this.mpBar = new ProgressBar(this, 100, 90);
            this.mpBar.height = 20;
            this.mpBar.width = 140;
            this.mpBar.gradientFillDirection = Math.PI;
            this.mpBar.roundCorner = 1;
            this.mpBar.color = 4972287;
            this.mpBar.subColor = 26519;
            this.mpBarLabel = new Label(this, 100, 90);
            this.mpBarLabel.textColor = 16777215;
            this.mpBarLabel.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this.hSlot1 = new CloneSlot(1, 32);
            this.hSlot1.x = 260;
            this.hSlot1.y = 40;
            this.addChild(this.hSlot1);
            this.hSlot1.addEventListener("dblClick", this.handleSlotClick);
            this.hSlot1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.hSlot1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.hSlot2 = new CloneSlot(2, 32);
            this.hSlot2.x = 300;
            this.hSlot2.y = 40;
            this.addChild(this.hSlot2);
            this.hSlot2.addEventListener("dblClick", this.handleSlotClick);
            this.hSlot2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.hSlot2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.mSlot1 = new CloneSlot(3, 32);
            this.mSlot1.x = 260;
            this.mSlot1.y = 80;
            this.addChild(this.mSlot1);
            this.mSlot1.addEventListener("dblClick", this.handleSlotClick);
            this.mSlot1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.mSlot1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.mSlot2 = new CloneSlot(4, 32);
            this.mSlot2.x = 300;
            this.mSlot2.y = 80;
            this.addChild(this.mSlot2);
            this.mSlot2.addEventListener("dblClick", this.handleSlotClick);
            this.mSlot2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.mSlot2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            var _loc_4:* = null;
            if (canBuy)
            {
                _loc_4 = this;
            }
            var _loc_5:* = Config.language("AutoDrug", 4);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                _loc_5 = Config.language("AutoDrug", 7);
            }
            this.hclick = new ClickLabel(_loc_4, 260, 40, _loc_5, Config.create(this.fastBuy, 1), true);
            this.hclick.clickColor([1681495, 16544]);
            this.mclick = new ClickLabel(_loc_4, 260, 80, _loc_5, Config.create(this.fastBuy, 2), true);
            this.mclick.clickColor([224411, 16544]);
            this.hclick2 = new ClickLabel(_loc_4, 260, 60, Config.language("AutoDrug", 6), Config.create(this.fastBuy, 3), true);
            this.hclick2.clickColor([1681495, 16544]);
            this.mclick2 = new ClickLabel(_loc_4, 260, 100, Config.language("AutoDrug", 6), Config.create(this.fastBuy, 4), true);
            this.mclick2.clickColor([224411, 16544]);
            var _loc_6:* = new TextAreaUI(this, 20, 130, 320, 50);
            new TextAreaUI(this, 20, 130, 320, 50).text = Config.language("AutoDrug", 5);
            this.hItemarr = [{id:66001, num:0}, {id:880501, num:0}, {id:66002, num:0}, {id:880502, num:0}, {id:66003, num:0}, {id:880503, num:0}, {id:66004, num:0}, {id:880504, num:0}];
            this.mItemarr = [{id:66501, num:0}, {id:880601, num:0}, {id:66502, num:0}, {id:880602, num:0}, {id:66503, num:0}, {id:880603, num:0}];
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleSlotClick(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = Config.ui._bagUI.findItemBybaseId(_loc_2.item._itemData.id);
                if (_loc_3 != null)
                {
                    Config.ui._charUI.useItem(_loc_3);
                }
            }
            return;
        }// end function

        public function autoUpdate(param1:int = 1) : void
        {
            if (this.stage != null)
            {
                this.setvalue();
            }
            if (param1 == 1)
            {
                if (Config.player.autoHp > 0)
                {
                    Config.ui._playerHead.setbarColor(1, true);
                }
                else
                {
                    Config.ui._playerHead.setbarColor(1, false);
                }
                if (Config.player.autoMp > 0)
                {
                    Config.ui._playerHead.setbarColor(2, true);
                }
                else
                {
                    Config.ui._playerHead.setbarColor(2, false);
                }
            }
            return;
        }// end function

        private function setvalue() : void
        {
            var _loc_4:* = null;
            this.hpBar.maximum = 100000000;
            this.hpBar.value = Config.player.autoHp;
            this.hpBarLabel.text = Config.coinShow(this.hpBar.value) + " / " + Config.coinShow(this.hpBar.maximum);
            this.hpBarLabel.x = this.hpBar.x + (this.hpBar.width - this.hpBarLabel.width) / 2;
            this.mpBar.maximum = 1000000;
            this.mpBar.value = Config.player.autoMp;
            this.mpBarLabel.text = Config.coinShow(this.mpBar.value) + " / " + Config.coinShow(this.mpBar.maximum);
            this.mpBarLabel.x = this.mpBar.x + (this.mpBar.width - this.mpBarLabel.width) / 2;
            if (this.hSlot1.item != null)
            {
                this.hSlot1.item.destroy();
            }
            if (this.hSlot2.item != null)
            {
                this.hSlot2.item.destroy();
            }
            if (this.mSlot1.item != null)
            {
                this.mSlot1.item.destroy();
            }
            if (this.mSlot2.item != null)
            {
                this.mSlot2.item.destroy();
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.hItemarr.length)
            {
                
                this.hItemarr[_loc_2].num = Config.ui._charUI.getItemAmount(int(this.hItemarr[_loc_2].id));
                if (this.hItemarr[_loc_2].num > 0)
                {
                    _loc_1 = _loc_1 + 1;
                    _loc_4 = Item.newItem(Config._itemMap[int(this.hItemarr[_loc_2].id)], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_4.display();
                    _loc_4.amount = this.hItemarr[_loc_2].num;
                    if (_loc_1 == 1)
                    {
                        this.hSlot1.item = _loc_4;
                    }
                    else
                    {
                        this.hSlot2.item = _loc_4;
                    }
                }
                if (_loc_1 >= 2)
                {
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            if (_loc_1 > 0)
            {
                this.hSlot1.visible = true;
                this.hSlot2.visible = true;
                this.hclick.visible = false;
                this.hclick2.visible = false;
            }
            else
            {
                this.hSlot1.visible = false;
                this.hSlot2.visible = false;
                this.hclick.visible = true;
                this.hclick2.visible = true;
            }
            _loc_1 = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this.mItemarr.length)
            {
                
                this.mItemarr[_loc_3].num = Config.ui._charUI.getItemAmount(int(this.mItemarr[_loc_3].id));
                if (this.mItemarr[_loc_3].num > 0)
                {
                    _loc_1 = _loc_1 + 1;
                    _loc_4 = Item.newItem(Config._itemMap[int(this.mItemarr[_loc_3].id)], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_4.display();
                    _loc_4.amount = this.mItemarr[_loc_3].num;
                    if (_loc_1 == 1)
                    {
                        this.mSlot1.item = _loc_4;
                    }
                    else
                    {
                        this.mSlot2.item = _loc_4;
                    }
                }
                if (_loc_1 >= 2)
                {
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_1 > 0)
            {
                this.mSlot1.visible = true;
                this.mSlot2.visible = true;
                this.mclick.visible = false;
                this.mclick2.visible = false;
            }
            else
            {
                this.mSlot1.visible = false;
                this.mSlot2.visible = false;
                this.mclick.visible = true;
                this.mclick2.visible = true;
            }
            _loc_1 = 0;
            if (Config.player.autoHp > 0)
            {
                this.hpIcon.filters = [];
            }
            else
            {
                this.hpIcon.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
            }
            if (Config.player.autoMp > 0)
            {
                this.mpIcon.filters = [];
            }
            else
            {
                this.mpIcon.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
            }
            return;
        }// end function

        private function fastBuy(event:TextEvent, param2:int) : void
        {
            if (param2 == 1)
            {
                Config.ui._shopmail.openListPanel(3);
                Config.ui._shopmail.itemcontain.verticalScrollPosition = 10;
            }
            else if (param2 == 2)
            {
                Config.ui._shopmail.openListPanel(3);
                Config.ui._shopmail.itemcontain.verticalScrollPosition = 20;
            }
            else
            {
                Config.ui._shopmail.giftcoupons();
                Config.ui._shopmail.open();
            }
            return;
        }// end function

        private function updateHM(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readInt();
            var _loc_3:* = event.data.readInt();
            if (_loc_2 > 0)
            {
                Config.player.burstWord("+" + _loc_2, Config.player, 100, 52224, 16);
            }
            if (_loc_3 > 0)
            {
                Config.player.burstWord("+" + _loc_3, Config.player, 100, 57087, 16);
            }
            return;
        }// end function

        override public function testGuide()
        {
            Config.startLoop(this.subTestGuide);
            return;
        }// end function

        private function subTestGuide(param1)
        {
            Config.stopLoop(this.subTestGuide);
            if (canBuy && (GuideUI.testId(57) || GuideUI.testId(58)))
            {
                if (this.hclick.visible)
                {
                    GuideUI.testDoId(58, this.hclick);
                }
                else
                {
                    GuideUI.testDoId(57, this.hSlot1);
                }
            }
            if (canBuy && (GuideUI.testId(60) || GuideUI.testId(61)))
            {
                if (this.mclick.visible)
                {
                    GuideUI.testDoId(61, this.mclick);
                }
                else
                {
                    GuideUI.testDoId(60, this.mSlot1);
                }
            }
            return;
        }// end function

    }
}
