package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class ElementUI extends Sprite
    {
        private var _expBar:ProgressBar;
        private var _dmgTF:TextField;
        private var _levelTF:TextField;
        private var _exp:int = 0;
        private var _expTF:TextField;
        private var _balls:Array;
        private var _bigPos:Array;
        private var _miniPos:Array;
        private var _selectedBig:Ball;
        private var _showBall:Ball;
        private var _alertID:int;
        private var _skillMap:Object;
        private var _bigBG:Bitmap;
        private var _upgradePB:PushButton;

        public function ElementUI()
        {
            this._balls = [];
            this._bigPos = [[78, 130], [164, 67], [144, 130], [59, 67], [111, 32]];
            this._miniPos = [30, 120, 75, 210, 165];
            this.initUI();
            return;
        }// end function

        public function checkSkill(param1:int) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this._skillMap == null)
            {
                this._skillMap = {};
                _loc_2 = 1;
                while (_loc_2 < 31)
                {
                    
                    _loc_3 = Config._elementMap[_loc_2];
                    _loc_4 = 1;
                    while (_loc_4 < 6)
                    {
                        
                        _loc_5 = int(_loc_3["elemSkillId" + _loc_4]);
                        if (this._skillMap[_loc_5] == null)
                        {
                            this._skillMap[_loc_5] = true;
                        }
                        _loc_4++;
                    }
                    _loc_2++;
                }
            }
            if (this._skillMap[param1])
            {
                return true;
            }
            return false;
        }// end function

        public function open() : void
        {
            GuideUI.testDoId(82, this._bigBG);
            return;
        }// end function

        private function initUI()
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_1:* = new Shape();
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRoundRect(10, 5, 240, 210, 5);
            _loc_1.graphics.endFill();
            addChild(_loc_1);
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(16777215, 0.4);
            _loc_2.graphics.drawRoundRect(10, 220, 240, 115, 5);
            _loc_2.graphics.endFill();
            addChild(_loc_2);
            _loc_3 = new Bitmap(Config.findsysUI("element/bg", 146, 139));
            _loc_3.x = 57;
            _loc_3.y = 30;
            addChild(_loc_3);
            this._bigBG = _loc_3;
            _loc_4 = new Bitmap(Config.findsysUI("element/minibg", 49, 49));
            _loc_4.x = 15;
            _loc_4.y = 225;
            addChild(_loc_4);
            this._levelTF = Config.getSimpleTextField();
            this._levelTF.x = 70;
            this._levelTF.y = 235;
            this._levelTF.textColor = 14704694;
            this._levelTF.defaultTextFormat = new TextFormat(null, 16, null, true);
            this._levelTF.filters = [new GlowFilter(14704694, 1, 2, 2, 1, 3)];
            addChild(this._levelTF);
            this._dmgTF = Config.getSimpleTextField();
            this._dmgTF.x = 105;
            this._dmgTF.y = 237;
            this._dmgTF.textColor = Style.WINDOW_FONT;
            addChild(this._dmgTF);
            this._showBall = new Ball(-1);
            this._showBall.x = 15 + 6;
            this._showBall.y = 225 + 6;
            this._showBall.enabled = true;
            this._showBall.addEventListener(MouseEvent.ROLL_OVER, this.handleSBRollover);
            this._expBar = new ProgressBar(this, 70, 259);
            this._expBar.height = 15;
            this._expBar.width = 135;
            this._expBar.gradientFillDirection = Math.PI;
            this._expBar.roundCorner = 6;
            this._expBar.color = 13252310;
            this._expBar.subColor = 13934296;
            _loc_5 = new PushButton(this, 211, 259, "", this.update, Config.findUI("element").add);
            _loc_5.overshow = true;
            this._upgradePB = _loc_5;
            _loc_5 = new PushButton(this, 230, 259, "", this.reset, Config.findUI("element").remove);
            _loc_5.overshow = true;
            var _loc_6:* = Config.findsysUI("element/num", 21, 14);
            var _loc_7:* = 0;
            while (_loc_7 < 5)
            {
                
                _loc_8 = new Ball(_loc_7, Config.findsysUI("element/d" + _loc_7, 37, 38), Config.findsysUI("element/c" + _loc_7, 37, 38));
                _loc_9 = new Ball(_loc_7, Config.findsysUI("element/md" + _loc_7, 25, 26), Config.findsysUI("element/mc" + _loc_7, 25, 26));
                _loc_10 = new Bitmap(_loc_6);
                _loc_11 = Config.getSimpleTextField();
                _loc_11.textColor = 16631396;
                this._balls[_loc_7] = {big:_loc_8, mini:_loc_9, tf:_loc_11, level:0};
                if (_loc_7 == 0)
                {
                    this._balls[_loc_7].name = Config.language("ElementUI", 1);
                }
                else if (_loc_7 == 1)
                {
                    this._balls[_loc_7].name = Config.language("ElementUI", 2);
                }
                else if (_loc_7 == 2)
                {
                    this._balls[_loc_7].name = Config.language("ElementUI", 3);
                }
                else if (_loc_7 == 3)
                {
                    this._balls[_loc_7].name = Config.language("ElementUI", 4);
                }
                else if (_loc_7 == 4)
                {
                    this._balls[_loc_7].name = Config.language("ElementUI", 5);
                }
                addChild(_loc_8);
                _loc_8.x = this._bigPos[_loc_7][0];
                _loc_8.y = this._bigPos[_loc_7][1];
                addChild(_loc_9);
                _loc_9.x = this._miniPos[_loc_7] - 2;
                _loc_9.y = 283;
                addChild(_loc_10);
                _loc_10.x = this._miniPos[_loc_7];
                _loc_10.y = 315;
                addChild(_loc_11);
                _loc_11.x = this._miniPos[_loc_7] + 10;
                _loc_11.y = 313;
                _loc_8.buttonMode = true;
                _loc_8.addEventListener(MouseEvent.CLICK, this.sel);
                _loc_9.addEventListener(MouseEvent.ROLL_OVER, this.handleMiniRollover);
                _loc_7++;
            }
            this._expTF = Config.getSimpleTextField();
            this._expTF.textColor = Style.WINDOW_FONT;
            this._expTF.y = 185;
            addChild(this._expTF);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ELEMENT_SEL, this.handleSel);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ELEMENT_UPGRADE, this.handleUpdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ELEMENT_LIST, this.handleList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ELEMENT_EXP, this.handleExp);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ELEMENT_EXP_RESET, this.handleReset);
            return;
        }// end function

        private function handleSBRollover(event:MouseEvent)
        {
            var _loc_7:* = undefined;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_2:* = Ball(event.currentTarget);
            var _loc_3:* = "<font color=\'E36C0A\'>" + Config.language("ElementUI", 27) + "</font>";
            _loc_3 = _loc_3 + "\n";
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < 5)
            {
                
                if (this._balls[_loc_5].level == 0)
                {
                    _loc_7 = 0;
                }
                else
                {
                    _loc_7 = Config._elementMap[this._balls[_loc_5].level]["elem" + (_loc_5 + 1)];
                }
                _loc_8 = 1;
                while (_loc_8 < 6)
                {
                    
                    _loc_9 = 1;
                    while (_loc_9 <= this._balls[(_loc_8 - 1)].level)
                    {
                        
                        if (Config._elementMap[_loc_9]["elem" + _loc_8 + "is" + _loc_8] == "elem" + (_loc_5 + 1))
                        {
                            _loc_7 = _loc_7 + Config._elementMap[_loc_9]["elem" + _loc_8 + "is" + _loc_8 + "num"];
                        }
                        _loc_9++;
                    }
                    _loc_8++;
                }
                _loc_9 = 1;
                while (_loc_9 <= this._balls[_loc_5].level)
                {
                    
                    if (Config._elementMap[_loc_9]["elem" + (_loc_5 + 1) + "is" + (_loc_5 + 1) + "HP"] != 0)
                    {
                        _loc_4 = _loc_4 + Config._elementMap[_loc_9]["elem" + (_loc_5 + 1) + "is" + (_loc_5 + 1) + "HP"];
                    }
                    _loc_9++;
                }
                _loc_3 = _loc_3 + "\n";
                if (_loc_5 == 0)
                {
                    _loc_3 = _loc_3 + Config.language("ElementUI", 28, _loc_7);
                }
                else if (_loc_5 == 1)
                {
                    _loc_3 = _loc_3 + Config.language("ElementUI", 29, _loc_7);
                }
                else if (_loc_5 == 2)
                {
                    _loc_3 = _loc_3 + Config.language("ElementUI", 30, _loc_7);
                }
                else if (_loc_5 == 3)
                {
                    _loc_3 = _loc_3 + Config.language("ElementUI", 31, _loc_7);
                }
                else if (_loc_5 == 4)
                {
                    _loc_3 = _loc_3 + Config.language("ElementUI", 32, _loc_7);
                }
                _loc_5++;
            }
            _loc_3 = _loc_3 + ("\n\n" + Config.language("ElementUI", 33, _loc_4));
            var _loc_6:* = new Point(_loc_2.x, _loc_2.y);
            _loc_6 = _loc_2.parent.localToGlobal(_loc_6);
            Holder.showInfo(_loc_3, new Rectangle(_loc_6.x, _loc_6.y, 25, 26));
            _loc_2.removeEventListener(MouseEvent.ROLL_OUT, this.handleSBRollout);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSBRollout);
            return;
        }// end function

        private function handleSBRollout(event:MouseEvent)
        {
            var _loc_2:* = Ball(event.currentTarget);
            _loc_2.removeEventListener(MouseEvent.ROLL_OUT, this.handleSBRollout);
            Holder.closeInfo();
            return;
        }// end function

        private function handleMiniRollover(event:MouseEvent)
        {
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_2:* = Ball(event.currentTarget);
            var _loc_3:* = new Point(_loc_2.x, _loc_2.y);
            _loc_3 = _loc_2.parent.localToGlobal(_loc_3);
            var _loc_4:* = this._balls[_loc_2._id];
            var _loc_5:* = "<font color=\'" + Style.FONT_Red + "\'>" + _loc_4.name + " Lv" + _loc_4.level + "</font>\n\n<font color=\'" + Style.FONT_4_Gold + "\'>" + Config.language("ElementUI", 6) + "</font>\n";
            var _loc_6:* = [10, 20, 30, 40, 50, 60];
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6.length)
            {
                
                _loc_8 = _loc_6[_loc_7];
                _loc_9 = Config._elementMap[_loc_8];
                _loc_10 = String(Config._skillMap[_loc_9["elemSkillId" + (_loc_2._id + 1)]].description);
                if (_loc_4.level >= _loc_8)
                {
                    _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_5_Green + "\'>Lv" + _loc_8 + ": " + _loc_10 + "</font>");
                }
                else
                {
                    _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_Gray + "\'>Lv" + _loc_8 + ": " + _loc_10 + "</font>");
                }
                _loc_7++;
            }
            Holder.showInfo(_loc_5, new Rectangle(_loc_3.x, _loc_3.y, 25, 26));
            _loc_2.removeEventListener(MouseEvent.ROLL_OUT, this.handleMiniRollout);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleMiniRollout);
            return;
        }// end function

        private function handleMiniRollout(event:MouseEvent)
        {
            var _loc_2:* = Ball(event.currentTarget);
            _loc_2.removeEventListener(MouseEvent.ROLL_OUT, this.handleMiniRollout);
            Holder.closeInfo();
            return;
        }// end function

        private function sel(event:MouseEvent)
        {
            var _loc_3:* = null;
            var _loc_2:* = Ball(event.currentTarget);
            if (_loc_2 != this._selectedBig)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_ELEMENT_SEL);
                _loc_3.add8((_loc_2._id + 1));
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        private function update(event:MouseEvent)
        {
            var _loc_2:* = null;
            if (this._selectedBig != null)
            {
                _loc_2 = this._balls[this._selectedBig._id];
                AlertUI.remove(this._alertID);
                if (_loc_2.level < Setting.ELEMENT_MAX_LEVEL)
                {
                    if (this._exp < int(Config._elementMap[(_loc_2.level + 1)].levelExp))
                    {
                        this._alertID = AlertUI.alert(Config.language("ElementUI", 7), Config.language("ElementUI", 10), [Config.language("ElementUI", 9)]);
                    }
                    else
                    {
                        this._alertID = AlertUI.alert(Config.language("ElementUI", 7), Config.language("ElementUI", 11, _loc_2.name, _loc_2.level, (_loc_2.level + 1), Config._elementMap[(_loc_2.level + 1)].levelExp), [Config.language("ElementUI", 12), Config.language("ElementUI", 13)], [this.updateConfirm]);
                    }
                }
                else
                {
                    this._alertID = AlertUI.alert(Config.language("ElementUI", 7), Config.language("ElementUI", 14, _loc_2.name), [Config.language("ElementUI", 9)]);
                }
            }
            return;
        }// end function

        private function updateConfirm(param1 = null)
        {
            var _loc_2:* = null;
            if (this._selectedBig != null)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_ELEMENT_UPGRADE);
                _loc_2.add8((this._selectedBig._id + 1));
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function reset(event:MouseEvent)
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this._selectedBig != null)
            {
                _loc_2 = this._balls[this._selectedBig._id];
                if (_loc_2.level > 0)
                {
                    _loc_3 = 0;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_2.level)
                    {
                        
                        _loc_3 = _loc_3 + int(Config._elementMap[(_loc_4 + 1)].levelExp);
                        _loc_4++;
                    }
                    AlertUI.remove(this._alertID);
                    this._alertID = AlertUI.alert(Config.language("ElementUI", 7), Config.language("ElementUI", 15, _loc_2.name, _loc_3), [Config.language("ElementUI", 12), Config.language("ElementUI", 13)], [this.resetConfirm]);
                }
            }
            return;
        }// end function

        private function resetConfirm(param1 = null)
        {
            var _loc_2:* = null;
            if (this._selectedBig != null)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_ELEMENT_EXP_RESET);
                _loc_2.add8((this._selectedBig._id + 1));
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function handleSel(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedByte();
            var _loc_5:* = _loc_2.readUnsignedByte();
            if (_loc_3 == Player._playerId && _loc_4 > 0)
            {
                if (this._balls[(_loc_4 - 1)].big != this._selectedBig)
                {
                    if (this._selectedBig != null)
                    {
                        this._selectedBig.selected = false;
                    }
                    this.setSelected(_loc_4);
                    Config.player.addEffect("1173");
                    BubbleUI.bubble(Config.language("ElementUI", 16, this._balls[(_loc_4 - 1)].name, this._balls[(_loc_4 - 1)].level));
                    GuideUI.testDoId(83, this._upgradePB);
                }
            }
            var _loc_6:* = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3);
            if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3) != null)
            {
                _loc_6.setWeaponElement(_loc_4, _loc_5);
            }
            return;
        }// end function

        private function handleUpdate(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedByte();
            this.setLevel(_loc_3, _loc_4);
            Config.player.addEffect("1173");
            BubbleUI.bubble(Config.language("ElementUI", 17, this._balls[(_loc_3 - 1)].name, _loc_4));
            return;
        }// end function

        private function handleReset(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 1)
            {
                this.setLevel((this._selectedBig._id + 1), 0);
            }
            return;
        }// end function

        private function handleList(param1)
        {
            var _loc_7:* = 0;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 > 0)
            {
                this.setSelected(_loc_3);
            }
            var _loc_4:* = _loc_2.readUnsignedInt();
            this.setExp(_loc_4);
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = 0;
            while (_loc_6 < 5)
            {
                
                _loc_7 = _loc_2.readUnsignedByte();
                this.setLevel((_loc_6 + 1), _loc_7);
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        private function handleExp(param1)
        {
            var _loc_5:* = null;
            var _loc_2:* = this._exp;
            var _loc_3:* = param1.data;
            var _loc_4:* = _loc_3.readUnsignedInt();
            this.setExp(_loc_4);
            if (_loc_4 > _loc_2)
            {
                _loc_5 = Config.language("ElementUI", 18, _loc_4 - _loc_2);
                Config.addHistory(_loc_5);
                BubbleUI.bubble(_loc_5, 16776960);
            }
            return;
        }// end function

        private function setLevel(param1:int, param2:int)
        {
            this._balls[(param1 - 1)].level = param2;
            this._balls[(param1 - 1)].tf.text = "" + param2;
            this._balls[(param1 - 1)].tf.x = this._miniPos[(param1 - 1)] + 10 - this._balls[(param1 - 1)].tf.width / 2;
            if (param2 > 0)
            {
                this._balls[(param1 - 1)].big.enabled = true;
            }
            else
            {
                this._balls[(param1 - 1)].big.enabled = false;
            }
            if (param2 >= 10)
            {
                this._balls[(param1 - 1)].mini.enabled = true;
            }
            else
            {
                this._balls[(param1 - 1)].mini.enabled = false;
            }
            this.refreshCurrent();
            return;
        }// end function

        public function getLevel(param1:int) : int
        {
            if (this._balls[(param1 - 1)] == null)
            {
                return 0;
            }
            return this._balls[(param1 - 1)].level;
        }// end function

        private function setSelected(param1)
        {
            this._selectedBig = this._balls[(param1 - 1)].big;
            this._selectedBig.selected = true;
            this._showBall.copy(this._selectedBig);
            addChild(this._showBall);
            this.refreshCurrent();
            return;
        }// end function

        private function setExp(param1:int)
        {
            this._exp = param1;
            this._expTF.text = Config.language("ElementUI", 19, param1);
            this._expTF.x = 130 - this._expTF.width / 2;
            this.refreshCurrent();
            return;
        }// end function

        private function refreshCurrent()
        {
            var _loc_1:* = undefined;
            if (this._selectedBig != null)
            {
                this._levelTF.text = "Lv" + this._balls[this._selectedBig._id].level;
                this._dmgTF.x = this._levelTF.x + this._levelTF.width + 5;
                _loc_1 = 0;
                if (this._balls[this._selectedBig._id].level == 0)
                {
                    _loc_1 = 0;
                    this._dmgTF.text = Config.language("ElementUI", this._balls[this._selectedBig._id].propName, 0);
                }
                else
                {
                    _loc_1 = Config._elementMap[this._balls[this._selectedBig._id].level]["elem" + (this._selectedBig._id + 1)];
                }
                if (this._selectedBig._id == 0)
                {
                    this._dmgTF.text = Config.language("ElementUI", 22, _loc_1);
                }
                else if (this._selectedBig._id == 1)
                {
                    this._dmgTF.text = Config.language("ElementUI", 23, _loc_1);
                }
                else if (this._selectedBig._id == 2)
                {
                    this._dmgTF.text = Config.language("ElementUI", 24, _loc_1);
                }
                else if (this._selectedBig._id == 3)
                {
                    this._dmgTF.text = Config.language("ElementUI", 25, _loc_1);
                }
                else if (this._selectedBig._id == 4)
                {
                    this._dmgTF.text = Config.language("ElementUI", 26, _loc_1);
                }
                if (this._balls[this._selectedBig._id].level < Setting.ELEMENT_MAX_LEVEL)
                {
                    this._expBar.maximum = int(Config._elementMap[(this._balls[this._selectedBig._id].level + 1)].levelExp);
                    this._expBar.value = this._exp;
                }
                else
                {
                    this._expBar.maximum = 100;
                    this._expBar.value = 100;
                }
            }
            else
            {
                this._levelTF.text = Config.language("ElementUI", 21);
                this._dmgTF.text = "";
                this._expBar.maximum = 100;
                this._expBar.value = 0;
            }
            return;
        }// end function

    }
}

