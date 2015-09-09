package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class GiveFlower extends Window
    {
        private var _flowercountlab:Label;
        private var _sendflowernumlab:Label;
        private var _playernamelab:Label;
        private var _flowerplayerid:int;
        private var _flowerplayername:String;
        private var _arrfolowerlist:Array;
        private var panel:Window;
        private var _unitClip:UnitClip;
        private var _todaysendnum:uint;
        public static var _bmpdBuff:Object = {};
        public static var _flowerBuff:Object = {};

        public function GiveFlower(param1:DisplayObjectContainer = null)
        {
            this._arrfolowerlist = [];
            super(param1);
            initBuff();
            this.initsocket();
            this.initpanel();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SEND_COUNT, this.todayflower);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_FLOWER_NUM, this.flowerallnum);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RECEIVED_FLOWER, this.giveflowernum);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PLRFLOWERINFO, this.showplayer);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            resize(360, 270);
            this.title = Config.language("GiveFlower", 1);
            this._flowercountlab = new Label(this, 180, 75, Config.language("GiveFlower", 2));
            this._sendflowernumlab = new Label(this, 25, 240, Config.language("GiveFlower", 3, 0));
            this._playernamelab = new Label(this, 180, 42);
            this._playernamelab.html = true;
            var _loc_1:* = new PushButton(this, 255, 40, Config.language("GiveFlower", 4), this.lookbillboard);
            _loc_1.width = 80;
            _loc_1.setTable("table18", "table31");
            _loc_1.textColor = Style.GOLD_FONT;
            var _loc_2:* = new Shape();
            _loc_2.graphics.lineStyle(2, 16777215, 0.6);
            _loc_2.graphics.moveTo(25, 105);
            _loc_2.graphics.lineTo(335, 105);
            _loc_2.graphics.lineTo(335, 230);
            _loc_2.graphics.lineTo(25, 230);
            _loc_2.graphics.lineTo(25, 105);
            _loc_2.graphics.moveTo(128, 105);
            _loc_2.graphics.lineTo(128, 230);
            _loc_2.graphics.moveTo(231, 105);
            _loc_2.graphics.lineTo(231, 230);
            this.addChild(_loc_2);
            var _loc_3:* = new PushButton(this, 35, 200, Config.language("GiveFlower", 5), this.sendflower);
            _loc_3.data = 1;
            _loc_3.width = 80;
            var _loc_4:* = new PushButton(this, 138, 200, Config.language("GiveFlower", 6), this.sendflower, null, "table38", "table37");
            new PushButton(this, 138, 200, Config.language("GiveFlower", 6), this.sendflower, null, "table38", "table37").data = 2;
            _loc_4.width = 80;
            var _loc_5:* = new PushButton(this, 241, 200, Config.language("GiveFlower", 6), this.sendflower, null, "table38", "table37");
            new PushButton(this, 241, 200, Config.language("GiveFlower", 6), this.sendflower, null, "table38", "table37").data = 3;
            _loc_5.width = 80;
            var _loc_6:* = new Bitmap();
            new Bitmap().bitmapData = getBmpd("meigui4");
            this.addChild(_loc_6);
            _loc_6.x = 235;
            _loc_6.y = 68;
            var _loc_7:* = 0;
            while (_loc_7 < 3)
            {
                
                _loc_8 = new Bitmap();
                _loc_8.bitmapData = getBmpd("rose" + _loc_7);
                this.addChild(_loc_8);
                _loc_8.x = 40 + _loc_7 * 103;
                _loc_8.y = 118;
                _loc_9 = new Label(this, 77 + _loc_7 * 103, 118);
                _loc_9.html = true;
                _loc_10 = new Label(this, 40 + _loc_7 * 103, 155);
                _loc_10.html = true;
                _loc_11 = new Label(this, 40 + _loc_7 * 103, 175);
                _loc_11.html = true;
                if (_loc_7 == 0)
                {
                    _loc_9.text = Config.language("GiveFlower", 7, 1);
                    _loc_10.text = Config.language("GiveFlower", 8, 10);
                    _loc_11.text = Config.language("GiveFlower", 9);
                }
                else if (_loc_7 == 1)
                {
                    _loc_9.text = Config.language("GiveFlower", 7, 99);
                    _loc_10.text = Config.language("GiveFlower", 8, 100);
                    _loc_11.text = Config.language("GiveFlower", 10, 99);
                }
                else if (_loc_7 == 2)
                {
                    _loc_9.text = Config.language("GiveFlower", 7, 999);
                    _loc_10.text = Config.language("GiveFlower", 8, 200);
                    _loc_11.text = Config.language("GiveFlower", 10, 999);
                }
                _loc_7++;
            }
            return;
        }// end function

        private function lookbillboard(event:MouseEvent) : void
        {
            Config.ui._billboardpanel.opentype(14);
            return;
        }// end function

        private function sendflower(event:MouseEvent) : void
        {
            trace(event.currentTarget.data);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_SEND_FLOWER);
            _loc_2.add32(this.flowerplayerid);
            _loc_2.add8(parseInt(event.currentTarget.data));
            _loc_2.addUTF(this.flowerplayername);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function todayflower(event:SocketEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = event.data;
            this.todaysendnum = _loc_2.readUnsignedByte();
            var _loc_3:* = 0;
            while (_loc_3 < this.todaysendnum)
            {
                
                _loc_4 = _loc_2.readUnsignedInt();
                _loc_3 = _loc_3 + 1;
            }
            this._sendflowernumlab.text = Config.language("GiveFlower", 3, this.todaysendnum);
            return;
        }// end function

        private function flowerallnum(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            return;
        }// end function

        private function giveflowernum(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.resivenum = _loc_2.readUnsignedInt();
                this._arrfolowerlist.push(_loc_5);
                _loc_4++;
            }
            if (_loc_3 > 0)
            {
                Config.ui._mesHistoryPanel.showicon();
            }
            return;
        }// end function

        public function set flowerplayerid(param1:int) : void
        {
            this._flowerplayerid = param1;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PLRFLOWERINFO);
            _loc_2.add32(this._flowerplayerid);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function get flowerplayerid() : int
        {
            return this._flowerplayerid;
        }// end function

        public function set flowerplayername(param1:String) : void
        {
            this._flowerplayername = param1;
            this._playernamelab.text = "<font color=\'#30C74C\'>" + this._flowerplayername + "</font>";
            return;
        }// end function

        public function get flowerplayername() : String
        {
            return this._flowerplayername;
        }// end function

        public function openalert() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            if (this._arrfolowerlist.length > 0)
            {
                _loc_1 = new Object();
                _loc_1 = this._arrfolowerlist.pop();
                _loc_2 = new Sprite();
                _loc_3 = Config.getSimpleTextField();
                _loc_3.x = 0;
                _loc_3.autoSize = TextFieldAutoSize.CENTER;
                _loc_3.width = 130;
                _loc_2.addChild(_loc_3);
                _loc_3.htmlText = "<font color=\'#30C74C\'>" + _loc_1.name + "</font>";
                _loc_4 = new Label(_loc_2, 38, 20, Config.language("GiveFlower", 11, _loc_1.resivenum));
                _loc_4.html = true;
                _loc_5 = new Bitmap();
                _loc_6 = "1";
                if (_loc_1.resivenum == 99)
                {
                    _loc_6 = "2";
                }
                else if (_loc_1.resivenum == 999)
                {
                    _loc_6 = "3";
                    _loc_9 = 0;
                    while (_loc_9 < 300)
                    {
                        
                        _loc_10 = new FloatFlower();
                        _loc_11 = Math.round(Math.random() * Config.stage.stageWidth);
                        _loc_12 = Math.round(Math.random() * 400 - 300);
                        _loc_10.addflowertostage(_loc_11, _loc_12);
                        _loc_9++;
                    }
                }
                _loc_5.bitmapData = getBmpd("rose" + (int(_loc_6) - 1));
                _loc_5.x = 48;
                _loc_5.y = 45;
                _loc_2.addChild(_loc_5);
                if (this.panel != null)
                {
                    this.panel.close();
                }
                this.panel = new Window(this.container, (Config.stage.stageWidth - 130) / 2, (Config.stage.stageHeight - 170) / 2);
                this.panel.title = Config.language("GiveFlower", 12);
                this.panel.resize(130, 170);
                this.panel.addChild(_loc_2);
                _loc_2.y = 30;
                _loc_7 = new PushButton(this.panel, 20, 135, Config.language("GiveFlower", 13), Config.create(this.sendbackfolower, _loc_1.name, _loc_1.id));
                _loc_7.width = 40;
                _loc_8 = new PushButton(this.panel, 70, 135, Config.language("GiveFlower", 14), this.panelclose);
                _loc_8.width = 40;
                this.panel.open();
            }
            if (this._arrfolowerlist.length <= 0)
            {
                Config.ui._mesHistoryPanel.hideicon();
            }
            return;
        }// end function

        private function sendbackfolower(event:MouseEvent, param2:String, param3:int) : void
        {
            this.panel.close();
            this.open();
            this._playernamelab.text = "<font color=\'#30C74C\'>" + param2 + "</font>";
            this.flowerplayerid = param3;
            this.flowerplayername = param2;
            return;
        }// end function

        private function panelclose(event:MouseEvent) : void
        {
            this.panel.close();
            return;
        }// end function

        private function showplayer(event:SocketEvent) : void
        {
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedShort();
            var _loc_8:* = _loc_2.readByte();
            if (this._unitClip != null)
            {
                this._unitClip.destroy();
                this.removeChild(this._unitClip);
                this._unitClip = null;
            }
            var _loc_9:* = Config._charactorMap[(_loc_4 - 1) * 12 + _loc_5];
            this._unitClip = UnitClip.newUnitClip(Config._model[Number(_loc_9.model)]);
            this._unitClip.multiLayer = true;
            this._unitClip.layerStack = _loc_9.id;
            var _loc_10:* = false;
            var _loc_15:* = [];
            if (_loc_6 != 0)
            {
                if (_loc_5 == 1)
                {
                    if (_loc_4 == 1)
                    {
                        _loc_11 = Config._model[Number(Config._hairMap[_loc_6].fightMale)];
                    }
                    else
                    {
                        _loc_11 = Config._model[Number(Config._hairMap[_loc_6].fightFemale)];
                    }
                }
                else if (_loc_5 == 4)
                {
                    if (_loc_4 == 1)
                    {
                        _loc_11 = Config._model[Number(Config._hairMap[_loc_6].rangerMale)];
                    }
                    else
                    {
                        _loc_11 = Config._model[Number(Config._hairMap[_loc_6].rangerFemale)];
                    }
                }
                else if (_loc_5 == 10)
                {
                    if (_loc_4 == 1)
                    {
                        _loc_11 = Config._model[Number(Config._hairMap[_loc_6].magicMale)];
                    }
                    else
                    {
                        _loc_11 = Config._model[Number(Config._hairMap[_loc_6].magicFemale)];
                    }
                }
                this._unitClip.hair = _loc_11;
            }
            this._unitClip.x = 90;
            this._unitClip.y = 85;
            this._unitClip.changeDirectionTo(1);
            this._unitClip.changeStateTo("idle");
            this.addChild(this._unitClip);
            var _loc_16:* = _loc_2.readUnsignedInt();
            this._flowercountlab.text = Config.language("GiveFlower", 15, _loc_16);
            var _loc_17:* = _loc_2.readUnsignedShort();
            var _loc_18:* = 0;
            while (_loc_18 < _loc_17)
            {
                
                _loc_19 = _loc_2.readUnsignedInt();
                _loc_20 = _loc_2.readUnsignedInt();
                if (_loc_19 == 1001)
                {
                    _loc_12 = Config._itemMap[_loc_20];
                    if (_loc_4 == 1)
                    {
                        _loc_14 = Config._model[Number(_loc_12.mModel)];
                    }
                    else
                    {
                        _loc_14 = Config._model[Number(_loc_12.fModel)];
                    }
                    if (this._unitClip != null)
                    {
                        this._unitClip.weapon = _loc_14;
                    }
                }
                else if (_loc_19 == 1011 && _loc_8 == 0)
                {
                    _loc_10 = true;
                    _loc_12 = Config._itemMap[_loc_20];
                    if (_loc_4 == 1)
                    {
                        _loc_13 = String(_loc_12.mModel);
                    }
                    else
                    {
                        _loc_13 = String(_loc_12.fModel);
                    }
                    if (_loc_13.indexOf(":") == -1)
                    {
                        _loc_14 = Config._model[Number(_loc_13)];
                    }
                    else
                    {
                        _loc_15 = _loc_13.split(":");
                        if (_loc_5 == 1)
                        {
                            _loc_14 = Config._model[Number(_loc_15[0])];
                        }
                        else if (_loc_5 == 4)
                        {
                            _loc_14 = Config._model[Number(_loc_15[1])];
                        }
                        else if (_loc_5 == 10)
                        {
                            _loc_14 = Config._model[Number(_loc_15[2])];
                        }
                    }
                    this._unitClip.cloth = _loc_14;
                }
                _loc_18 = _loc_18 + 1;
            }
            if (!_loc_10)
            {
                _loc_21 = Config._charactorMap[_loc_5 + (_loc_4 - 1) * 12];
                this._unitClip.cloth = Config._model[Number(_loc_21.cloth)];
            }
            return;
        }// end function

        public function set todaysendnum(param1:uint) : void
        {
            this._todaysendnum = param1;
            return;
        }// end function

        public function get todaysendnum() : uint
        {
            return this._todaysendnum;
        }// end function

        public function backsessus() : void
        {
            this.close();
            AlertUI.alert(Config.language("GiveFlower", 12), Config.language("GiveFlower", 16), [Config.language("GiveFlower", 17)]);
            return;
        }// end function

        private static function initBuff() : void
        {
            var _loc_1:* = 0;
            _bmpdBuff["meigui4"] = Config.findsysUI("acitve/meigui4");
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                _bmpdBuff["rose" + _loc_1] = Config.findIcon("rose" + (_loc_1 + 1));
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 5)
            {
                
                _bmpdBuff["flower" + _loc_1] = Config.findsysUI("acitve/flower" + (_loc_1 + 1));
                _loc_1++;
            }
            return;
        }// end function

        public static function getBmpd(param1:String) : BitmapData
        {
            return _bmpdBuff[param1];
        }// end function

    }
}
