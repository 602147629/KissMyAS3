package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class InterPkPanel extends Window
    {
        private var maxDayMoneyNum:int = 50;
        private var _pkSource:int;
        private var _DayMoneyNum:int;
        private var _winNum:int;
        private var _pkBill:int;
        private var nameText:Label;
        private var _unitClip:UnitClip;
        private var _horseClip:UnitClip;
        private var enterBtn:PushButton;
        private var leftDayNumText:Label;
        private var t1:Label;
        private var t2:Label;
        private var t3:Label;
        private var tlgText:Label;
        private var _pkStatus:int = 0;
        private var timeValue:int = 0;
        private var pkTimer:Timer;
        private var _alert:Object;
        private var intext:Label;
        private var resultSp:Sprite;
        private var rtext:Label;
        private var rscore:Label;
        private var rslot:CloneSlot;
        private var rmoneyText:Label;
        private var rtime:Label;
        private var rgettimes:Label;
        private var _gettimes:int = 0;
        private var rArr:Array;
        private var TimeSp:Sprite;
        private var TimeLabel:Label;
        private var leftDayNumboxText:Label;

        public function InterPkPanel(param1:DisplayObjectContainer = null)
        {
            this.rArr = [];
            super(param1);
            this.initpanel();
            this.initSocket();
            return;
        }// end function

        override public function testGuide()
        {
            GuideUI.testDoId(5, this.enterBtn);
            return;
        }// end function

        private function initSocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ARENA1V1_NOTICE, this.backNotice);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ARENA_COUNTDOWN, this.CountDown);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ARENA_RESULT, this.backPkResult);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CROSS_FORBID, this.backPkErr);
            return;
        }// end function

        private function initpanel() : void
        {
            resize(397, 370);
            this.title = Config.language("InterPkPanel", 1);
            this.nameText = new Label(this, 50, 30);
            this.nameText.html = true;
            var _loc_1:* = new PushButton(this, 60, 180, Config.language("InterPkPanel", 2), this.openBill);
            _loc_1.width = 60;
            _loc_1.setTable("table18", "table31");
            _loc_1.textColor = Style.GOLD_FONT;
            _loc_1.color = 16777215;
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(16777215, 0.3);
            _loc_2.graphics.drawRoundRect(180, 28, 206, 180, 8);
            _loc_2.graphics.drawRoundRect(10, 215, 376, 126, 3);
            _loc_2.graphics.endFill();
            this.addChild(_loc_2);
            this.t1 = new Label(this, 190, 40);
            this.t1.html = true;
            this.t2 = new Label(this, 190, 70);
            this.t2.html = true;
            this.t3 = new Label(this, 190, 100);
            this.t3.html = true;
            var _loc_3:* = new Label(this, 20, 230 - 7, Config.language("InterPkPanel", 3));
            var _loc_4:* = new Label(this, 20, 250 - 7, Config.language("InterPkPanel", 4));
            var _loc_5:* = new Label(this, 20, 270 - 7, Config.language("InterPkPanel", 5));
            var _loc_6:* = new Label(this, 110, 270 - 7, Config.language("InterPkPanel", 6));
            new Label(this, 110, 270 - 7, Config.language("InterPkPanel", 6)).html = true;
            var _loc_7:* = new Label(this, 110, 230 - 7, Config.language("InterPkPanel", 58));
            var _loc_8:* = new Label(this, 110, 250 - 7, Config.language("InterPkPanel", 59));
            this.tlgText = new Label(this, 190, 150);
            this.tlgText.html = true;
            this.enterBtn = new PushButton(this, 240, 180, Config.language("InterPkPanel", 7), this.doPkFuc);
            this.enterBtn.width = 80;
            this.leftDayNumText = new Label(this, 20, 344);
            this.leftDayNumboxText = new Label(this, 190, 344, Config.language("InterPkPanel", 60, 15));
            this.pkTimer = new Timer(1000);
            this.pkTimer.addEventListener(TimerEvent.TIMER, this.showTime);
            this.intext = new Label(null, 0, 0);
            this.intext.html = true;
            this.resultSp = new Sprite();
            this.rtext = new Label(this.resultSp, 70, 0);
            this.rtext.html = true;
            var _loc_9:* = new Label(this.resultSp, 5, 30, Config.language("InterPkPanel", 8));
            this.rscore = new Label(this.resultSp, 70, 28);
            this.rscore.html = true;
            var _loc_10:* = new Label(this.resultSp, 5, 70, Config.language("InterPkPanel", 9));
            this.rslot = new CloneSlot(0, 30);
            this.resultSp.addChild(this.rslot);
            this.rslot.x = 68;
            this.rslot.y = 60;
            this.rslot.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.rslot.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.rmoneyText = new Label(this.resultSp, 5, 100);
            this.rtime = new Label(this.resultSp, 5, 130);
            this.rtime.html = true;
            this.rgettimes = new Label(this.resultSp, 100, 70);
            this.rgettimes.html = true;
            this.TimeSp = new Sprite();
            this.TimeSp.graphics.beginFill(0, 0.3);
            this.TimeSp.graphics.drawRoundRect(0, 0, 90, 25, 4);
            this.TimeSp.graphics.endFill();
            this.TimeLabel = new Label(this.TimeSp, 10, 2);
            this.TimeLabel.textColor = 16777215;
            this._unitClip = UnitClip.newUnitClip();
            this._unitClip.changeDirectionTo(1);
            this._unitClip.changeStateTo("idle");
            this._unitClip.x = 90;
            this._unitClip.y = 140;
            this._horseClip = UnitClip.newUnitClip();
            this._horseClip.changeStateTo("idle");
            this._horseClip.changeDirectionTo(1);
            this._horseClip.x = 90;
            this._horseClip.y = 140 + 28;
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.reshowPanel();
            return;
        }// end function

        override public function close()
        {
            super.close();
            return;
        }// end function

        private function reshowPanel() : void
        {
            this.nameText.text = "<p align=\'center\'><font size=\'14\'><b>" + Config.player.name + "</b></font>\n" + "[" + Config.language("BillboardPanel", 39, Config.player.level, Config._jobTitleMap[Config.player.job]) + "]</p>";
            this.nameText.x = (170 - this.nameText.width) / 2;
            if (Config.player.horse != null)
            {
                this._horseClip.clone(Config.player.horse);
                this.addChild(this._horseClip);
            }
            else if (this._horseClip.parent != null)
            {
                this._horseClip.parent.removeChild(this._horseClip);
            }
            this._unitClip.clone(Config.player._img);
            this.addChild(this._unitClip);
            if (Config.map._type != 22)
            {
                this.sendPkBill();
            }
            return;
        }// end function

        private function openBill(event:MouseEvent) : void
        {
            Config.ui._billboardpanel.opentype(13);
            return;
        }// end function

        public function leftInterPk() : void
        {
            if (this.pkStatus == 2 || this.pkStatus == 3 || this.pkStatus == 4)
            {
                if (this._alert != null)
                {
                    AlertUI.remove(this._alert);
                }
                this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 12), [Config.language("InterPkPanel", 13), Config.language("InterPkPanel", 14)], [this.sendLeftInterPk]);
            }
            else
            {
                this.sendLeftInterPk();
            }
            return;
        }// end function

        public function get pkStatus() : int
        {
            return this._pkStatus;
        }// end function

        public function set pkStatus(param1:int) : void
        {
            this._pkStatus = param1;
            this.pkTimer.stop();
            this.enterBtn.enabled = true;
            switch(param1)
            {
                case 0:
                {
                    this.tlgText.text = "";
                    this.enterBtn.label = Config.language("InterPkPanel", 7);
                    break;
                }
                case 1:
                {
                    this.enterBtn.label = Config.language("InterPkPanel", 15);
                    this.pkTimer.start();
                    break;
                }
                case 2:
                {
                    this.enterBtn.label = Config.language("InterPkPanel", 16);
                    this.pkTimer.start();
                    if (this._alert != null)
                    {
                        AlertUI.remove(this._alert);
                    }
                    if (Config.map._type == 0 || Config.map._type == 1 || Config.map._type == 2 || Config.map._type == 6 || Config.map._type == 10 || Config.map._type == 16 || Config.map._type == 17)
                    {
                        this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), "", [Config.language("InterPkPanel", 16), Config.language("InterPkPanel", 56)], [this.sendLogin], null, false, true, false, this.intext);
                        this.showTime();
                    }
                    else
                    {
                        this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 17), [Config.language("InterPkPanel", 13)]);
                    }
                    break;
                }
                case 3:
                {
                    if (this._alert != null)
                    {
                        AlertUI.remove(this._alert);
                    }
                    this.enterBtn.label = Config.language("InterPkPanel", 18);
                    this.pkTimer.start();
                    this.close();
                    break;
                }
                case 4:
                {
                    this.enterBtn.label = Config.language("InterPkPanel", 18);
                    Neon.show(String(Config.language("InterPkPanel", 19)));
                    this.pkTimer.start();
                    break;
                }
                case 5:
                {
                    this.enterBtn.label = Config.language("InterPkPanel", 18);
                    this.pkTimer.start();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function doPkFuc(event:MouseEvent) : void
        {
            switch(this.pkStatus)
            {
                case 0:
                {
                    if (Config.mapId > 1000000000 || Config._giftMap[Config.mapId] != null)
                    {
                        if (this._alert != null)
                        {
                            AlertUI.remove(this._alert);
                        }
                        this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 20), [Config.language("InterPkPanel", 13)]);
                        return;
                    }
                    this.sendSign();
                    break;
                }
                case 1:
                {
                    if (this._alert != null)
                    {
                        AlertUI.remove(this._alert);
                    }
                    this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 55), [Config.language("InterPkPanel", 13), Config.language("InterPkPanel", 14)], [this.cancelPk]);
                    break;
                }
                case 2:
                {
                    this.sendLogin();
                    break;
                }
                case 3:
                case 4:
                case 5:
                {
                    this.leftInterPk();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sendSign(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ARENA1V1_SIGN);
            ClientSocket.send(_loc_2);
            if (!this._opening)
            {
                this.open();
            }
            return;
        }// end function

        private function sendLogin(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ARENA1V1_IN);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backSign(param1:int) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param1 == 0 || param1 == 2)
            {
                _loc_2 = Config.now.getTime() + 5 * 60 * 1000;
                _loc_3 = Config.now;
                _loc_3.setTime(_loc_2);
                _loc_4 = int(_loc_3.getMinutes() / 5) * 5;
                _loc_3.setMinutes(_loc_4, 0, 0);
                this.timeValue = Number(_loc_3.getTime() / 1000);
                this.pkStatus = 1;
            }
            else
            {
                this.pkStatus = 0;
            }
            return;
        }// end function

        private function backNotice(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedByte();
            if (_loc_2 == 0)
            {
                Config.message(Config.language("InterPkPanel", 22));
            }
            else if (_loc_2 == 1)
            {
                this.pkStatus = 0;
            }
            else
            {
                Config.message(Config.language("InterPkPanel", 25));
                this.pkStatus = 0;
            }
            return;
        }// end function

        private function CountDown(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            this.timeValue = _loc_5;
            this.pkStatus = _loc_3 + 2;
            return;
        }// end function

        private function sendLeftInterPk(event:MouseEvent = null) : void
        {
            this._gettimes = 0;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ARENA_LEAVE);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function showTime(event:TimerEvent = null) : void
        {
            if (Config.now.getTime() / 1000 <= this.timeValue)
            {
            }
            else
            {
                this.pkTimer.stop();
                if (this.pkStatus == 5)
                {
                    this.sendLeftInterPk();
                }
                if (this.pkStatus == 1)
                {
                    this.sendSign();
                }
            }
            switch(this.pkStatus)
            {
                case 0:
                {
                    this.tlgText.text = "";
                    this.pkTimer.stop();
                    break;
                }
                case 1:
                {
                    this.tlgText.text = Config.language("InterPkPanel", 26, Config.timePoint(this.timeValue, 3));
                    break;
                }
                case 2:
                {
                    this.intext.text = Config.language("InterPkPanel", 27, Config.timePoint(this.timeValue, 3));
                    this.tlgText.text = Config.language("InterPkPanel", 28, Config.timePoint(this.timeValue, 3));
                    if (Config.map._type == 22)
                    {
                        this.TimeLabel.text = Config.language("InterPkPanel", 57, Config.timePoint(this.timeValue, 3));
                    }
                    break;
                }
                case 3:
                {
                    if (Config.now.getTime() / 1000 < this.timeValue)
                    {
                        Neon.show(String(Config.timePoint(this.timeValue, 1)));
                    }
                    this.tlgText.text = Config.language("InterPkPanel", 29, Config.timePoint(this.timeValue, 3));
                    this.TimeLabel.text = Config.language("InterPkPanel", 30);
                    break;
                }
                case 4:
                {
                    this.tlgText.text = Config.language("InterPkPanel", 31, Config.timePoint(this.timeValue, 3));
                    this.TimeLabel.text = Config.language("InterPkPanel", 32, Config.timePoint(this.timeValue, 2));
                    break;
                }
                case 5:
                {
                    this.tlgText.text = Config.language("InterPkPanel", 33, Config.timePoint(this.timeValue, 3));
                    this.rtime.text = Config.language("InterPkPanel", 34, Config.timePoint(this.timeValue, 2));
                    this.TimeLabel.text = Config.language("InterPkPanel", 35, Config.timePoint(this.timeValue, 2));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function backPkResult(event:SocketEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = event.data.readUnsignedByte();
            var _loc_3:* = event.data.readInt();
            this.rscore.text = "</font><font size=\'16\' color=\'#bd2d06\'><b>" + String(_loc_3) + "</b></font>";
            this.rArr.length = 0;
            if (_loc_2 == 1)
            {
                this.rtext.text = Config.language("InterPkPanel", 36);
                if (this._gettimes > 0)
                {
                    _loc_5 = Config._ListExp[Config.player.level].arenaSuperWinItem;
                }
                else
                {
                    this.leftDayNumboxText.text = Config.language("InterPkPanel", 60, 0);
                    _loc_5 = Config._ListExp[Config.player.level].arenaWinItem;
                }
                _loc_4 = Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_4.display();
                this.rmoneyText.text = Config.language("InterPkPanel", 39, int(this.maxDayMoneyNum - this._DayMoneyNum) > 0 ? (Config._ListExp[Config.player.level].arenaWinMoney) : (0), int(this.maxDayMoneyNum - this._DayMoneyNum));
                this.rArr.push(Config.language("InterPkPanel", 48));
                this.rArr.push(Config.language("InterPkPanel", 49, _loc_3));
                if (this.maxDayMoneyNum - this._DayMoneyNum > 0)
                {
                    this.rArr.push(Config.language("InterPkPanel", 50, Config._ListExp[Config.player.level].arenaWinMoney));
                }
                this.rArr.push(_loc_4._data.name);
                Config.ui._mesHistoryPanel.addHistory(Config.language("InterPkPanel", 51, _loc_3));
            }
            else if (_loc_2 == 2)
            {
                this.rtext.text = Config.language("InterPkPanel", 37);
                if (this._gettimes > 0)
                {
                    _loc_5 = Config._ListExp[Config.player.level].arenaSuperLoseItem;
                }
                else
                {
                    this.leftDayNumboxText.text = Config.language("InterPkPanel", 60, 0);
                    _loc_5 = Config._ListExp[Config.player.level].arenaLoseItem;
                }
                _loc_4 = Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_4.display();
                this.rmoneyText.text = Config.language("InterPkPanel", 39, int(this.maxDayMoneyNum - this._DayMoneyNum) > 0 ? (Config._ListExp[Config.player.level].arenaLoseMoney) : (0), int(this.maxDayMoneyNum - this._DayMoneyNum));
                this.rArr.push(Config.language("InterPkPanel", 48));
                this.rArr.push(Config.language("InterPkPanel", 49, _loc_3));
                if (this.maxDayMoneyNum - this._DayMoneyNum > 0)
                {
                    this.rArr.push(Config.language("InterPkPanel", 50, Config._ListExp[Config.player.level].arenaLoseMoney));
                }
                this.rArr.push(_loc_4._data.name);
                Config.ui._mesHistoryPanel.addHistory(Config.language("InterPkPanel", 51, _loc_3));
            }
            else if (_loc_2 == 3)
            {
                this.rtext.text = Config.language("InterPkPanel", 38);
                if (this._gettimes > 0)
                {
                    _loc_5 = Config._ListExp[Config.player.level].arenaSuperLoseItem;
                }
                else
                {
                    this.leftDayNumboxText.text = Config.language("InterPkPanel", 60, 0);
                    _loc_5 = Config._ListExp[Config.player.level].arenaLoseItem;
                }
                _loc_4 = Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_4.display();
                this.rmoneyText.text = Config.language("InterPkPanel", 39, int(this.maxDayMoneyNum - this._DayMoneyNum) > 0 ? (Config._ListExp[Config.player.level].arenaLoseMoney) : (0), int(this.maxDayMoneyNum - this._DayMoneyNum));
                this.rArr.push(Config.language("InterPkPanel", 48));
                this.rArr.push(Config.language("InterPkPanel", 49, _loc_3));
                if (this.maxDayMoneyNum - this._DayMoneyNum > 0)
                {
                    this.rArr.push(Config.language("InterPkPanel", 50, Config._ListExp[Config.player.level].arenaLoseMoney));
                }
                this.rArr.push(_loc_4._data.name);
                Config.ui._mesHistoryPanel.addHistory(Config.language("InterPkPanel", 51, _loc_3));
            }
            else if (_loc_2 == 4)
            {
                if (this._alert != null)
                {
                    AlertUI.remove(this._alert);
                }
                this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 46, "</font><font size=\'16\' color=\'#bd2d06\'><b>" + String(_loc_3) + "</b></font>"), [Config.language("InterPkPanel", 13)]);
                this.pkStatus = 0;
                return;
            }
            else
            {
                this.rtext.text = Config.language("InterPkPanel", 47);
                if (this._gettimes > 0)
                {
                    _loc_5 = Config._ListExp[Config.player.level].arenaSuperWinItem;
                }
                else
                {
                    this.leftDayNumboxText.text = Config.language("InterPkPanel", 60, 0);
                    _loc_5 = Config._ListExp[Config.player.level].arenaWinItem;
                }
                _loc_4 = Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_4.display();
                this.rmoneyText.text = Config.language("InterPkPanel", 39, int(this.maxDayMoneyNum - this._DayMoneyNum) > 0 ? (Config._ListExp[Config.player.level].arenaWinMoney) : (0), int(this.maxDayMoneyNum - this._DayMoneyNum - 1));
                this.rArr.push(Config.language("InterPkPanel", 48));
                this.rArr.push(Config.language("InterPkPanel", 49, _loc_3));
                if (this.maxDayMoneyNum - this._DayMoneyNum > 0)
                {
                    this.rArr.push(Config.language("InterPkPanel", 50, Config._ListExp[Config.player.level].arenaWinMoney));
                }
                this.rArr.push(_loc_4._data.name);
                this.pkStatus = 0;
                this.rtime.text = Config.language("InterPkPanel", 52);
                Config.ui._mesHistoryPanel.addHistory(Config.language("InterPkPanel", 51, _loc_3));
                _loc_6 = 0;
                while (_loc_6 < this.rArr.length)
                {
                    
                    Config.message(this.rArr[_loc_6]);
                    _loc_6 = _loc_6 + 1;
                }
            }
            if (this.rslot.item != null)
            {
                this.rslot.item.destroy();
            }
            this.rslot.item = _loc_4;
            if (this._alert != null)
            {
                AlertUI.remove(this._alert);
            }
            if (_loc_2 == 5)
            {
                this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), "", [Config.language("InterPkPanel", 7), Config.language("InterPkPanel", 23)], [this.sendSign], null, false, true, false, this.resultSp);
            }
            else
            {
                if (this._gettimes <= 0)
                {
                    this.rgettimes.text = "";
                }
                this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), "", [Config.language("InterPkPanel", 40)], [this.sendLeftInterPk], null, false, true, false, this.resultSp);
            }
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

        public function get pkSource() : int
        {
            return this._pkSource;
        }// end function

        public function set pkSource(param1:int) : void
        {
            this._pkSource = param1;
            this.t2.text = Config.language("InterPkPanel", 41, this._pkSource);
            return;
        }// end function

        public function get DayMoneyNum() : int
        {
            return this._DayMoneyNum;
        }// end function

        public function set DayMoneyNum(param1:int) : void
        {
            this._DayMoneyNum = param1;
            this.leftDayNumText.text = Config.language("InterPkPanel", 42, int(this.maxDayMoneyNum - this._DayMoneyNum));
            return;
        }// end function

        public function get winNum() : int
        {
            return this._winNum;
        }// end function

        public function set winNum(param1:int) : void
        {
            this._winNum = param1;
            this.t3.text = Config.language("InterPkPanel", 43, this._winNum);
            return;
        }// end function

        public function addPkTime(param1:Radar) : void
        {
            param1.addChild(this.TimeSp);
            this.TimeSp.x = -250;
            this.TimeSp.y = 115;
            this.TimeLabel.text = Config.language("InterPkPanel", 53);
            this.enterBtn.label = Config.language("InterPkPanel", 53);
            this.enterBtn.enabled = false;
            return;
        }// end function

        public function removePkTime() : void
        {
            if (this.TimeSp.parent != null)
            {
                this.TimeSp.parent.removeChild(this.TimeSp);
            }
            return;
        }// end function

        public function backLeftPk() : void
        {
            this.pkStatus = 0;
            if (this._alert != null)
            {
                AlertUI.remove(this._alert);
            }
            this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 44), [Config.language("InterPkPanel", 13), Config.language("InterPkPanel", 23)], [this.sendSign]);
            var _loc_1:* = 0;
            while (_loc_1 < this.rArr.length)
            {
                
                Config.message(this.rArr[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function get pkBill() : int
        {
            return this._pkBill;
        }// end function

        public function set pkBill(param1:int) : void
        {
            var _loc_2:* = null;
            this._pkBill = param1;
            if (this._pkBill == 0)
            {
                _loc_2 = Config.language("InterPkPanel", 45);
            }
            else
            {
                _loc_2 = String(this._pkBill);
            }
            this.t1.text = Config.language("InterPkPanel", 10, _loc_2);
            return;
        }// end function

        private function sendPkBill() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_GETTOPINFO);
            _loc_1.add8(51);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function backPkErr(event:SocketEvent) : void
        {
            if (this._alert != null)
            {
                AlertUI.remove(this._alert);
            }
            this._alert = AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 54), [Config.language("InterPkPanel", 13)]);
            return;
        }// end function

        private function cancelPk(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ARENA1V1_CANCEL);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backCancelPk(param1:int) : void
        {
            if (param1 == 0)
            {
                this.pkStatus = 0;
            }
            return;
        }// end function

        public function set gettimes(param1:int)
        {
            if (param1 > 0)
            {
                this._gettimes = 15 - param1;
                if (this._gettimes < 0)
                {
                    this._gettimes = 0;
                }
                this.rgettimes.text = Config.language("InterPkPanel", 61, this._gettimes);
                this.leftDayNumboxText.text = Config.language("InterPkPanel", 60, this._gettimes);
            }
            return;
        }// end function

    }
}
