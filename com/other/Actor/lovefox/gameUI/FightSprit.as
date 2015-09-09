package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class FightSprit extends Sprite
    {
        private var _equipStartIndex:uint = 1001;
        private var _equipStartIndexfollow:uint = 1021;
        private var _fightspritype:uint = 0;
        public var _slotArray:Array;
        private var _labName:Label;
        private var _labLv:Label;
        private var _labProp:Label;
        private var _labStr:Label;
        private var _labExtra:Label;
        private var _labExtra1:Label;
        private var _labExtra2:Label;
        private var _labExtra3:Label;
        private var _labExtra4:Label;
        private var _labTip:Label;
        private var fispNameArr:Array;
        private var _washBtn:PushButton;
        private var _gradeBtn:PushButton;
        private var _spritInfoArr:Array;
        private var _sprArr:Array;
        private var _lockmapArr:Array;
        private var _iflockArr:Array;
        private var _spr:Shape;
        private var _flag:Boolean = false;
        private var _flag1:Boolean = false;
        private var _panelflag:int;
        private var _fightspritypefollow:int = 0;
        private var _fightsprposition:int = 0;
        private var _maxLevel:int = 159;

        public function FightSprit()
        {
            this.fispNameArr = [Config.language("FightSprit", 1), Config.language("FightSprit", 2), Config.language("FightSprit", 3), Config.language("FightSprit", 4), Config.language("FightSprit", 5), Config.language("FightSprit", 6), Config.language("FightSprit", 7), Config.language("FightSprit", 8), Config.language("FightSprit", 9), Config.language("FightSprit", 10)];
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_FIGHTSPIRIT_INFO, this.getfightsprinfo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_FIGHTSPIRIT_UPDATE, this.fightsprupdata);
            return;
        }// end function

        private function init(param1:int)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this._fightspritype = 0;
            this._labName = new Label(this, 90, 35);
            this._labName.html = true;
            this._labLv = new Label(this, 70, 75);
            this._labLv.html = true;
            this._labProp = new Label(this, 60, 105);
            this._labProp.html = true;
            this._labStr = new Label(this, 70, 150);
            this._labStr.html = true;
            this._labExtra = new Label(this, 70, 195);
            this._labExtra.html = true;
            this._labExtra1 = new Label(this, 75, 215);
            this._labExtra1.html = true;
            this._labExtra2 = new Label(this, 75, 235);
            this._labExtra2.html = true;
            this._labExtra3 = new Label(this, 75, 255);
            this._labExtra3.html = true;
            this._labExtra4 = new Label(this, 75, 275);
            this._labExtra4.html = true;
            this._labTip = new Label(this, 17, 325);
            this._labTip.html = true;
            this._slotArray = [];
            this._lockmapArr = [];
            _loc_2 = this._equipStartIndex;
            while (_loc_2 < this._equipStartIndex + 10)
            {
                
                this._slotArray[_loc_2] = new CloneSlot(_loc_2, 32);
                this.addChild(this._slotArray[_loc_2]);
                this._slotArray[_loc_2].addEventListener("sglClick", this.handleSlotClick);
                this._slotArray[_loc_2].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._slotArray[_loc_2].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_2 = _loc_2 + 1;
            }
            var _loc_5:* = 17;
            var _loc_6:* = 197;
            _loc_4 = 75;
            var _loc_7:* = 44;
            this._slotArray[this._equipStartIndex + 0].x = _loc_5;
            this._slotArray[this._equipStartIndex + 0].y = _loc_4 + _loc_7 * 3;
            this._slotArray[this._equipStartIndex + 0].name = 0 + this._equipStartIndex;
            this._slotArray[(this._equipStartIndex + 1)].x = _loc_5;
            this._slotArray[(this._equipStartIndex + 1)].y = _loc_4;
            this._slotArray[(this._equipStartIndex + 1)].name = 1 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 2].x = _loc_5;
            this._slotArray[this._equipStartIndex + 2].y = _loc_4 + _loc_7;
            this._slotArray[this._equipStartIndex + 2].name = 2 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 3].x = _loc_5;
            this._slotArray[this._equipStartIndex + 3].y = _loc_4 + _loc_7 * 2;
            this._slotArray[this._equipStartIndex + 3].name = 3 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 4].x = _loc_6;
            this._slotArray[this._equipStartIndex + 4].y = _loc_4 + _loc_7 * 3;
            this._slotArray[this._equipStartIndex + 4].name = 4 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 5].x = _loc_5;
            this._slotArray[this._equipStartIndex + 5].y = _loc_4 + _loc_7 * 4;
            this._slotArray[this._equipStartIndex + 5].name = 5 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 6].x = _loc_6;
            this._slotArray[this._equipStartIndex + 6].y = _loc_4 + _loc_7;
            this._slotArray[this._equipStartIndex + 6].name = 6 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 7].x = _loc_6;
            this._slotArray[this._equipStartIndex + 7].y = _loc_4 + _loc_7 * 2;
            this._slotArray[this._equipStartIndex + 7].name = 7 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 8].x = _loc_6;
            this._slotArray[this._equipStartIndex + 8].y = _loc_4;
            this._slotArray[this._equipStartIndex + 8].name = 8 + this._equipStartIndex;
            this._slotArray[this._equipStartIndex + 9].x = _loc_6;
            this._slotArray[this._equipStartIndex + 9].y = _loc_4 + _loc_7 * 4;
            this._slotArray[this._equipStartIndex + 9].name = 9 + this._equipStartIndex;
            this._washBtn = new PushButton(this, 120, 320, Config.language("FightSprit", 12), this.sendwash);
            this._washBtn.setTable("table18", "table31");
            this._washBtn.width = 50;
            this._washBtn.height = 25;
            this._washBtn.textColor = Style.GOLD_FONT;
            this._washBtn.visible = false;
            this._gradeBtn = new PushButton(this, 130, 71, Config.language("FightSprit", 13), this.sendlv);
            this._gradeBtn.addEventListener(MouseEvent.ROLL_OVER, this.gradeOver);
            this._gradeBtn.addEventListener(MouseEvent.ROLL_OUT, this.gradeOut);
            this._gradeBtn.setTable("table18", "table31");
            this._gradeBtn.width = 50;
            this._gradeBtn.height = 25;
            this._gradeBtn.textColor = Style.GOLD_FONT;
            this._gradeBtn.visible = false;
            this._spr = new Shape();
            this._spr.graphics.lineStyle(2, 11344686);
            this._spr.graphics.drawRoundRect(0, 0, 36, 36, 5);
            this._spr.graphics.endFill();
            this.addChild(this._spr);
            this._sprArr = [];
            this._iflockArr = [];
            _loc_2 = 0;
            while (_loc_2 < 4)
            {
                
                _loc_8 = new Sprite();
                _loc_8.graphics.beginFill(15061416);
                _loc_8.graphics.drawRoundRect(55, 218 + _loc_2 * 20, 130, 14, 5);
                _loc_8.graphics.endFill();
                _loc_8.alpha = 0;
                this._sprArr.push(_loc_8);
                _loc_8.addEventListener(MouseEvent.CLICK, this.spclick);
                _loc_8.addEventListener(MouseEvent.MOUSE_OVER, this.spover);
                _loc_8.addEventListener(MouseEvent.MOUSE_OUT, this.spout);
                _loc_8.name = String(_loc_2);
                _loc_9 = new Bitmap();
                _loc_9.bitmapData = Config.findsysUI("icon/fight1", 14, 18);
                _loc_9.x = 55;
                _loc_9.y = 215 + _loc_2 * 20;
                this.addChild(_loc_9);
                _loc_9.visible = false;
                this._lockmapArr.push(_loc_9);
                this._iflockArr.push(0);
                _loc_2 = _loc_2 + 1;
            }
            if (param1 != 0)
            {
                this.chooseSlot(param1);
            }
            else
            {
                this._spr.visible = false;
                this._labProp.text = Config.language("FightSprit", 14);
                this._labExtra.text = Config.language("FightSprit", 15);
            }
            return;
        }// end function

        private function getfightsprinfo(event:SocketEvent)
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            this._spritInfoArr = [];
            this._spritInfoArr[this._equipStartIndex + 12] = "";
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = Config._replace1;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3)
            {
                
                _loc_7 = new Object();
                _loc_7._position = _loc_2.readUnsignedShort();
                _loc_7._level = _loc_2.readUnsignedShort();
                _loc_8 = 0;
                if (_loc_7._position >= this._equipStartIndexfollow)
                {
                    _loc_8 = 20;
                }
                _loc_9 = _loc_7._level + ":" + (_loc_7._position - _loc_8);
                _loc_7._pid = _loc_9;
                if (_loc_5 == 0)
                {
                    if (_loc_7._position <= 1010)
                    {
                        _loc_5 = _loc_7._position;
                    }
                }
                if (_loc_7._position - _loc_8 == 1001 || _loc_7._position - _loc_8 == 1004 || _loc_7._position - _loc_8 == 1007 || _loc_7._position - _loc_8 == 1008 || _loc_7._position - _loc_8 == 1009)
                {
                    _loc_7._ackordef = Config.language("FightSprit", 16);
                }
                else
                {
                    _loc_7._ackordef = Config.language("FightSprit", 17);
                }
                _loc_7.eff1 = _loc_2.readUnsignedShort();
                _loc_7._effect1 = String(Config._itemPropMap[_loc_7.eff1].prop).replace(_loc_4, String(this.disprent(_loc_7.eff1, Config._fightsprit[_loc_9].reformValue1)));
                _loc_7._effvalue1 = this.disprent(_loc_7.eff1, Config._fightsprit[_loc_9].reformValue1);
                _loc_7.eff2 = _loc_2.readUnsignedShort();
                _loc_7._effect2 = String(Config._itemPropMap[_loc_7.eff2].prop).replace(_loc_4, String(this.disprent(_loc_7.eff2, Config._fightsprit[_loc_9].reformValue2)));
                _loc_7._effvalue2 = this.disprent(_loc_7.eff2, Config._fightsprit[_loc_9].reformValue2);
                _loc_7.eff3 = _loc_2.readUnsignedShort();
                _loc_7._effect3 = String(Config._itemPropMap[_loc_7.eff3].prop).replace(_loc_4, String(this.disprent(_loc_7.eff3, Config._fightsprit[_loc_9].reformValue3)));
                _loc_7._effvalue3 = this.disprent(_loc_7.eff3, Config._fightsprit[_loc_9].reformValue3);
                _loc_7.eff4 = _loc_2.readUnsignedShort();
                _loc_7._effect4 = String(Config._itemPropMap[_loc_7.eff4].prop).replace(_loc_4, String(this.disprent(_loc_7.eff4, Config._fightsprit[_loc_9].reformValue4)));
                _loc_7._effvalue4 = this.disprent(_loc_7.eff4, Config._fightsprit[_loc_9].reformValue4);
                this._spritInfoArr[_loc_7._position] = _loc_7;
                _loc_6++;
            }
            this.init(_loc_5);
            trace(_loc_3, "e.data");
            return;
        }// end function

        private function fightsprupdata(event:SocketEvent)
        {
            var _loc_9:* = 0;
            var _loc_2:* = Config._replace1;
            var _loc_3:* = event.data;
            var _loc_4:* = new Object();
            new Object()._position = _loc_3.readUnsignedShort();
            _loc_4._level = _loc_3.readUnsignedShort();
            var _loc_5:* = 0;
            if (_loc_4._position >= this._equipStartIndexfollow)
            {
                _loc_5 = 20;
            }
            var _loc_6:* = _loc_4._level + ":" + (_loc_4._position - _loc_5);
            _loc_4._pid = _loc_6;
            if (_loc_4._position - _loc_5 == 1001 || _loc_4._position - _loc_5 == 1004 || _loc_4._position - _loc_5 == 1007 || _loc_4._position - _loc_5 == 1008 || _loc_4._position - _loc_5 == 1009)
            {
                _loc_4._ackordef = Config.language("FightSprit", 16);
            }
            else
            {
                _loc_4._ackordef = Config.language("FightSprit", 17);
            }
            _loc_4.eff1 = _loc_3.readUnsignedShort();
            _loc_4._effect1 = String(Config._itemPropMap[_loc_4.eff1].prop).replace(_loc_2, String(this.disprent(_loc_4.eff1, Config._fightsprit[_loc_6].reformValue1)));
            _loc_4._effvalue1 = this.disprent(_loc_4.eff1, Config._fightsprit[_loc_6].reformValue1);
            _loc_4.eff2 = _loc_3.readUnsignedShort();
            _loc_4._effect2 = String(Config._itemPropMap[_loc_4.eff2].prop).replace(_loc_2, String(this.disprent(_loc_4.eff2, Config._fightsprit[_loc_6].reformValue2)));
            _loc_4._effvalue2 = this.disprent(_loc_4.eff2, Config._fightsprit[_loc_6].reformValue2);
            _loc_4.eff3 = _loc_3.readUnsignedShort();
            _loc_4._effect3 = String(Config._itemPropMap[_loc_4.eff3].prop).replace(_loc_2, String(this.disprent(_loc_4.eff3, Config._fightsprit[_loc_6].reformValue3)));
            _loc_4._effvalue3 = this.disprent(_loc_4.eff3, Config._fightsprit[_loc_6].reformValue3);
            _loc_4.eff4 = _loc_3.readUnsignedShort();
            _loc_4._effect4 = String(Config._itemPropMap[_loc_4.eff4].prop).replace(_loc_2, String(this.disprent(_loc_4.eff4, Config._fightsprit[_loc_6].reformValue4)));
            _loc_4._effvalue4 = this.disprent(_loc_4.eff4, Config._fightsprit[_loc_6].reformValue4);
            this._spritInfoArr[_loc_4._position] = _loc_4;
            this._slotArray[_loc_4._position - _loc_5].bg = Config.findUI("charui")["icon" + (_loc_4._position - _loc_5 - this._equipStartIndex + 1)];
            this._labName.text = "<b><font size=\'16\'>" + this.fispNameArr[_loc_4._position - _loc_5 - this._equipStartIndex] + "</font></b>";
            this._labLv.text = Config.language("FightSprit", 18, this._spritInfoArr[_loc_4._position]._level - 59);
            this._labProp.text = Config.language("FightSprit", 19, this._spritInfoArr[_loc_4._position]._ackordef, Config._fightsprit[this._spritInfoArr[_loc_4._position]._pid].basicValue);
            this._labStr.text = Config.language("FightSprit", 20, Config._fightsprit[this._spritInfoArr[_loc_4._position]._pid].enhanceValue);
            this._labExtra.text = Config.language("FightSprit", 21);
            this.changeExtrapropcolor(this._fightspritype, 1);
            var _loc_7:* = 0;
            _loc_7 = this.getwashstone();
            this._labTip.text = Config.language("FightSprit", 22, Style.FONT_Red, Config._fightsprit[this._spritInfoArr[_loc_4._position]._pid]["replaceLockCost" + _loc_7]);
            this._washBtn.visible = true;
            this._gradeBtn.visible = true;
            var _loc_8:* = "Lv" + (this._spritInfoArr[_loc_4._position]._level - 59);
            this._slotArray[_loc_4._position - _loc_5].figLevel(_loc_8);
            _loc_9 = 0;
            while (_loc_9 < this._sprArr.length)
            {
                
                if (this._sprArr[_loc_9].parent == null)
                {
                    this.addChild(this._sprArr[_loc_9]);
                }
                _loc_9 = _loc_9 + 1;
            }
            if (this._lockmapArr != null)
            {
                _loc_9 = 0;
                while (_loc_9 < this._lockmapArr.length)
                {
                    
                    this._lockmapArr[_loc_9].visible = true;
                    _loc_9 = _loc_9 + 1;
                }
            }
            return;
        }// end function

        private function handleSlotClick(event:MouseEvent)
        {
            var _loc_2:* = 0;
            if (this.panelflag == 20)
            {
                _loc_2 = parseInt(event.currentTarget.name) + 20;
            }
            else
            {
                _loc_2 = parseInt(event.currentTarget.name);
            }
            this.chooseSlot(_loc_2);
            return;
        }// end function

        private function chooseSlot(param1:uint)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this.panelflag == 20)
            {
                this._fightspritypefollow = param1;
            }
            else
            {
                this._fightsprposition = param1;
            }
            this._fightspritype = param1;
            this._spr.visible = true;
            this._spr.x = this._slotArray[this._fightspritype - this.panelflag].x - 2;
            this._spr.y = this._slotArray[this._fightspritype - this.panelflag].y - 2;
            _loc_2 = 0;
            while (_loc_2 < this._sprArr.length)
            {
                
                if (this._sprArr[_loc_2].parent != null)
                {
                    this._sprArr[_loc_2].parent.removeChild(this._sprArr[_loc_2]);
                }
                _loc_2 = _loc_2 + 1;
            }
            AlertUI.close();
            if (this._spritInfoArr[this._fightspritype] != null)
            {
                this._labName.text = "<b><font size=\'16\'>" + this.fispNameArr[this._fightspritype - this.panelflag - this._equipStartIndex] + "</font></b>";
                this._labLv.text = Config.language("FightSprit", 18, this._spritInfoArr[this._fightspritype]._level - 59);
                this._labProp.text = Config.language("FightSprit", 19, this._spritInfoArr[this._fightspritype]._ackordef, Config._fightsprit[this._spritInfoArr[this._fightspritype]._pid].basicValue);
                this._labStr.text = Config.language("FightSprit", 20, Config._fightsprit[this._spritInfoArr[this._fightspritype]._pid].enhanceValue);
                this._labExtra.text = Config.language("FightSprit", 21);
                this.changeExtrapropcolor(this._fightspritype);
                this.changelockbitmap();
                _loc_3 = 0;
                _loc_3 = this.getwashstone();
                this._labTip.text = Config.language("FightSprit", 22, Style.FONT_Red, Config._fightsprit[this._spritInfoArr[this._fightspritype]._pid]["replaceLockCost" + _loc_3]);
                this._washBtn.visible = true;
                this._gradeBtn.visible = true;
            }
            else
            {
                this._labName.text = "<b><font size=\'16\'>" + this.fispNameArr[this._fightspritype - this._equipStartIndex - this.panelflag] + "</font></b>";
                this._labLv.text = "";
                this._labProp.text = Config.language("FightSprit", 14);
                this._labStr.text = "";
                this._labExtra.text = Config.language("FightSprit", 15);
                this._labExtra1.text = "";
                this._labExtra2.text = "";
                this._labExtra3.text = "";
                this._labExtra4.text = "";
                this._labTip.text = "";
                this._washBtn.visible = false;
                this._gradeBtn.visible = false;
                if (this._lockmapArr != null)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._lockmapArr.length)
                    {
                        
                        this._iflockArr[_loc_2] = 0;
                        _loc_4 = new Bitmap();
                        _loc_4.bitmapData = Config.findsysUI("icon/fight1", 14, 18);
                        _loc_4.x = this._lockmapArr[_loc_2].x;
                        _loc_4.y = this._lockmapArr[_loc_2].y;
                        this.addChild(_loc_4);
                        if (this._lockmapArr[_loc_2].hasOwnProperty("bitmapData"))
                        {
                            this._lockmapArr[_loc_2].bitmapData.dispose();
                            this._lockmapArr[_loc_2] = null;
                        }
                        this._lockmapArr[_loc_2] = _loc_4;
                        this._lockmapArr[_loc_2].visible = false;
                        _loc_2 = _loc_2 + 1;
                    }
                }
                AlertUI.alert(Config.language("FightSprit", 23), Config.language("FightSprit", 24, 1), [Config.language("FightSprit", 25), Config.language("FightSprit", 26)], [this.sendopen]);
                GuideUI.testDoId(33, AlertUI._ui._btnArray[0]);
            }
            return;
        }// end function

        private function sendopen(event:MouseEvent)
        {
            trace(this._fightspritype, "sendopen", this._fightspritype - this._equipStartIndex + 1);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_FIGHTSPIRIT_LEVELUP);
            _loc_2.add16(this._fightspritype);
            _loc_2.add16(60);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendlv(event:MouseEvent)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            var _loc_7:* = 0;
            trace(this._fightspritype, "sendlv", this._spritInfoArr[this._fightspritype]._level);
            var _loc_2:* = 0;
            if (this._fightspritype >= this._equipStartIndexfollow)
            {
                _loc_2 = 20;
            }
            if (this._spritInfoArr[this._fightspritype]._level < this._maxLevel)
            {
                if (!this._flag)
                {
                    AlertUI.close();
                    _loc_3 = new Sprite();
                    _loc_4 = new CheckBox(_loc_3, 25, 20, Config.language("FightSprit", 27), this.checkflag);
                    _loc_4.buttonMode = true;
                    _loc_4.enabled = true;
                    _loc_4.selected = false;
                    _loc_5 = 0;
                    _loc_6 = Config._fightsprit[(this._spritInfoArr[this._fightspritype]._level + 1) + ":" + (this._fightspritype - _loc_2)].upgradeCost;
                    _loc_7 = 0;
                    while (_loc_7 < Config.ui._shopmail._visbitempriceArr.length)
                    {
                        
                        if (Config.ui._shopmail._visbitempriceArr[_loc_7]._id == 802060 || Config.ui._shopmail._visbitempriceArr[_loc_7]._id == 94510)
                        {
                            _loc_5 = Config.ui._shopmail._visbitempriceArr[_loc_7]._price;
                            break;
                        }
                        _loc_7++;
                    }
                    AlertUI.alert(Config.language("FightSprit", 23), Config.language("FightSprit", 35, _loc_6, Style.FONT_Red, _loc_5 * _loc_6), [Config.language("FightSprit", 25), Config.language("FightSprit", 26)], [this.suresendlv], this._fightspritype, false, true, false, _loc_3);
                }
                else
                {
                    this.suresendlv(this._fightspritype);
                }
            }
            return;
        }// end function

        private function checkflag(event:MouseEvent)
        {
            if (this._flag)
            {
                event.currentTarget.selected = false;
                this._flag = false;
            }
            else
            {
                event.currentTarget.selected = true;
                this._flag = true;
            }
            return;
        }// end function

        private function checkflag1(event:MouseEvent)
        {
            if (this._flag1)
            {
                event.currentTarget.selected = false;
                this._flag1 = false;
            }
            else
            {
                event.currentTarget.selected = true;
                this._flag1 = true;
            }
            return;
        }// end function

        private function suresendlv(param1:uint)
        {
            trace("suresendlv", param1);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_FIGHTSPIRIT_LEVELUP);
            _loc_2.add16(param1);
            _loc_2.add16((this._spritInfoArr[param1]._level + 1));
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendwash(event:MouseEvent)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = Config._fightsprit[this._spritInfoArr[this._fightspritype]._pid]["replaceLockCost" + this.getwashstone()];
            var _loc_3:* = Config.ui._charUI.getItemAmount(94515) + Config.ui._charUI.getItemAmount(802065);
            var _loc_4:* = Config.ui._shopmail.washstoneprice;
            AlertUI.close();
            if (_loc_3 >= _loc_2)
            {
                if (!this._flag1)
                {
                    _loc_5 = new Sprite();
                    _loc_6 = new CheckBox(_loc_5, 25, 20, Config.language("FightSprit", 27), this.checkflag1);
                    _loc_6.buttonMode = true;
                    _loc_6.enabled = true;
                    _loc_6.selected = false;
                    AlertUI.alert(Config.language("FightSprit", 23), Config.language("FightSprit", 36, _loc_2), [Config.language("FightSprit", 25), Config.language("FightSprit", 26)], [this.suresendwash], null, false, true, false, _loc_5);
                }
                else
                {
                    this.suresendwash();
                }
            }
            else
            {
                AlertUI.alert(Config.language("FightSprit", 23), Config.language("FightSprit", 37, (_loc_2 - _loc_3) * _loc_4), [Config.language("FightSprit", 25), Config.language("FightSprit", 26)], [this.suresendwash]);
            }
            return;
        }// end function

        private function suresendwash(event:MouseEvent = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_FIGHTSPIRIT_CHANGE);
            _loc_2.add16(this._fightspritype);
            _loc_2.add8(this._iflockArr[0]);
            _loc_2.add8(this._iflockArr[1]);
            _loc_2.add8(this._iflockArr[2]);
            _loc_2.add8(this._iflockArr[3]);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleSlotOver(event:MouseEvent)
        {
            trace(event.currentTarget.name, "handleSlotOver");
            var _loc_2:* = parseInt(event.currentTarget.name);
            var _loc_3:* = "";
            if (this._spritInfoArr[_loc_2 + this.panelflag] != null)
            {
                if (int((this._spritInfoArr[_loc_2 + this.panelflag]._level + 1)) > this._maxLevel)
                {
                    return;
                }
            }
            if (this._spritInfoArr[_loc_2 + this.panelflag] == null)
            {
                _loc_3 = 60 + ":" + _loc_2;
            }
            else
            {
                _loc_3 = (this._spritInfoArr[_loc_2 + this.panelflag]._level + 1) + ":" + _loc_2;
            }
            trace(_loc_3);
            var _loc_4:* = "";
            if (_loc_2 == 1001 || _loc_2 == 1004 || _loc_2 == 1007 || _loc_2 == 1008 || _loc_2 == 1009)
            {
                _loc_4 = Config.language("FightSprit", 16) + Config._fightsprit[_loc_3].basicValue;
            }
            else
            {
                _loc_4 = Config.language("FightSprit", 17) + Config._fightsprit[_loc_3].basicValue;
            }
            var _loc_5:* = "";
            _loc_5 = "" + ("<font color=\'" + Style.FONT_Blue + "\'>" + this.fispNameArr[_loc_2 - this._equipStartIndex] + "</font>");
            _loc_5 = _loc_5 + ("\n\n<font color=\'" + Style.FONT_0_White + "\'>" + Config.language("FightSprit", 28) + "</font>");
            _loc_5 = _loc_5 + ("\n\n<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("FightSprit", 29) + "</font>");
            _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + _loc_4 + "</font>");
            _loc_5 = _loc_5 + ("\n\n<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("FightSprit", 30) + "</font>");
            _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>HP   +" + Config._fightsprit[_loc_3].enhanceValue + "</font>");
            _loc_5 = _loc_5 + ("\n\n<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("FightSprit", 31) + "</font>");
            if (this._spritInfoArr[_loc_2] == null)
            {
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, 1) + "</font>");
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, 1) + "</font>");
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, 1) + "</font>");
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, 1) + "</font>");
            }
            else
            {
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, Config._fightsprit[_loc_3].reformValue1) + "</font>");
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, Config._fightsprit[_loc_3].reformValue2) + "</font>");
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, Config._fightsprit[_loc_3].reformValue3) + "</font>");
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_YellowA + "\'>" + Config.language("FightSprit", 32, Config._fightsprit[_loc_3].reformValue4) + "</font>");
            }
            var _loc_6:* = event.currentTarget;
            var _loc_7:* = event.currentTarget.parent.localToGlobal(new Point(_loc_6.x, _loc_6.y + _loc_6.parent.y));
            Holder.showInfo(_loc_5, new Rectangle(_loc_7.x, _loc_7.y, 50, 20), true, 0, 220);
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function spclick(event:MouseEvent)
        {
            trace(event.currentTarget.name);
            var _loc_2:* = parseInt(event.currentTarget.name);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this._iflockArr.length)
            {
                
                if (this._iflockArr[_loc_5] == 1 && _loc_5 != _loc_2)
                {
                    _loc_3 = _loc_3 + 1;
                }
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_3 >= 3)
            {
                Config.message(Config.language("FightSprit", 33));
                return;
            }
            var _loc_6:* = new Bitmap();
            if (this._iflockArr[_loc_2] == 1)
            {
                this._iflockArr[_loc_2] = 0;
                _loc_6.bitmapData = Config.findsysUI("icon/fight1", 14, 18);
            }
            else
            {
                this._iflockArr[_loc_2] = 1;
                _loc_6.bitmapData = Config.findsysUI("icon/fight3", 14, 18);
            }
            _loc_6.x = this._lockmapArr[_loc_2].x;
            _loc_6.y = this._lockmapArr[_loc_2].y;
            this.addChild(_loc_6);
            if (this._lockmapArr[_loc_2].hasOwnProperty("bitmapData"))
            {
                this._lockmapArr[_loc_2].bitmapData.dispose();
                this._lockmapArr[_loc_2] = null;
            }
            this._lockmapArr[_loc_2] = _loc_6;
            var _loc_7:* = 0;
            _loc_7 = this.getwashstone();
            this._labTip.text = Config.language("FightSprit", 22, Style.FONT_Red, Config._fightsprit[this._spritInfoArr[this._fightspritype]._pid]["replaceLockCost" + _loc_7]);
            return;
        }// end function

        private function spover(event:MouseEvent)
        {
            trace(event.currentTarget.name);
            var _loc_2:* = parseInt(event.currentTarget.name);
            var _loc_3:* = new Bitmap();
            if (this._iflockArr[_loc_2] == 1)
            {
                _loc_3.bitmapData = Config.findsysUI("icon/fight4", 14, 18);
            }
            else
            {
                _loc_3.bitmapData = Config.findsysUI("icon/fight2", 14, 18);
            }
            this.addChild(_loc_3);
            if (this._lockmapArr[_loc_2] != null)
            {
                _loc_3.x = this._lockmapArr[_loc_2].x;
                _loc_3.y = this._lockmapArr[_loc_2].y;
                if (this._lockmapArr[_loc_2].hasOwnProperty("bitmapData"))
                {
                    this._lockmapArr[_loc_2].bitmapData.dispose();
                    this._lockmapArr[_loc_2] = null;
                }
            }
            this._lockmapArr[_loc_2] = _loc_3;
            return;
        }// end function

        private function spout(event:MouseEvent)
        {
            trace(event.currentTarget.name);
            var _loc_2:* = parseInt(event.currentTarget.name);
            var _loc_3:* = new Bitmap();
            if (this._iflockArr[_loc_2] == 1)
            {
                _loc_3.bitmapData = Config.findsysUI("icon/fight3", 14, 18);
            }
            else
            {
                _loc_3.bitmapData = Config.findsysUI("icon/fight1", 14, 18);
            }
            _loc_3.x = this._lockmapArr[_loc_2].x;
            _loc_3.y = this._lockmapArr[_loc_2].y;
            this.addChild(_loc_3);
            if (this._lockmapArr[_loc_2].hasOwnProperty("bitmapData"))
            {
                this._lockmapArr[_loc_2].bitmapData.dispose();
                this._lockmapArr[_loc_2] = null;
            }
            this._lockmapArr[_loc_2] = _loc_3;
            return;
        }// end function

        private function changelockbitmap()
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._lockmapArr.length)
            {
                
                if (this._sprArr[_loc_1].parent == null)
                {
                    this.addChild(this._sprArr[_loc_1]);
                }
                this._iflockArr[_loc_1] = 0;
                _loc_2 = new Bitmap();
                _loc_2.bitmapData = Config.findsysUI("icon/fight1", 14, 18);
                _loc_2.x = this._lockmapArr[_loc_1].x;
                _loc_2.y = this._lockmapArr[_loc_1].y;
                this.addChild(_loc_2);
                if (this._lockmapArr[_loc_1].hasOwnProperty("bitmapData"))
                {
                    this._lockmapArr[_loc_1].bitmapData.dispose();
                    this._lockmapArr[_loc_1] = null;
                }
                this._lockmapArr[_loc_1] = _loc_2;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function changeExtrapropcolor(param1:uint, param2:int = 0)
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            _loc_6 = param2;
            if (this.panelflag == 0)
            {
                param1 = this._fightsprposition;
                _loc_3 = this._equipStartIndex;
                while (_loc_3 < this._equipStartIndex + 10)
                {
                    
                    if (this._spritInfoArr[_loc_3] == null)
                    {
                        this._slotArray[_loc_3].bg = Config.findUI("charui")["icon" + 101];
                        _loc_5 = "";
                    }
                    else
                    {
                        this._slotArray[_loc_3].bg = Config.findUI("charui")["icon" + (_loc_3 - this._equipStartIndex + 1)];
                        _loc_5 = "Lv" + (this._spritInfoArr[_loc_3]._level - 59);
                    }
                    this._slotArray[_loc_3].figLevel(_loc_5);
                    _loc_3++;
                }
            }
            else
            {
                param1 = this._fightspritypefollow;
                _loc_3 = this._equipStartIndex + this.panelflag;
                _loc_4 = this._equipStartIndex;
                while (_loc_3 < this._equipStartIndex + 10 + this.panelflag)
                {
                    
                    if (this._spritInfoArr[_loc_3] == null)
                    {
                        this._slotArray[_loc_4].bg = Config.findUI("charui")["icon" + 101];
                        _loc_5 = "";
                    }
                    else
                    {
                        this._slotArray[_loc_4].bg = Config.findUI("charui")["icon" + (_loc_4 - this._equipStartIndex + 1)];
                        _loc_5 = "Lv" + (this._spritInfoArr[_loc_3]._level - 59);
                    }
                    this._slotArray[_loc_4].figLevel(_loc_5);
                    _loc_3++;
                    _loc_4++;
                }
            }
            if (this._spritInfoArr[param1] != null)
            {
                if (_loc_6 == 0)
                {
                    this.addbitmap();
                }
                else if (this._lockmapArr.length == 0)
                {
                    this.addbitmap();
                }
            }
            if (this._spritInfoArr[param1] != null && this._labExtra1 != null)
            {
                _loc_7 = Config.ui._charUI.getequprop(param1);
                _loc_8 = ["#666666", "#666666", "#666666", "#666666"];
                _loc_3 = 0;
                while (_loc_3 < _loc_7.length)
                {
                    
                    _loc_4 = 1;
                    while (_loc_4 < 5)
                    {
                        
                        if (_loc_7[_loc_3] == this._spritInfoArr[param1]["eff" + _loc_4])
                        {
                            _loc_8[(_loc_4 - 1)] = "#000000";
                        }
                        _loc_4++;
                    }
                    _loc_3++;
                }
                this._labExtra1.text = "<font color=\'" + _loc_8[0] + "\'>" + this._spritInfoArr[param1]._effect1 + "</font>";
                this._labExtra2.text = "<font color=\'" + _loc_8[1] + "\'>" + this._spritInfoArr[param1]._effect2 + "</font>";
                this._labExtra3.text = "<font color=\'" + _loc_8[2] + "\'>" + this._spritInfoArr[param1]._effect3 + "</font>";
                this._labExtra4.text = "<font color=\'" + _loc_8[3] + "\'>" + this._spritInfoArr[param1]._effect4 + "</font>";
            }
            return;
        }// end function

        public function showinfor() : void
        {
            var _loc_1:* = 0;
            if (this.panelflag == 0)
            {
                if (this._fightsprposition != 0)
                {
                    this.chooseSlot(this._fightsprposition);
                }
                else
                {
                    this._spr.visible = false;
                    this._labName.text = "";
                    this._labLv.text = "";
                    this._labProp.text = Config.language("FightSprit", 14);
                    this._labStr.text = "";
                    this._labExtra.text = Config.language("FightSprit", 15);
                    this._labExtra1.text = "";
                    this._labExtra2.text = "";
                    this._labExtra3.text = "";
                    this._labExtra4.text = "";
                    this._labTip.text = "";
                    this._washBtn.visible = false;
                    this._gradeBtn.visible = false;
                }
            }
            else if (this._fightspritypefollow != 0)
            {
                this.chooseSlot(this._fightspritypefollow);
            }
            else
            {
                _loc_1 = 0;
                while (_loc_1 < this._sprArr.length)
                {
                    
                    if (this._sprArr[_loc_1].parent != null)
                    {
                        this._sprArr[_loc_1].parent.removeChild(this._sprArr[_loc_1]);
                    }
                    _loc_1 = _loc_1 + 1;
                }
                this._labName.text = "<b><font size=\'16\'>" + this.fispNameArr[1022 - this._equipStartIndex - this.panelflag] + "</font></b>";
                this._labLv.text = "";
                this._labProp.text = Config.language("FightSprit", 14);
                this._labStr.text = "";
                this._labExtra.text = Config.language("FightSprit", 15);
                this._labExtra1.text = "";
                this._labExtra2.text = "";
                this._labExtra3.text = "";
                this._labExtra4.text = "";
                this._labTip.text = "";
                this._washBtn.visible = false;
                this._gradeBtn.visible = false;
                this._spr.visible = false;
            }
            return;
        }// end function

        public function getsameffect(param1:uint) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = [];
            if (this._spritInfoArr[param1] != null && this._labExtra1 != null)
            {
                _loc_3 = Config.ui._charUI.getequprop(param1);
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_5 = 1;
                    while (_loc_5 < 5)
                    {
                        
                        if (_loc_3[_loc_4] == this._spritInfoArr[param1]["eff" + _loc_5])
                        {
                            _loc_6 = new Object();
                            _loc_6.effectvalue = this._spritInfoArr[param1]["_effvalue" + _loc_5];
                            _loc_6.effectId = _loc_3[_loc_4];
                            _loc_2.push(_loc_6);
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            return _loc_2;
        }// end function

        public function getaktdefandbloo(param1:uint) : Object
        {
            var _loc_2:* = new Object();
            if (this._spritInfoArr[param1] != null)
            {
                _loc_2._basicValue = Config._fightsprit[this._spritInfoArr[param1]._pid].basicValue;
                _loc_2._enhanceValue = Config._fightsprit[this._spritInfoArr[param1]._pid].enhanceValue;
            }
            return _loc_2;
        }// end function

        private function gradeOver(event:MouseEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            if (this._spritInfoArr[this._fightspritype]._level >= this._maxLevel)
            {
                _loc_2 = event.currentTarget;
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(Config.language("FightSprit", 34), new Rectangle(_loc_3.x, _loc_3.y, 50, 20), true, 0, 200);
            }
            return;
        }// end function

        private function gradeOut(event:MouseEvent)
        {
            if (this._spritInfoArr[this._fightspritype]._level >= this._maxLevel)
            {
                Holder.closeInfo();
            }
            return;
        }// end function

        private function disprent(param1:uint, param2:Number) : uint
        {
            var _loc_3:* = 0;
            if (param1 == 1)
            {
                _loc_3 = param2 * 10;
            }
            else if (param1 == 11)
            {
                _loc_3 = Math.ceil(param2 * 0.3);
            }
            else
            {
                _loc_3 = param2;
            }
            return _loc_3;
        }// end function

        public function removebitmap()
        {
            var _loc_1:* = 0;
            if (this._lockmapArr != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this._lockmapArr.length)
                {
                    
                    if (this._lockmapArr[_loc_1].hasOwnProperty("bitmapData"))
                    {
                        this._lockmapArr[_loc_1].bitmapData.dispose();
                    }
                    _loc_1 = _loc_1 + 1;
                }
                this._lockmapArr = [];
            }
            return;
        }// end function

        private function addbitmap()
        {
            var _loc_2:* = null;
            this.removebitmap();
            this._iflockArr = [];
            this._lockmapArr = [];
            var _loc_1:* = 0;
            while (_loc_1 < 4)
            {
                
                _loc_2 = new Bitmap();
                _loc_2.bitmapData = Config.findsysUI("icon/fight1", 14, 18);
                _loc_2.x = 55;
                _loc_2.y = 215 + _loc_1 * 20;
                this.addChild(_loc_2);
                this._lockmapArr.push(_loc_2);
                this._iflockArr.push(0);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function getwashstone() : uint
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._iflockArr.length)
            {
                
                if (this._iflockArr[_loc_2] == 1)
                {
                    _loc_1 = _loc_1 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        public function set panelflag(param1:int) : void
        {
            this._panelflag = param1;
            return;
        }// end function

        public function get panelflag() : int
        {
            return this._panelflag;
        }// end function

    }
}
