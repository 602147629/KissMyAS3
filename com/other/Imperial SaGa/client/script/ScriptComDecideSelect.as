package script
{
    import button.*;
    import sound.*;

    public class ScriptComDecideSelect extends ScriptComBase
    {
        private var _label:String;
        private var _index:int;
        private var _choiceId:int;
        private var _timer:Number;
        private var _changeTimer:Number;
        private static const MAX_TIME:Number = 5;
        private static const CHANGE_SELECT:Number = 1;
        private static const _LABEL_MOUSE_OVER:String = "onMouse";
        private static const _LABEL_MOUSE_OUT:String = "offMouse";

        public function ScriptComDecideSelect()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._label = param1.label;
            return;
        }// end function

        override public function commandInit() : void
        {
            var _loc_2:* = null;
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getAutoSelect();
            for each (_loc_2 in _loc_1.aChoice)
            {
                
                if (_loc_2.label == this._label)
                {
                    this._choiceId = _loc_2.no;
                }
            }
            this._index = 0;
            this._timer = 0;
            this._changeTimer = 0;
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().getAutoSelect();
            _loc_1.setEnd(this._choiceId);
            ScriptManager.getInstance().gotoLabel(this._label);
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this._timer = this._timer + param1;
            this._changeTimer = this._changeTimer + param1;
            var _loc_2:* = ScriptManager.getInstance().getAutoSelect();
            if (_loc_2.bOpened)
            {
                if (this._timer >= MAX_TIME)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2.aButton.length)
                    {
                        
                        _loc_4 = _loc_2.aButton[_loc_3];
                        if (_loc_4.id == this._choiceId)
                        {
                            _loc_4.setClick();
                        }
                        else
                        {
                            _loc_4.getMoveClip().gotoAndStop(_LABEL_MOUSE_OUT);
                        }
                        _loc_3++;
                    }
                }
                else if (this._changeTimer >= CHANGE_SELECT)
                {
                    this._changeTimer = 0;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_2.aButton.length)
                    {
                        
                        _loc_6 = _loc_2.aButton[_loc_5];
                        if (_loc_5 == this._index)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_SELECT_WINDOW);
                            _loc_6.getMoveClip().gotoAndStop(_LABEL_MOUSE_OVER);
                        }
                        else
                        {
                            _loc_6.getMoveClip().gotoAndStop(_LABEL_MOUSE_OUT);
                        }
                        _loc_5++;
                    }
                    var _loc_7:* = this;
                    var _loc_8:* = this._index + 1;
                    _loc_7._index = _loc_8;
                    if ((_loc_2.aButton.length - 1) < this._index)
                    {
                        this._index = 0;
                    }
                }
            }
            if (_loc_2.bClose)
            {
                ScriptManager.getInstance().gotoLabel(this._label);
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
