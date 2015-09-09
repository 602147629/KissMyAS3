package lovefox.unit
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import lovefox.gui.*;

    public class StateBar extends Sprite
    {
        private var _mood:GClip;
        public var _hpBar:HpBar;
        private var _gatherBar:Bar;
        private var _nameTxt:TextField;
        private var _titleTxt:TextField;
        private var _gildtext:TextField;
        private var _biaochetext:TextField;
        private var _unit:Unit;
        public var _stallpanel:Panel;
        private var _stalltitleText:TextField;
        private var _visible:Boolean = false;
        private var _x:int;
        private var _y:int;
        private var _h:int;
        private var leadericon:Sprite;
        private var _flagBmps:Array;
        private var _winflagBmp:Bitmap;
        private static var _flagBmpd:BitmapData;
        private static var _winflagBmpd:BitmapData;
        private static var _flagInited:Boolean = false;
        private static var _inWar:Boolean = false;

        public function StateBar(param1)
        {
            this._flagBmps = [];
            this._unit = param1;
            this._mood = GClip.newGClip();
            addChild(this._mood);
            this._mood.y = -30;
            this._hpBar = HpBar.create(40, 5, -20, this._h, 52224);
            this._gatherBar = Bar.create(40, 5, -20, this._h + 10, 204);
            this._nameTxt = Config.getSimpleTextField();
            this._nameTxt.textColor = 16777215;
            this._nameTxt.y = -20;
            addChild(this._nameTxt);
            this._titleTxt = Config.getSimpleTextField();
            this._titleTxt.textColor = 16777215;
            this._titleTxt.y = -36;
            addChild(this._titleTxt);
            this._biaochetext = Config.getSimpleTextField();
            this._biaochetext.textColor = 16570368;
            this._biaochetext.y = this._nameTxt.y - 20;
            this._gildtext = Config.getSimpleTextField();
            this._gildtext.textColor = 16777215;
            this._gildtext.y = -36;
            addChild(this._gildtext);
            var _loc_2:* = new DropShadowFilter(0.1, 45, 3342336, 0.5, 1, 1, 50, 1, false, false);
            var _loc_3:* = new Array();
            _loc_3.push(_loc_2);
            this._gildtext.filters = _loc_3;
            this._nameTxt.filters = _loc_3;
            this._titleTxt.filters = _loc_3;
            this._biaochetext.filters = _loc_3;
            this.leadericon = new Sprite();
            var _loc_4:* = new Bitmap(Config.findsysUI("team/flag", 19, 20));
            this.leadericon.addChild(_loc_4);
            this.leadericon.y = -55;
            this.leadericon.x = -8;
            this.check();
            return;
        }// end function

        public function checkFlag()
        {
            var _loc_3:* = 0;
            initFlag();
            var _loc_1:* = 0;
            if (Config._flagList[this._unit.id] != null)
            {
                _loc_1 = Config._flagList[this._unit.id];
            }
            if (this._flagBmps.length < _loc_1)
            {
                _loc_3 = this._flagBmps.length;
                while (_loc_3 < _loc_1)
                {
                    
                    this._flagBmps[_loc_3] = new Bitmap(_flagBmpd);
                    addChild(this._flagBmps[_loc_3]);
                    this._flagBmps[_loc_3].y = -65;
                    _loc_3++;
                }
            }
            else
            {
                _loc_3 = _loc_1;
                while (_loc_3 < this._flagBmps.length)
                {
                    
                    this._flagBmps[_loc_3].parent.removeChild(this._flagBmps[_loc_3]);
                    _loc_3++;
                }
                this._flagBmps.length = _loc_1;
            }
            var _loc_2:* = 32;
            _loc_3 = 0;
            while (_loc_3 < this._flagBmps.length)
            {
                
                this._flagBmps[_loc_3].x = (-(this._flagBmps.length - 1)) * _loc_2 / 2 + _loc_3 * _loc_2 - _flagBmpd.width / 2;
                _loc_3++;
            }
            return;
        }// end function

        public function checkWinflag()
        {
            initFlag();
            var _loc_1:* = Config._winflag;
            if (Config._winflag == this._unit.id)
            {
                if (this._winflagBmp == null)
                {
                    this._winflagBmp = new Bitmap(_winflagBmpd);
                    this._winflagBmp.y = -65;
                    this._winflagBmp.x = (-_winflagBmpd.width) / 2;
                    addChild(this._winflagBmp);
                }
            }
            else if (this._winflagBmp != null)
            {
                this._winflagBmp.parent.removeChild(this._winflagBmp);
                this._winflagBmp = null;
            }
            return;
        }// end function

        private function clearFlag()
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._flagBmps.length)
            {
                
                this._flagBmps[_loc_1].parent.removeChild(this._flagBmps[_loc_1]);
                _loc_1++;
            }
            this._flagBmps = [];
            if (this._winflagBmp != null)
            {
                this._winflagBmp.parent.removeChild(this._winflagBmp);
                this._winflagBmp = null;
            }
            return;
        }// end function

        public function setBiaoche(param1 = "")
        {
            if (param1 == "")
            {
                if (this._biaochetext.parent != null)
                {
                    this._biaochetext.parent.removeChild(this._biaochetext);
                }
            }
            else
            {
                this._biaochetext.text = param1;
                this._biaochetext.x = (-this._biaochetext.width) / 2;
                if (this._biaochetext.parent == null)
                {
                    addChild(this._biaochetext);
                }
                this._biaochetext.y = this._nameTxt.y - 20;
            }
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            this._visible = param1;
            if (this._visible)
            {
                if (this._unit._map != null && this.parent != this._unit._map._textMap)
                {
                    this._unit._map._textMap.addChild(this);
                    this.setPos(this._x, this._y, this._h);
                }
            }
            else if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        override public function get visible() : Boolean
        {
            return this._visible;
        }// end function

        public function setPos(param1, param2, param3 = null)
        {
            this._x = param1;
            this._y = param2;
            if (this._visible)
            {
                x = this._x;
                y = this._y;
            }
            if (param3 != null)
            {
                this._h = param3;
                this._hpBar.y = this._h + 10;
                this._gatherBar.y = this._h + 20;
            }
            return;
        }// end function

        public function destroyStall()
        {
            if (this._stallpanel != null)
            {
                this._stallpanel.buttonMode = true;
                this._stallpanel.removeEventListener(MouseEvent.ROLL_OVER, this.handleStallpanelMouseOver);
                this._stallpanel.removeEventListener(MouseEvent.ROLL_OUT, this.handleStallpanelMouseOut);
                this._stallpanel.removeEventListener(Event.REMOVED_FROM_STAGE, this.handleStallpanelMouseOut);
                if (this._stallpanel.parent == this)
                {
                    this.removeChild(this._stallpanel);
                }
            }
            return;
        }// end function

        public function destroy()
        {
            this.clearFlag();
            this.destroyStall();
            this._mood.clear();
            if (this._hpBar.parent == this)
            {
                removeChild(this._hpBar);
            }
            if (this._gatherBar.parent == this)
            {
                removeChild(this._gatherBar);
            }
            if (this._biaochetext.parent == this)
            {
                removeChild(this._biaochetext);
            }
            this._nameTxt.textColor = 16777215;
            this._nameTxt.text = "";
            this._titleTxt.text = "";
            this._gildtext.text = "";
            this._biaochetext.text = "";
            this.visible = false;
            if (this.leadericon.parent != null)
            {
                this.removeChild(this.leadericon);
            }
            return;
        }// end function

        public function hide()
        {
            return;
        }// end function

        public function check()
        {
            var _loc_1:* = false;
            if (this._unit is Player || this._biaochetext.parent != null)
            {
                if (this._hpBar.parent != this)
                {
                    addChild(this._hpBar);
                }
                if (this._nameTxt.parent != this)
                {
                    addChild(this._nameTxt);
                }
                if (this._titleTxt.parent != this)
                {
                    addChild(this._titleTxt);
                }
                if (_inWar)
                {
                    if (this._titleTxt.parent != null)
                    {
                        this._titleTxt.parent.removeChild(this._titleTxt);
                    }
                    if (this._gildtext.parent != null)
                    {
                        this._gildtext.parent.removeChild(this._gildtext);
                    }
                }
                this.visible = true;
            }
            else if (this._unit.type == UNIT_TYPE_ENUM.TYPEID_NPC)
            {
                if (this._unit._forceClip >= 0 && Number(this._unit._data.effectOnly) == 0)
                {
                    this.visible = true;
                }
            }
            else if (this._unit.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                if (Config.player != null && Config.player.tracingTarget != null && Config.player.tracingTarget == this._unit || EventMouse._hoverUnit == this._unit || this._unit.hp < this._unit.hpMax)
                {
                    if (this._hpBar.parent != this)
                    {
                        addChild(this._hpBar);
                    }
                    _loc_1 = true;
                }
                else if (this._hpBar.parent == this)
                {
                    removeChild(this._hpBar);
                }
                this.visible = _loc_1;
            }
            else if (this._unit.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
            {
                if (this._nameTxt.parent != this)
                {
                    addChild(this._nameTxt);
                }
                if (this._titleTxt.parent != this)
                {
                    addChild(this._titleTxt);
                }
                if (Config.player != null && Config.player.tracingTarget != null && Config.player.tracingTarget == this._unit || EventMouse._hoverUnit == this._unit || this._unit.hp < this._unit.hpMax)
                {
                    if (this._nameTxt.parent != this)
                    {
                        addChild(this._nameTxt);
                    }
                    if (this._titleTxt.parent != this)
                    {
                        addChild(this._titleTxt);
                    }
                    if (this._hpBar.parent != this)
                    {
                        addChild(this._hpBar);
                    }
                }
                if (_inWar)
                {
                    if (this._titleTxt.parent != null)
                    {
                        this._titleTxt.parent.removeChild(this._titleTxt);
                    }
                    if (this._gildtext.parent != null)
                    {
                        this._gildtext.parent.removeChild(this._gildtext);
                    }
                }
                this.visible = true;
            }
            else if (this._unit.type == UNIT_TYPE_ENUM.TYPEID_TDTARGET)
            {
                if (this._hpBar.parent != this)
                {
                    addChild(this._hpBar);
                }
                _loc_1 = true;
                this.visible = _loc_1;
            }
            else
            {
                this.visible = false;
            }
            return;
        }// end function

        public function set pkValue(param1)
        {
            return;
        }// end function

        public function set pkState(param1)
        {
            return;
        }// end function

        private function nameTitleMoodY()
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._unit.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
            {
                if (this._gildtext.parent == null)
                {
                    _loc_3 = -20;
                }
                else
                {
                    this._gildtext.x = (-this._gildtext.width) / 2;
                    this._gildtext.y = -20;
                    _loc_3 = -36;
                }
                if (this._nameTxt.parent == this && this._nameTxt.text != "" && this._titleTxt.parent == this && this._titleTxt.text != "")
                {
                    _loc_1 = _loc_1 + 16;
                    this._nameTxt.y = _loc_3;
                    this._titleTxt.y = _loc_3;
                    this._titleTxt.x = (-(this._titleTxt.width + this._nameTxt.width + 2)) / 2;
                    this._nameTxt.x = this._titleTxt.x + this._titleTxt.width + 2;
                }
                else if (this._titleTxt.parent == this && this._titleTxt.text != "")
                {
                    _loc_1 = _loc_1 + 16;
                    this._titleTxt.y = _loc_3;
                    this._titleTxt.x = (-this._titleTxt.width) / 2;
                }
                else if (this._nameTxt.parent == this && this._nameTxt.text != "")
                {
                    _loc_1 = _loc_1 + 16;
                    this._nameTxt.y = _loc_3;
                    this._nameTxt.x = (-this._nameTxt.width) / 2;
                }
                this._mood.y = -5 - _loc_1;
            }
            else
            {
                this._nameTxt.x = (-this._nameTxt.width) / 2;
                this._titleTxt.x = (-this._titleTxt.width) / 2;
                if (this._nameTxt.parent == this && this._nameTxt.text != "")
                {
                    this._nameTxt.y = -20;
                }
                if (this._titleTxt.parent == this && this._titleTxt.text != "")
                {
                    this._titleTxt.y = -36;
                }
                if (this._nameTxt.parent == this && this._nameTxt.text != "")
                {
                    _loc_1 = _loc_1 + 16;
                }
                if (this._titleTxt.parent == this && this._titleTxt.text != "")
                {
                    _loc_1 = _loc_1 + 16;
                }
                this._mood.y = -5 - _loc_1;
            }
            if (this._biaochetext.parent != null)
            {
                this._biaochetext.y = this._nameTxt.y - 20;
            }
            return;
        }// end function

        public function set mood(param1)
        {
            this._mood.style = param1;
            if (param1 == null)
            {
                if (this._mood.parent != null)
                {
                    this._mood.parent.removeChild(this._mood);
                }
            }
            else
            {
                if (this._mood.parent == null)
                {
                    addChild(this._mood);
                }
                this.nameTitleMoodY();
            }
            return;
        }// end function

        public function get mood()
        {
            return this._mood;
        }// end function

        public function set hp(param1)
        {
            this._hpBar.per = param1;
            return;
        }// end function

        public function set gather(param1)
        {
            if (param1 < 0)
            {
                if (this._gatherBar.parent == this)
                {
                    removeChild(this._gatherBar);
                }
            }
            else
            {
                this._gatherBar.per = 1 - param1;
                if (this._gatherBar.parent == null)
                {
                    addChild(this._gatherBar);
                }
            }
            return;
        }// end function

        override public function set name(param1:String) : void
        {
            if (param1 != null)
            {
                this._nameTxt.text = param1;
            }
            this.nameTitleMoodY();
            return;
        }// end function

        public function set title(param1:String) : void
        {
            if (param1 != null)
            {
                this._titleTxt.text = param1;
            }
            this.nameTitleMoodY();
            return;
        }// end function

        public function set titleId(param1:uint) : void
        {
            if (param1 == 0)
            {
                this._titleTxt.text = "";
            }
            else
            {
                this._titleTxt.text = Config._titleMap[param1].name;
            }
            this.nameTitleMoodY();
            return;
        }// end function

        public function setstallpanel(param1:String)
        {
            this.destroyStall();
            var _loc_2:* = new Label(null, 0, 0, param1);
            this._stallpanel = new Panel(null, (-(_loc_2.width + 10)) / 2, -30);
            this._stallpanel.mouseEnabled = true;
            this._stallpanel.width = _loc_2.width + 10;
            this._stallpanel.height = 26;
            this._stallpanel.color = Style.WINDOW;
            this._stallpanel.border = 2;
            this._stalltitleText = Config.getSimpleTextField();
            this._stalltitleText.autoSize = TextFieldAutoSize.CENTER;
            this._stalltitleText.width = _loc_2.width + 10;
            this._stalltitleText.height = 26;
            this._stalltitleText.x = (_loc_2.width + 10) / 2;
            this._stalltitleText.y = 5;
            this._stalltitleText.mouseEnabled = false;
            this._stallpanel.addChild(this._stalltitleText);
            this._stallpanel.buttonMode = true;
            this._stallpanel.removeEventListener(MouseEvent.ROLL_OVER, this.handleStallpanelMouseOver);
            this._stallpanel.removeEventListener(MouseEvent.ROLL_OUT, this.handleStallpanelMouseOut);
            this._stallpanel.removeEventListener(Event.REMOVED_FROM_STAGE, this.handleStallpanelMouseOut);
            this._stallpanel.addEventListener(MouseEvent.ROLL_OVER, this.handleStallpanelMouseOver);
            this._stallpanel.addEventListener(MouseEvent.ROLL_OUT, this.handleStallpanelMouseOut);
            this._stallpanel.addEventListener(Event.REMOVED_FROM_STAGE, this.handleStallpanelMouseOut);
            this._stalltitleText.text = param1;
            if (this._stallpanel.parent != this)
            {
                this.addChild(this._stallpanel);
            }
            return;
        }// end function

        private function handleStallpanelMouseOver(param1)
        {
            Config.buttonLock = true;
            return;
        }// end function

        private function handleStallpanelMouseOut(param1)
        {
            Config.buttonLock = false;
            return;
        }// end function

        public function set nameColor(param1) : void
        {
            this._nameTxt.textColor = param1;
            return;
        }// end function

        public function set titleColor(param1) : void
        {
            this._titleTxt.textColor = param1;
            return;
        }// end function

        public function setgild(param1:String, param2:String, param3:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1 == "" || _inWar)
            {
                this._gildtext.htmlText = "";
                if (this._gildtext.parent != null)
                {
                    this._gildtext.parent.removeChild(this._gildtext);
                }
            }
            else
            {
                _loc_4 = /<""</g;
                _loc_5 = />"">/g;
                param1 = param1.replace(_loc_4, "&lt;");
                param1 = param1.replace(_loc_4, "&gt;");
                this._gildtext.htmlText = "<FONT SIZE=\'12\' COLOR=\'" + param2 + "\'>&lt;" + param1 + "&gt;</FONT>" + "<FONT SIZE=\'12\' COLOR=\'#3D5489\'>" + param3 + "</FONT>";
                if (this._gildtext.parent == null)
                {
                    addChild(this._gildtext);
                }
            }
            this.nameTitleMoodY();
            return;
        }// end function

        public function redraw()
        {
            return;
        }// end function

        public function set teamflag(param1:Boolean) : void
        {
            if (param1)
            {
                this.addChild(this.leadericon);
            }
            else if (this.leadericon.parent != null)
            {
                this.removeChild(this.leadericon);
            }
            return;
        }// end function

        public function get teamflag() : Boolean
        {
            if (this.leadericon.parent != null)
            {
                return true;
            }
            return false;
        }// end function

        public static function set inWar(param1:Boolean)
        {
            _inWar = param1;
            Config.player._stateBar.check();
            return;
        }// end function

        public static function get inWar() : Boolean
        {
            return _inWar;
        }// end function

        private static function initFlag()
        {
            if (!_flagInited)
            {
                _flagInited = true;
                _flagBmpd = Config.findsysUI("battlefield/flag", 32, 32);
                _winflagBmpd = Config.findsysUI("battlefield/winflag", 32, 32);
            }
            return;
        }// end function

    }
}
