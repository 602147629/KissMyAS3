package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class SystemUI extends Sprite
    {
        public var _charPB:PushButton;
        public var _bagPB:PushButton;
        public var _bagPB1:PushButton;
        public var _producePB:PushButton;
        public var _skillPB:PushButton;
        public var _taskPB:PushButton;
        public var _guildkPB:PushButton;
        public var _tempPB:PushButton;
        public var _petPB:PushButton;
        public var _godPB:PushButton;
        public var _followerPB:PushButton;
        public var bg:Table;
        private var _godOpened:Boolean = false;
        private var _followerOpened:Boolean = false;
        private var _bagpictrueflag:Boolean = false;

        public function SystemUI()
        {
            this.init();
            this.cacheAsBitmap = true;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GODATTRIBUTE_OPENED, this.iforopen);
            return;
        }// end function

        public function init()
        {
            this.bg = new Table("table7");
            this.bg.y = -22;
            this.bg.resize(290);
            addChild(this.bg);
            mouseEnabled = false;
            var _loc_1:* = 10;
            this._charPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 1), Config.ui._charUI, "button1");
            this.setTip(this._charPB, Config.language("SystemUI", 2));
            _loc_1 = _loc_1 + 35;
            this._petPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 3), Config.ui._petPanel, "button5");
            this.setTip(this._petPB, Config.language("SystemUI", 4));
            this._followerPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 19), Config.ui._followcharui, "button10");
            this._followerPB.visible = false;
            this.setTip(this._followerPB, Config.language("SystemUI", 20));
            _loc_1 = _loc_1 + 35;
            this._bagPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 5), Config.ui._bagUI, "button2");
            this._bagPB.visible = true;
            this._bagPB1 = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 5), Config.ui._bagUI, "button22");
            this._bagPB1.visible = false;
            this.setTip(this._bagPB, Config.language("SystemUI", 6));
            this.setTip(this._bagPB1, Config.language("SystemUI", 6));
            _loc_1 = _loc_1 + 35;
            this._skillPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 7), Config.ui._skillUI, "button3");
            this.setTip(this._skillPB, Config.language("SystemUI", 8));
            this._godPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 17), Config.ui._godmade, "button9");
            this._godPB.visible = false;
            this.setTip(this._godPB, Config.language("SystemUI", 18));
            _loc_1 = _loc_1 + 35;
            this._taskPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 9), Config.ui._taskpanel, "button4");
            this.setTip(this._taskPB, Config.language("SystemUI", 10));
            _loc_1 = _loc_1 + 35;
            this._guildkPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 11), Config.ui._gangs, "button6");
            this.setTip(this._guildkPB, Config.language("SystemUI", 12));
            _loc_1 = _loc_1 + 35;
            this._tempPB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 13), Config.ui._friendUI, "button7");
            this.setTip(this._tempPB, Config.language("SystemUI", 14));
            _loc_1 = _loc_1 + 35;
            this._producePB = this.setmainbtn(_loc_1, -20, Config.language("SystemUI", 15), Config.ui._producepanel, "button8");
            this.setTip(this._producePB, Config.language("SystemUI", 16));
            return;
        }// end function

        private function setTip(param1, param2)
        {
            param1.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleSlotOver, param2, param1));
            param1.addEventListener(MouseEvent.ROLL_OUT, Config.create(this.handleSlotOut));
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleSlotOver(param1, param2, param3)
        {
            Holder.showInfo(param2, new Rectangle(param3.x + param3.parent.x, param3.y + param3.parent.y + 3, param3.width, param3.height), true);
            return;
        }// end function

        private function setmainbtn(param1:int, param2:int, param3:String, param4 = null, param5 = null, param6:int = -1)
        {
            var _loc_7:* = new PushButton(this, param1 + 10, param2, "", Config.create(this.switchOpenUI, param4, param6), Config.findUI("systemui")[param5]);
            new PushButton(this, param1 + 10, param2, "", Config.create(this.switchOpenUI, param4, param6), Config.findUI("systemui")[param5]).y = -new PushButton(this, param1 + 10, param2, "", Config.create(this.switchOpenUI, param4, param6), Config.findUI("systemui")[param5]).height;
            _loc_7.overshow = true;
            if (param5 == "button9")
            {
                _loc_7.visible = false;
            }
            return _loc_7;
        }// end function

        private function switchOpenUI(param1, param2, param3:int = -1) : void
        {
            if (param2 == null)
            {
                return;
            }
            if (param3 >= 0)
            {
                param2.selectPage(param3);
            }
            else
            {
                param2.switchOpen();
            }
            return;
        }// end function

        public function godOpen() : void
        {
            this._godOpened = true;
            this._godPB.visible = true;
            Config.ui._bagUI.godopen = 1;
            this.refresh();
            return;
        }// end function

        public function followerOpen() : void
        {
            this._followerOpened = true;
            this._followerPB.visible = true;
            this.refresh();
            return;
        }// end function

        public function bagpictrue(param1:Boolean) : void
        {
            this._bagpictrueflag = param1;
            if (this._bagpictrueflag)
            {
                this._bagPB1.visible = true;
                this._bagPB.visible = false;
            }
            else
            {
                this._bagPB1.visible = false;
                this._bagPB.visible = true;
            }
            return;
        }// end function

        private function iforopen(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 1)
            {
                this.godOpen();
            }
            return;
        }// end function

        private function refresh() : void
        {
            this.bg.resize(290 + (this._godOpened ? (35) : (0)) + (this._followerOpened ? (35) : (0)));
            var _loc_1:* = 10;
            this._charPB.x = _loc_1;
            _loc_1 = _loc_1 + 35;
            this._petPB.x = _loc_1;
            if (this._followerOpened)
            {
                _loc_1 = _loc_1 + 35;
                this._followerPB.x = _loc_1;
            }
            _loc_1 = _loc_1 + 35;
            this._bagPB.x = _loc_1;
            this._bagPB1.x = _loc_1;
            _loc_1 = _loc_1 + 35;
            this._skillPB.x = _loc_1;
            if (this._godOpened)
            {
                _loc_1 = _loc_1 + 35;
                this._godPB.x = _loc_1;
            }
            _loc_1 = _loc_1 + 35;
            this._taskPB.x = _loc_1;
            _loc_1 = _loc_1 + 35;
            this._guildkPB.x = _loc_1;
            _loc_1 = _loc_1 + 35;
            this._tempPB.x = _loc_1;
            _loc_1 = _loc_1 + 35;
            this._producePB.x = _loc_1;
            Main._main.resize();
            return;
        }// end function

    }
}