import com.bit101.components.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.text.*;

import flash.utils.*;

import lovefox.socket.*;

import lovefox.unit.*;

class Ball extends Sprite
{
    public var _id:int;
    private var _bmp:Bitmap;
    private var _darkBmpd:BitmapData;
    private var _colorBmpd:BitmapData;
    private var _enabled:Boolean = false;
    private var _selected:Boolean = false;
    private var _effect:GClip;

    function Ball(param1:int, param2:BitmapData = null, param3:BitmapData = null)
    {
        this._id = param1;
        this._bmp = new Bitmap();
        addChild(this._bmp);
        if (BitmapData != null)
        {
            this._darkBmpd = param2;
            this._colorBmpd = param3;
            this.enabled = false;
        }
        return;
    }// end function

    public function copy(param1:Ball)
    {
        this._darkBmpd = param1._darkBmpd;
        this._colorBmpd = param1._colorBmpd;
        this.enabled = this._enabled;
        return;
    }// end function

    public function set selected(param1:Boolean) : void
    {
        if (this._selected != param1)
        {
            this._selected = param1;
            if (this._selected)
            {
                this._effect = GClip.newGClip("element" + this._id);
                this._effect.x = -4;
                this._effect.y = -31;
                addChild(this._effect);
                addChild(this._bmp);
            }
            else if (this._effect != null)
            {
                if (this._effect.parent != null)
                {
                    this._effect.parent.removeChild(this._effect);
                }
                this._effect.destroy();
                this._effect = null;
            }
        }
        return;
    }// end function

    public function get selected() : Boolean
    {
        return this._selected;
    }// end function

    public function set enabled(param1:Boolean) : void
    {
        this._enabled = param1;
        if (this._darkBmpd != null)
        {
            if (this._enabled)
            {
                this._bmp.bitmapData = this._colorBmpd;
            }
            else
            {
                this._bmp.bitmapData = this._darkBmpd;
            }
        }
        return;
    }// end function

    public function get enabled() : Boolean
    {
        return this._enabled;
    }// end function

}

