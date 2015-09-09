package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class ToAirPanel extends Window
    {
        private var maxFloor1:int = 100;
        private var maxFloor2:int = 200;
        private var maxFloor3:int = 300;
        private var _flo:int = 0;
        private var _connt:int = 0;
        private var _connt2:int = 0;
        private var _connt3:int = 0;
        private var _connt4:int = 0;
        private var thisFloor:int = 1;
        private var numLabel:Label;
        private var airNumStepper:NumericStepper;
        private var _alert:Object;
        private var _enterPB:PushButton;
        private var titleList:DataGridUI;
        private var titleArr:Array;
        private var titleArr1:Array;
        private var titleArr2:Array;
        private var titleArr3:Array;
        private var titleArr4:Array;
        private var topbtn:ButtonBar;
        private var prizebtn:PushButton;
        private var _selectpag:int;

        public function ToAirPanel(param1:DisplayObjectContainer)
        {
            super(param1);
            this.initpanel();
            this.initSocket();
            return;
        }// end function

        override public function testGuide()
        {
            GuideUI.testDoId(123, this._enterPB);
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            if (this._opening)
            {
                this.setflo(this._floor);
                this.thisFloor = this.airNumStepper.value;
            }
            return;
        }// end function

        private function initSocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ENTER_SKYTOWER, this.backLoginAir);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LEFT_SKYTOWER, this.BackLeftAir);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PASS_SKYTOWER, this.setFloor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKYTOWER_COUNT, this.setCount);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ENTER_SKYTOWER2, this.backLoginAir);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKYTOWER2_COUNT, this.setCount2);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ENTER_SKYTOWER3, this.backLoginAir);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKYTOWER3_COUNT, this.setCount3);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKYTOWER4_COUNT, this.setCount4);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            this.resize(340, 410);
            this.title = Config.language("ToAirPanel", 25);
            var _loc_1:* = new Label(this, 10, 30, Config.language("activePanel", 11));
            _loc_1.x = (340 - _loc_1.width) / 2;
            this.numLabel = new Label(this, 70, 50);
            this.topbtn = new ButtonBar(this, 15, 75, 0);
            this.topbtn.addTab(Config.language("ToAirPanel", 22), this.toair123);
            this.topbtn.addTab(Config.language("ToAirPanel", 23), this.toair123);
            this.topbtn.addTab(Config.language("ToAirPanel", 24), this.toair123);
            this.topbtn.addTab(Config.language("ToAirPanel", 29), this.toair123);
            this.topbtn.bartextcolor(0, 5977896);
            this.topbtn.bartextcolor(1, 5987163);
            this.topbtn.bartextcolor(2, 5987163);
            this.topbtn.bartextcolor(3, 5987163);
            this.topbtn.selectpage = 0;
            this.topbtn.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            var _loc_2:* = new Label(this, 15, 110, Config.language("activePanel", 13));
            var _loc_3:* = new PushButton(this, 85, 110, Config.language("activePanel", 14), this.smallNumSet);
            _loc_3.setTable("table18", "table31");
            _loc_3.textColor = Style.GOLD_FONT;
            _loc_3.width = 40;
            this.airNumStepper = new NumericStepper(this, 125, 110);
            this.airNumStepper.width = 120;
            this.airNumStepper.percent = false;
            this.airNumStepper.maxVisible = false;
            this.airNumStepper.addEventListener(Event.CHANGE, this.airNumChange);
            var _loc_4:* = new PushButton(this, 225, 110, Config.language("activePanel", 15), this.sendLogin);
            new PushButton(this, 225, 110, Config.language("activePanel", 15), this.sendLogin).width = 45;
            this._enterPB = _loc_4;
            this.prizebtn = new PushButton(this, 280, 110, Config.language("ToAirPanel", 20), this.sendprize);
            this.prizebtn.width = 45;
            this.prizebtn.visible = true;
            var _loc_5:* = [{datafield:"name", label:Config.language("ToAirPanel", 13), len:140, childmc:"nameSp"}, {datafield:"term", label:Config.language("ToAirPanel", 14), len:110}, {datafield:"level", label:Config.language("ToAirPanel", 15), len:70, childmc:"status"}];
            this.titleList = new DataGridUI(_loc_5, this, 10, 140, 320, 260);
            this.titleArr1 = [];
            this.titleArr2 = [];
            this.titleArr3 = [];
            this.titleArr4 = [];
            for (_loc_6 in Config._titleMap)
            {
                
                if (int(Config._titleMap[_loc_6].color) == 1)
                {
                    _loc_7 = {};
                    for (_loc_8 in Config._titleMap[_loc_6])
                    {
                        
                        _loc_7[_loc_8] = Config._titleMap[_loc_6][_loc_8];
                    }
                    this.titleArr1.push(_loc_7);
                    continue;
                }
                if (int(Config._titleMap[_loc_6].color) == 2)
                {
                    _loc_7 = {};
                    for (_loc_8 in Config._titleMap[_loc_6])
                    {
                        
                        _loc_7[_loc_8] = Config._titleMap[_loc_6][_loc_8];
                    }
                    this.titleArr2.push(_loc_7);
                    continue;
                }
                if (int(Config._titleMap[_loc_6].color) == 3)
                {
                    _loc_7 = {};
                    for (_loc_8 in Config._titleMap[_loc_6])
                    {
                        
                        _loc_7[_loc_8] = Config._titleMap[_loc_6][_loc_8];
                    }
                    this.titleArr3.push(_loc_7);
                    continue;
                }
                if (int(Config._titleMap[_loc_6].color) == 4)
                {
                    _loc_7 = {};
                    for (_loc_8 in Config._titleMap[_loc_6])
                    {
                        
                        _loc_7[_loc_8] = Config._titleMap[_loc_6][_loc_8];
                    }
                    this.titleArr4.push(_loc_7);
                }
            }
            this.titleArr1.sortOn("id", Array.NUMERIC);
            this.titleArr2.sortOn("id", Array.NUMERIC);
            this.titleArr3.sortOn("id", Array.NUMERIC);
            this.titleArr4.sortOn("id", Array.NUMERIC);
            return;
        }// end function

        private function sendprize(event:MouseEvent)
        {
            if (this._floor <= 101)
            {
                Config.message(Config.language("ToAirPanel", 26));
            }
            else
            {
                Config.ui._toAir2prize.open();
            }
            return;
        }// end function

        private function airNumChange(event:Event) : void
        {
            this.thisFloor = this.airNumStepper.value;
            return;
        }// end function

        private function smallNumSet(event:MouseEvent) : void
        {
            this.airNumStepper.value = 1;
            return;
        }// end function

        private function sendLogin(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            if (Config.ui._teamUI.getTeamArr().length > 0)
            {
                Config.message(Config.language("ToAirPanel", 9));
                return;
            }
            var _loc_2:* = 1;
            var _loc_3:* = CONST_ENUM.C2G_ENTER_SKYTOWER;
            if (this.topbtn.selectpage == 0)
            {
                if (this.airNumStepper.value <= 100)
                {
                    _loc_2 = this._connt;
                    _loc_3 = CONST_ENUM.C2G_ENTER_SKYTOWER;
                }
            }
            else if (this.topbtn.selectpage == 1)
            {
                if (this.airNumStepper.value <= 200 && this.airNumStepper.value > 100)
                {
                    _loc_2 = this._connt2;
                    _loc_3 = CONST_ENUM.C2G_ENTER_SKYTOWER2;
                }
            }
            else if (this.topbtn.selectpage == 2)
            {
                if (this.airNumStepper.value > 200 && this.airNumStepper.value <= 300)
                {
                    _loc_2 = this._connt3;
                    _loc_3 = CONST_ENUM.C2G_ENTER_SKYTOWER3;
                }
            }
            else if (this.topbtn.selectpage == 3)
            {
                if (this.airNumStepper.value > 300)
                {
                    _loc_2 = this._connt4;
                    _loc_3 = CONST_ENUM.C2G_ENTER_SKYTOWER4;
                }
            }
            if (_loc_2 > 0)
            {
                _loc_4 = new DataSet();
                _loc_4.addHead(_loc_3);
                if (_loc_3 == CONST_ENUM.C2G_ENTER_SKYTOWER3 || _loc_3 == CONST_ENUM.C2G_ENTER_SKYTOWER4)
                {
                    _loc_4.add16(this.airNumStepper.value);
                }
                else
                {
                    _loc_4.add8(this.airNumStepper.value);
                }
                ClientSocket.send(_loc_4);
            }
            else
            {
                Config.message(Config.language("ToAirPanel", 1));
            }
            return;
        }// end function

        public function leftCheck() : void
        {
            if (this._alert != null)
            {
                AlertUI.remove(this._alert);
            }
            var _loc_1:* = "";
            if (Config.map.id >= 661 && Config.map.id <= 760)
            {
                _loc_1 = Config.language("ToAirPanel", 22);
            }
            else if (Config.map.id >= 801 && Config.map.id <= 900)
            {
                _loc_1 = Config.language("ToAirPanel", 23);
            }
            else if (Config.map.id >= 1141 && Config.map.id <= 1240)
            {
                _loc_1 = Config.language("ToAirPanel", 29);
            }
            else
            {
                _loc_1 = Config.language("ToAirPanel", 24);
            }
            this._alert = AlertUI.alert(Config.language("ToAirPanel", 2), Config.language("ToAirPanel", 3, _loc_1), [Config.language("ToAirPanel", 4), Config.language("ToAirPanel", 5)], [this.LeftSend]);
            return;
        }// end function

        private function LeftSend(event:SocketEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEFT_SKYTOWER);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function setCount(event:SocketEvent) : void
        {
            this._connt = event.data.readUnsignedByte();
            this._floor = event.data.readUnsignedShort() + 1;
            this.setflo(this._floor);
            return;
        }// end function

        private function setCount2(event:SocketEvent) : void
        {
            this._connt2 = event.data.readUnsignedByte();
            this._floor = event.data.readUnsignedShort() + 1;
            this.setflo(this._floor);
            return;
        }// end function

        public function get count2() : int
        {
            return this._connt2;
        }// end function

        private function setCount3(event:SocketEvent) : void
        {
            this._connt3 = event.data.readUnsignedByte();
            this._floor = event.data.readUnsignedShort() + 1;
            this.setflo(this._floor);
            return;
        }// end function

        public function get count3() : int
        {
            return this._connt3;
        }// end function

        private function setCount4(event:SocketEvent) : void
        {
            this._connt4 = event.data.readUnsignedByte();
            this._floor = event.data.readUnsignedShort() + 1;
            this.setflo(this._floor);
            return;
        }// end function

        public function get count4() : int
        {
            return this._connt4;
        }// end function

        private function setflo(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 5;
            this.titleArr = [];
            if (param1 > 300)
            {
                this.topbtn.selectpage = 3;
                this.topbtn.bartextcolor(1, 5977896);
                this.topbtn.bartextcolor(2, 5977896);
                this.topbtn.bartextcolor(3, 5977896);
                _loc_2 = 400;
                this.titleArr = this.titleArr4;
                _loc_3 = 10;
                this.prizebtn.visible = true;
            }
            else if (param1 > 200)
            {
                this.topbtn.selectpage = 2;
                this.topbtn.bartextcolor(1, 5977896);
                this.topbtn.bartextcolor(2, 5977896);
                _loc_2 = 300;
                this.titleArr = this.titleArr3;
                _loc_3 = 10;
                this.prizebtn.visible = true;
            }
            else if (param1 > 100)
            {
                this.topbtn.selectpage = 1;
                this.topbtn.bartextcolor(1, 5977896);
                _loc_2 = 200;
                this.titleArr = this.titleArr2;
                this.prizebtn.visible = true;
            }
            else
            {
                this.topbtn.selectpage = 0;
                _loc_2 = 100;
                this.titleArr = this.titleArr1;
                this.prizebtn.visible = false;
            }
            this.selectpag = this.topbtn.selectpage;
            this.numLabel.text = Config.language("activePanel", 12, Math.min(this._floor, _loc_2));
            this.numLabel.x = (340 - this.numLabel.width) / 2;
            this.airNumStepper.maximum = Math.min(this._floor, _loc_2);
            this.airNumStepper.minimum = _loc_2 - 99;
            this.airNumStepper.value = param1;
            var _loc_4:* = 0;
            while (_loc_4 < this.titleArr.length)
            {
                
                if (!this.titleArr[_loc_4].hasOwnProperty("nameSp"))
                {
                    this.titleArr[_loc_4].nameSp = new ClickLabel(null, 10, 0, this.titleArr[_loc_4].name);
                    this.titleArr[_loc_4].nameSp.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    this.titleArr[_loc_4].nameSp.addEventListener(MouseEvent.CLICK, Config.create(this.handleSlotOver, _loc_4));
                    this.titleArr[_loc_4].nameSp.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleSlotOver, _loc_4));
                }
                if (!this.titleArr[_loc_4].hasOwnProperty("status"))
                {
                    this.titleArr[_loc_4].status = new Label(null, 10, 0);
                }
                if (this._floor > (_loc_4 + 1) * _loc_3 + _loc_2 - 100)
                {
                    this.titleArr[_loc_4].nameSp.clickColor([591794, 6837142]);
                    this.titleArr[_loc_4].color = 5256984;
                    this.titleArr[_loc_4].status.text = Config.language("ToAirPanel", 10);
                    this.titleArr[_loc_4].status.textColor = 3497236;
                }
                else
                {
                    this.titleArr[_loc_4].nameSp.clickColor([3814177, 6837142]);
                    this.titleArr[_loc_4].color = 6577760;
                    this.titleArr[_loc_4].status.text = Config.language("ToAirPanel", 11);
                    this.titleArr[_loc_4].status.textColor = 14618383;
                }
                this.titleArr[_loc_4].term = Config.language("ToAirPanel", 12, (_loc_4 + 1) * _loc_3 + _loc_2 - 100);
                _loc_4 = _loc_4 + 1;
            }
            this.titleList.dataProvider = this.titleArr;
            return;
        }// end function

        public function set _floor(param1)
        {
            this._flo = param1;
            return;
        }// end function

        public function get _floor() : int
        {
            return this._flo;
        }// end function

        private function setFloor(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedShort() + 1;
            this._floor = event.data.readUnsignedShort() + 1;
            var _loc_3:* = Config.language("ToAirPanel", 6, Config.map._data.name);
            var _loc_4:* = 5;
            var _loc_5:* = this._floor;
            if (this._floor > 301)
            {
                _loc_4 = 10;
                _loc_5 = this._floor - 300;
            }
            else if (this._floor > 201)
            {
                _loc_4 = 10;
                _loc_5 = this._floor - 200;
            }
            else if (this._floor > 101)
            {
                _loc_5 = this._floor - 100;
            }
            Billboard.show(_loc_3);
            if (_loc_2 >= this._floor)
            {
                if ((_loc_2 - 1) % _loc_4 == 0)
                {
                    if (this.titleArr[(int(_loc_5 / _loc_4) - 1)] != null)
                    {
                        _loc_3 = _loc_3 + Config.language("ToAirPanel", 16, this.titleArr[(int(_loc_5 / _loc_4) - 1)].name);
                    }
                    if (this._alert != null)
                    {
                        AlertUI.remove(this._alert);
                    }
                    this._alert = AlertUI.alert(Config.language("ToAirPanel", 2), "<p align=\'center\'>" + _loc_3 + "</p>", [Config.language("ToAirPanel", 4)]);
                }
            }
            return;
        }// end function

        private function toair123(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this.airfloor <= 100)
            {
                if (this.topbtn.selectpage == 0)
                {
                    this.setflo(this.airfloor);
                    this.prizebtn.visible = false;
                }
                else
                {
                    _loc_2 = "";
                    if (this.topbtn.selectpage == 1)
                    {
                        _loc_2 = Config.language("ToAirPanel", 27);
                    }
                    else if (this.topbtn.selectpage == 2)
                    {
                        _loc_2 = Config.language("ToAirPanel", 28);
                    }
                    else if (this.topbtn.selectpage == 3)
                    {
                        _loc_2 = Config.language("ToAirPanel", 30);
                    }
                    this.topbtn.selectpage = this.selectpag;
                    Holder.showInfo(_loc_2, new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
                }
            }
            else if (this.airfloor <= 200)
            {
                if (this.topbtn.selectpage == 2)
                {
                    this.topbtn.selectpage = this.selectpag;
                    Holder.showInfo(Config.language("ToAirPanel", 28), new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
                }
                else if (this.topbtn.selectpage == 3)
                {
                    this.topbtn.selectpage = this.selectpag;
                    Holder.showInfo(Config.language("ToAirPanel", 30), new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
                }
                else
                {
                    _loc_3 = 1;
                    if (this.topbtn.selectpage == 0)
                    {
                        _loc_3 = 100;
                        this.prizebtn.visible = false;
                    }
                    else if (this.topbtn.selectpage == 1)
                    {
                        _loc_3 = this.airfloor;
                        this.prizebtn.visible = true;
                    }
                    this.setflo(_loc_3);
                }
            }
            else if (this.airfloor <= 300)
            {
                _loc_4 = 1;
                if (this.topbtn.selectpage == 3)
                {
                    this.topbtn.selectpage = this.selectpag;
                    Holder.showInfo(Config.language("ToAirPanel", 30), new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
                }
                else if (this.topbtn.selectpage == 0)
                {
                    _loc_4 = 100;
                    this.prizebtn.visible = false;
                }
                else if (this.topbtn.selectpage == 1)
                {
                    _loc_4 = 200;
                    this.prizebtn.visible = true;
                }
                else if (this.topbtn.selectpage == 2)
                {
                    _loc_4 = this.airfloor;
                    this.prizebtn.visible = true;
                }
                this.setflo(_loc_4);
            }
            else if (this.airfloor <= 401)
            {
                _loc_4 = 1;
                if (this.topbtn.selectpage == 0)
                {
                    _loc_4 = 100;
                    this.prizebtn.visible = false;
                }
                else if (this.topbtn.selectpage == 1)
                {
                    _loc_4 = 200;
                    this.prizebtn.visible = true;
                }
                else if (this.topbtn.selectpage == 2)
                {
                    _loc_4 = 300;
                    this.prizebtn.visible = true;
                }
                else if (this.topbtn.selectpage == 3)
                {
                    _loc_4 = this.airfloor;
                    this.prizebtn.visible = true;
                }
                this.setflo(_loc_4);
            }
            this.selectpag = this.topbtn.selectpage;
            trace(this.topbtn.selectpage);
            return;
        }// end function

        public function get airfloor() : int
        {
            return this._floor;
        }// end function

        private function BackLeftAir(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedByte();
            switch(_loc_2)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function backLoginAir(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedByte();
            switch(_loc_2)
            {
                case 0:
                {
                    this.close();
                    Config.ui._activePanel.close();
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("ToAirPanel", 7));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("ToAirPanel", 8));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleSlotOver(event:MouseEvent, param2:int) : void
        {
            var _loc_6:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = undefined;
            var _loc_3:* = [];
            var _loc_4:* = Config._replace1;
            var _loc_5:* = 1;
            while (_loc_5 <= 10)
            {
                
                _loc_9 = Number(this.titleArr[param2]["effectId" + _loc_5]);
                if (_loc_9 != 0)
                {
                    _loc_3[_loc_9] = {id:_loc_9, value:Number(this.titleArr[param2]["effectValue" + _loc_5])};
                }
                _loc_5 = _loc_5 + 1;
            }
            _loc_3.sortOn("id", Array.NUMERIC);
            if (_loc_3.length > 0)
            {
                _loc_6 = Config.language("ToAirPanel", 17);
                for (_loc_10 in _loc_3)
                {
                    
                    _loc_6 = _loc_6 + ("<br/><font color=\'" + Style.FONT_LightYellow + "\'>" + String(Config._itemPropMap[_loc_3[_loc_10].id].prop).replace(_loc_4, _loc_3[_loc_10].value) + "</font>");
                }
            }
            else
            {
                _loc_6 = Config.language("ToAirPanel", 18);
            }
            var _loc_7:* = event.currentTarget;
            var _loc_8:* = event.currentTarget.parent.localToGlobal(new Point(_loc_7.x, _loc_7.y));
            Holder.showInfo(_loc_6, new Rectangle(_loc_8.x, _loc_8.y, 50, 20), true, 0, 220);
            return;
        }// end function

        private function set selectpag(param1) : void
        {
            this._selectpag = param1;
            return;
        }// end function

        private function get selectpag() : int
        {
            return this._selectpag;
        }// end function

    }
}
