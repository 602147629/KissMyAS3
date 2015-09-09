package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.text.*;
    import lovefox.unit.*;

    public class SoulUI extends Sprite
    {
        private var _opening:Boolean = false;
        private var _soulClip:UnitClip;
        private var _bgTable:Table;
        private var _amountTxt:TextField;
        private var _timeLeftTxt:TextField;
        private var _numLeftTxt:TextField;
        private var _size:Object = 32;
        private var _index:int = -1;
        private var _container:DisplayObjectContainer;
        private var _preOpenTime:Object;
        private var _timeleftTimer:Object;
        public var _std:uint = 0;
        public static var _grayFilter:Object = new ColorMatrixFilter([0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0]);

        public function SoulUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            x = param2;
            y = param3;
            this._container = param1;
            this._bgTable = new Table("table1");
            this._bgTable.resize(this._size + 4, this._size + 4);
            this._amountTxt = Config.getSimpleTextField();
            this._amountTxt.autoSize = TextFieldAutoSize.RIGHT;
            this._amountTxt.textColor = 16777215;
            this._amountTxt.y = this._size - 16;
            this._amountTxt.x = this._size - 5;
            this._amountTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._amountTxt);
            this._timeLeftTxt = Config.getSimpleTextField();
            this._timeLeftTxt.textColor = 16777215;
            this._timeLeftTxt.y = 0;
            this._timeLeftTxt.x = this._size + 5;
            this._timeLeftTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._timeLeftTxt);
            this._numLeftTxt = Config.getSimpleTextField();
            this._numLeftTxt.textColor = 16777215;
            this._numLeftTxt.y = this._size - 16;
            this._numLeftTxt.x = this._size + 5;
            this._numLeftTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._numLeftTxt);
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function refreshModel()
        {
            if (this._opening)
            {
                this.setSoul(this._index, true);
            }
            return;
        }// end function

        public function setSoul(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            if (this._index == -1)
            {
                GuideUI.testDoId(129, Config.ui._quickUI._picksoulSlot);
            }
            if (this._index != param1 || param2)
            {
                if (this._soulClip != null)
                {
                    this._soulClip.filters = [];
                    this._soulClip.destroy();
                    if (this._soulClip.parent != null)
                    {
                        this._soulClip.parent.removeChild(this._soulClip);
                    }
                }
                this._index = param1;
                _loc_3 = 1145;
                if (this._index == 1)
                {
                    _loc_3 = 1145;
                }
                else if (this._index == 2)
                {
                    _loc_3 = 1146;
                }
                else if (this._index == 3)
                {
                    _loc_3 = 1147;
                }
                this._soulClip = UnitClip.newUnitClip(Config._model[_loc_3]);
                this._soulClip.shadow = false;
                this._soulClip.x = (this._size + 4) / 2;
                this._soulClip.y = this._size + 4;
                addChild(this._soulClip);
                this._soulClip.changeStateTo("idle");
                addChild(this._amountTxt);
                addChild(this._timeLeftTxt);
                addChild(this._numLeftTxt);
                if (Number(this._amountTxt.text) < 5)
                {
                    GuideUI.testDoId(131);
                }
            }
            return;
        }// end function

        public function set award(param1)
        {
            return;
        }// end function

        public function set num(param1)
        {
            var _loc_2:* = undefined;
            if (this._std == 3)
            {
                _loc_2 = 15;
            }
            else
            {
                _loc_2 = 45;
            }
            this._numLeftTxt.text = Config.language("SoulUI", 1, String(_loc_2 - param1));
            return;
        }// end function

        public function set amount(param1)
        {
            if (param1 > Number(this._amountTxt.text))
            {
                if (param1 == 2)
                {
                    GuideUI.testDoId(130);
                }
                else if (param1 == 4)
                {
                    GuideUI.testDoId(132);
                }
                else if (param1 == 5)
                {
                    GuideUI.testDoId(133);
                }
            }
            this._amountTxt.text = String(param1);
            return;
        }// end function

        private function timeLeftLoop()
        {
            var _loc_1:* = undefined;
            if (this._std == 3)
            {
                _loc_1 = Math.floor((1000 * 60 * 5 - (getTimer() - this._preOpenTime)) / 1000);
                this._timeLeftTxt.text = Config.language("SoulUI", 2, Math.max(0, _loc_1));
            }
            else
            {
                this._timeLeftTxt.text = "∞";
            }
            return;
        }// end function

        public function open()
        {
            this._std = Skill.picksoulTimeStd;
            if (!this._opening)
            {
                this._opening = true;
                this._container.addChild(this);
                addChild(this._bgTable);
                this._soulClip = UnitClip.newUnitClip(Config._model[1145]);
                this._soulClip.filters = [_grayFilter];
                this._soulClip.shadow = false;
                this._soulClip.x = (this._size + 4) / 2;
                this._soulClip.y = this._size + 4;
                addChild(this._soulClip);
                this._soulClip.changeStateTo("idle");
                addChild(this._amountTxt);
                addChild(this._timeLeftTxt);
                addChild(this._numLeftTxt);
                this._amountTxt.text = "0";
                this._index = -1;
                this._preOpenTime = getTimer();
                clearInterval(this._timeleftTimer);
                this._timeleftTimer = setInterval(this.timeLeftLoop, 1000);
                this._timeLeftTxt.text = Config.language("SoulUI", 4);
                this.num = 0;
            }
            return;
        }// end function

        public function close()
        {
            if (this._opening)
            {
                clearInterval(this._timeleftTimer);
                this._opening = false;
                if (this.parent != null)
                {
                    this.parent.removeChild(this);
                }
                if (this._bgTable.parent != null)
                {
                    this._bgTable.parent.removeChild(this._bgTable);
                }
                if (this._amountTxt.parent != null)
                {
                    this._amountTxt.parent.removeChild(this._amountTxt);
                }
                if (this._timeLeftTxt.parent != null)
                {
                    this._timeLeftTxt.parent.removeChild(this._timeLeftTxt);
                }
                if (this._numLeftTxt.parent != null)
                {
                    this._numLeftTxt.parent.removeChild(this._numLeftTxt);
                }
                if (this._soulClip != null)
                {
                    this._soulClip.filters = [];
                    this._soulClip.destroy();
                    if (this._soulClip.parent != null)
                    {
                        this._soulClip.parent.removeChild(this._soulClip);
                    }
                }
            }
            return;
        }// end function

    }
}
