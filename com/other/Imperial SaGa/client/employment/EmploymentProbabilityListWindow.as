package employment
{
    import button.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class EmploymentProbabilityListWindow extends Object
    {
        private var _phase:int;
        private var _type:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnClose:ButtonBase;
        private var _cbClose:Function;
        private var _bProbabilityUp01:Boolean;
        private var _bProbabilityUp02:Boolean;
        private var _isoProbabilityUp01:InStayOut;
        private var _isoProbabilityUp02:InStayOut;
        private var _fade:Fade;
        private static const _PHASE_OPEN:int = 0;
        private static const _PHASE_INPUT_WAIT:int = 1;
        private static const _PHASE_CLOSE:int = 2;
        public static const TYPE_NORMAL:int = 0;
        public static const TYPE_TWIN:int = 1;
        public static const TYPE_TWIN_FIRST:int = 2;

        public function EmploymentProbabilityListWindow(param1:DisplayObjectContainer, param2:Function, param3:int = 0)
        {
            var _loc_4:* = null;
            this._cbClose = param2;
            this._type = param3;
            if (this._type == TYPE_TWIN)
            {
                _loc_4 = "summary2Mc";
            }
            else if (this._type == TYPE_TWIN_FIRST)
            {
                _loc_4 = "summary3Mc";
            }
            else
            {
                _loc_4 = "summaryMc";
                this._type = TYPE_NORMAL;
            }
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonMenu.swf", _loc_4);
            this._fade = new Fade(param1);
            this._fade.maxAlpha = 0.5;
            this._fade.setFadeIn(0);
            param1.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._btnClose = ButtonManager.getInstance().addButton(this._mcBase.returnBtnMc, this.cbCloseButton);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            if (this._type != TYPE_NORMAL)
            {
                TextControl.setIdText(this._mcBase.summarySetMc.textTitleMc1.textDt, MessageId.EMPLOYMENT_HIGH_EMPLOY_PROBABILITY_LIST_SINGLE);
                TextControl.setIdText(this._mcBase.summarySetMc.textTitleMc2.textDt, MessageId.EMPLOYMENT_HIGH_EMPLOY_PROBABILITY_LIST_BOX);
            }
            this._bProbabilityUp01 = false;
            this._bProbabilityUp02 = false;
            if (this._mcBase.summarySetMc.infoScroll01Mc)
            {
                this._isoProbabilityUp01 = new InStayOut(this._mcBase.summarySetMc.infoScroll01Mc);
            }
            else
            {
                this._isoProbabilityUp01 = null;
            }
            if (this._mcBase.summarySetMc.infoScroll02Mc)
            {
                this._isoProbabilityUp02 = new InStayOut(this._mcBase.summarySetMc.infoScroll02Mc);
            }
            else
            {
                this._isoProbabilityUp02 = null;
            }
            this.btnEnable(false);
            this._phase = _PHASE_CLOSE;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function release() : void
        {
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._isoProbabilityUp02)
            {
                this._isoProbabilityUp02.release();
            }
            this._isoProbabilityUp02 = null;
            if (this._isoProbabilityUp01)
            {
                this._isoProbabilityUp01.release();
            }
            this._isoProbabilityUp01 = null;
            ButtonManager.getInstance().removeButton(this._btnClose);
            this._btnClose = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_INPUT_WAIT:
                {
                    this.initPhaseInputWait();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this.btnEnable(false);
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_INPUT_WAIT);
                return;
            }// end function
            );
            if (this._isoProbabilityUp01)
            {
                if (this._bProbabilityUp01)
                {
                    this._isoProbabilityUp01.setIn();
                }
                else
                {
                    this._isoProbabilityUp01.setOut();
                    this._mcBase.summarySetMc.infoScroll01Mc.visible = false;
                }
            }
            if (this._isoProbabilityUp02)
            {
                if (this._bProbabilityUp02)
                {
                    this._isoProbabilityUp02.setIn();
                }
                else
                {
                    this._isoProbabilityUp02.setOut();
                    this._mcBase.summarySetMc.infoScroll02Mc.visible = false;
                }
            }
            return;
        }// end function

        private function initPhaseInputWait() : void
        {
            this.btnEnable(true);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            this._isoMain.setOut(function () : void
            {
                _cbClose();
                return;
            }// end function
            );
            if (this._isoProbabilityUp01)
            {
                if (this._isoProbabilityUp01.bOpened)
                {
                    this._isoProbabilityUp01.setOut();
                }
            }
            if (this._isoProbabilityUp02)
            {
                if (this._isoProbabilityUp02.bOpened)
                {
                    this._isoProbabilityUp02.setOut();
                }
            }
            return;
        }// end function

        public function open() : void
        {
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function updateProbabilityList(param1:Array, param2:Boolean = false, param3:int = 0) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            if (this._type == TYPE_NORMAL)
            {
                param2 = false;
            }
            var _loc_4:* = [!param2 ? (this._mcBase.summarySetMc.textMc1) : (this._mcBase.summarySetMc.textMc8), !param2 ? (this._mcBase.summarySetMc.textMc2) : (this._mcBase.summarySetMc.textMc9), !param2 ? (this._mcBase.summarySetMc.textMc3) : (this._mcBase.summarySetMc.textMc10), !param2 ? (this._mcBase.summarySetMc.textMc4) : (this._mcBase.summarySetMc.textMc11), !param2 ? (this._mcBase.summarySetMc.textMc5) : (this._mcBase.summarySetMc.textMc12), !param2 ? (this._mcBase.summarySetMc.textMc6) : (this._mcBase.summarySetMc.textMc13), !param2 ? (this._mcBase.summarySetMc.textMc7) : (this._mcBase.summarySetMc.textMc14)];
            var _loc_5:* = [!param2 ? (this._mcBase.summarySetMc.textMc1_red) : (this._mcBase.summarySetMc.textMc8_red), !param2 ? (this._mcBase.summarySetMc.textMc2_red) : (this._mcBase.summarySetMc.textMc9_red), !param2 ? (this._mcBase.summarySetMc.textMc3_red) : (this._mcBase.summarySetMc.textMc10_red), !param2 ? (this._mcBase.summarySetMc.textMc4_red) : (this._mcBase.summarySetMc.textMc11_red), !param2 ? (this._mcBase.summarySetMc.textMc5_red) : (this._mcBase.summarySetMc.textMc12_red), !param2 ? (this._mcBase.summarySetMc.textMc6_red) : (this._mcBase.summarySetMc.textMc13_red), !param2 ? (this._mcBase.summarySetMc.textMc7_red) : (this._mcBase.summarySetMc.textMc14_red)];
            var _loc_6:* = [!param2 ? (this._mcBase.summarySetMc.textRarity1) : (this._mcBase.summarySetMc.textRarity8), !param2 ? (this._mcBase.summarySetMc.textRarity2) : (this._mcBase.summarySetMc.textRarity9), !param2 ? (this._mcBase.summarySetMc.textRarity3) : (this._mcBase.summarySetMc.textRarity10), !param2 ? (this._mcBase.summarySetMc.textRarity4) : (this._mcBase.summarySetMc.textRarity11), !param2 ? (this._mcBase.summarySetMc.textRarity5) : (this._mcBase.summarySetMc.textRarity12), !param2 ? (this._mcBase.summarySetMc.textRarity6) : (this._mcBase.summarySetMc.textRarity13), !param2 ? (this._mcBase.summarySetMc.textRarity7) : (this._mcBase.summarySetMc.textRarity14)];
            for each (_loc_7 in _loc_4)
            {
                
                if (_loc_7)
                {
                    _loc_7.visible = false;
                    TextControl.setText(_loc_7.textDt, "");
                }
            }
            for each (_loc_7 in _loc_5)
            {
                
                if (_loc_7)
                {
                    _loc_7.visible = false;
                    TextControl.setText(_loc_7.textDt, "");
                }
            }
            for each (_loc_7 in _loc_6)
            {
                
                if (_loc_7)
                {
                    _loc_7.visible = false;
                    TextControl.setText(_loc_7.textDt, "");
                }
            }
            _loc_8 = 0;
            while (_loc_8 < param1.length)
            {
                
                _loc_10 = param1[_loc_8];
                if (_loc_10.rarity <= 0 || _loc_10.ratio == 0)
                {
                }
                else
                {
                    _loc_11 = _loc_4[_loc_8];
                    _loc_12 = _loc_5[_loc_8];
                    _loc_13 = _loc_6[_loc_8];
                    if (_loc_11 == null || _loc_13 == null)
                    {
                    }
                    else
                    {
                        if (_loc_12 && param3 > 0)
                        {
                            _loc_11 = _loc_12;
                        }
                        _loc_11.visible = true;
                        _loc_13.visible = true;
                        _loc_14 = _loc_10.ratio / 100;
                        TextControl.setText(_loc_11.textDt, _loc_14.toFixed(2));
                        TextControl.setText(_loc_13.textDt, PlayerManager.getInstance().getRarityText(_loc_10.rarity));
                    }
                }
                _loc_8++;
            }
            if (!param2)
            {
                this._bProbabilityUp01 = param3 > 0;
            }
            else
            {
                this._bProbabilityUp02 = param3 > 0;
            }
            if (param3 > 0)
            {
                _loc_9 = !param2 ? (this._mcBase.summarySetMc.infoScroll01Mc) : (this._mcBase.summarySetMc.infoScroll02Mc);
                if (_loc_9)
                {
                    TextControl.setText(_loc_9.textMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_FIRST_PROBABILITY_UP2, PlayerManager.getInstance().getRarityText(param3)));
                }
            }
            _loc_9 = !param2 ? (this._mcBase.summarySetMc.Blink01Mc) : (this._mcBase.summarySetMc.Blink01Mc);
            if (_loc_9)
            {
                if (param3 > 0)
                {
                    _loc_9.gotoAndStop("loop");
                    _loc_9.visible = true;
                }
                else
                {
                    _loc_9.gotoAndStop("stop");
                    _loc_9.visible = false;
                }
            }
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            this._btnClose.setDisableFlag(!param1);
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        public static function checkProbabilityUpRarity(param1:Array, param2:Array) : int
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            if (param1 && param2)
            {
                for each (_loc_4 in param1)
                {
                    
                    if (_loc_4.rarity <= 0 || _loc_4.ratio == 0)
                    {
                        continue;
                    }
                    if (checkProbabilityUp(_loc_4, param2))
                    {
                        if (_loc_3 <= 0 || PlayerManager.getInstance().cmpRarityValue(_loc_4.rarity, _loc_3) < 0)
                        {
                            _loc_3 = _loc_4.rarity;
                        }
                    }
                }
            }
            return _loc_3;
        }// end function

        private static function checkProbabilityUp(param1:EmploymentProbabilityTableContent, param2:Array) : Boolean
        {
            var _loc_3:* = null;
            for each (_loc_3 in param2)
            {
                
                if (param1.rarity == _loc_3.rarity)
                {
                    return param1.ratio > _loc_3.ratio;
                }
            }
            return false;
        }// end function

    }
}
