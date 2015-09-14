package ending
{
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EndingChronology extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_CHANGE_EMPEROR:int = 11;
        private const _PHASE_CLOSE:int = 99;
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _chronologicalTable:EndingChronologyTable;
        private var _phase:int;
        private var _bEnd:Boolean;
        private var _aEmperorMc:Array;

        public function EndingChronology(param1:DisplayObjectContainer, param2:Array, param3:Array)
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_Result.swf", "ResultMainMc");
            param1.addChild(this._baseMc);
            this._isoBase = new InStayOut(this._baseMc);
            this._chronologicalTable = new EndingChronologyTable(this._baseMc.chronologicalTableMc, param2);
            this._aEmperorMc = [];
            for each (_loc_4 in param3)
            {
                
                _loc_5 = PlayerManager.getInstance().getPlayerInformation(_loc_4);
                _loc_6 = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_5.bustUpFileName);
                if (_loc_6)
                {
                    _loc_6.smoothing = true;
                    _loc_6.x = (-_loc_6.width) / 2;
                    _loc_6.y = -_loc_6.height;
                    if (_loc_5.id == PlayerId.ID_Jean_CL02_SR)
                    {
                        _loc_6.y = _loc_6.y + 200;
                    }
                    _loc_6.alpha = this._aEmperorMc.length == 0 ? (1) : (0);
                    this._baseMc.charaNull.addChild(_loc_6);
                    this._aEmperorMc.push(_loc_6);
                }
            }
            TextControl.setText(this._baseMc.resultMc.nextBtnMc.textMc.textDt, "");
            SoundManager.getInstance().playBgm(SoundId.BGM_DEM_ENDING_CREDIT);
            this._bEnd = true;
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            if (this._chronologicalTable)
            {
                this._chronologicalTable.release();
            }
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait(param1);
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoBase.setIn();
            this._bEnd = false;
            return;
        }// end function

        private function controlOpen() : void
        {
            if (!this._isoBase.bAnimetionOpen)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._chronologicalTable.openTable();
            return;
        }// end function

        private function controlWait(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this._chronologicalTable.control(param1);
            if (this._chronologicalTable.bEnd)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            var _loc_2:* = this._chronologicalTable.getCurrentChapter();
            if (_loc_2 == Constant.UNDECIDED)
            {
                return;
            }
            for each (_loc_3 in this._aEmperorMc)
            {
                
                _loc_4 = Math.abs(this._aEmperorMc.indexOf(_loc_3) - (_loc_2 - 1));
                if (_loc_4 == 0)
                {
                    _loc_3.alpha = Math.min(_loc_3.alpha + param1 / 2, 1);
                    continue;
                }
                if (_loc_4 == 1)
                {
                    _loc_3.alpha = Math.max(_loc_3.alpha - param1 / 2, 0);
                    continue;
                }
                _loc_3.alpha = 0;
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoBase.setOut();
            Main.GetProcess().fade.setFadeOut(2);
            SoundManager.getInstance().stopBgm();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoBase.bEnd && Main.GetProcess().fade.isFadeEnd())
            {
                this._bEnd = true;
            }
            return;
        }// end function

    }
}
