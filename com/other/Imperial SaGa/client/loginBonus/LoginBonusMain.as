package loginBonus
{
    import flash.display.*;
    import item.*;
    import resource.*;
    import sound.*;

    public class LoginBonusMain extends Object
    {
        private const _PHASE_INIT:int = 1;
        private const _PHASE_SHEET_DISP:int = 10000;
        private const _PHASE_NEXT_BONUS:int = 21000;
        private const _PHASE_END:int = 91000;
        private var _bonusData:LoginBonusData;
        private var _selectIdx:int;
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _sheetMain:LoginBonusSheetDisp;
        private var _bEnd:Boolean;
        private static const _RESOURCE_PATH:String = ResourcePath.LOGIN_PATH + "UI_LoginBonus.swf";

        public function LoginBonusMain(param1:DisplayObjectContainer, param2:LoginBonusData)
        {
            this._bonusData = param2;
            this._mcBase = ResourceManager.getInstance().createMovieClip(_RESOURCE_PATH, "logboMainMc");
            param1.addChild(this._mcBase);
            this.setPhase(this._PHASE_INIT);
            return;
        }// end function

        private function get _bonusSheetData() : LoginBonusSheetData
        {
            if (this._selectIdx >= 0 && this._selectIdx < this._bonusData.aLoginBonus.length)
            {
                return this._bonusData.aLoginBonus[this._selectIdx];
            }
            return null;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._sheetMain)
            {
                this._sheetMain.release();
            }
            this._sheetMain = null;
            if (this._mcBase)
            {
                if (this._mcBase.parent)
                {
                    this._mcBase.parent.removeChild(this._mcBase);
                }
            }
            this._mcBase = null;
            this._bonusData = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_INIT:
                {
                    this.controlInit(param1);
                    break;
                }
                case this._PHASE_SHEET_DISP:
                {
                    this.controlSheetDisp(param1);
                    break;
                }
                case this._PHASE_NEXT_BONUS:
                {
                    this.controlNextBonus(param1);
                    break;
                }
                case this._PHASE_END:
                {
                    this.controlEnd(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_INIT:
                {
                    this.phaseInit();
                    break;
                }
                case this._PHASE_SHEET_DISP:
                {
                    this.phaseSheetDisp();
                    break;
                }
                case this._PHASE_NEXT_BONUS:
                {
                    this.phaseNextBonus();
                    break;
                }
                case this._PHASE_END:
                {
                    this.phaseEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseInit() : void
        {
            this._bonusData.aLoginBonus.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
            this.setPhase(this._PHASE_SHEET_DISP);
            return;
        }// end function

        private function controlInit(param1:Number) : void
        {
            return;
        }// end function

        private function phaseSheetDisp() : void
        {
            this._sheetMain = new LoginBonusSheetDisp(this._bonusSheetData, this._mcBase, _RESOURCE_PATH, getLoginBonusSheetPath(this._bonusSheetData));
            return;
        }// end function

        private function controlSheetDisp(param1:Number) : void
        {
            if (this._sheetMain != null)
            {
                this._sheetMain.control(param1);
                if (this._sheetMain.bEnd)
                {
                    this._sheetMain.release();
                    this._sheetMain = null;
                    this.setPhase(this._PHASE_NEXT_BONUS);
                }
            }
            return;
        }// end function

        private function phaseNextBonus() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._selectIdx + 1;
            _loc_1._selectIdx = _loc_2;
            if (this._bonusSheetData != null)
            {
                this.setPhase(this._PHASE_SHEET_DISP);
            }
            else
            {
                this.setPhase(this._PHASE_END);
            }
            return;
        }// end function

        private function controlNextBonus(param1:Number) : void
        {
            return;
        }// end function

        private function phaseEnd() : void
        {
            return;
        }// end function

        private function controlEnd(param1:Number) : void
        {
            this._bEnd = true;
            return;
        }// end function

        public static function getResource() : Array
        {
            return [_RESOURCE_PATH];
        }// end function

        public static function getSound() : Array
        {
            return [SoundId.SE_RS3_EVENT_BATTLE_ITEM_GET];
        }// end function

        public static function getBonusResource(param1:LoginBonusData) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1.aLoginBonus)
            {
                
                _loc_2.push(getLoginBonusSheetPath(_loc_3));
                for each (_loc_4 in _loc_3.aGetBonus)
                {
                    
                    _loc_2.push(ItemManager.getInstance().getItemPng(_loc_4.type, _loc_4.id));
                }
            }
            return _loc_2;
        }// end function

        private static function getLoginBonusSheetPath(param1:LoginBonusSheetData) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.swfName;
            if (_loc_2 == null || _loc_2 == "")
            {
                _loc_3 = String("000000" + param1.loginBonusType).slice(-6);
                _loc_2 = "BonusSheet_" + _loc_3 + ".swf";
            }
            return ResourcePath.LOGIN_SHEET_PATH + _loc_2;
        }// end function

        public static function getLoginBonusGridPath(param1:LoginBonusData) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = [];
            for each (_loc_4 in param1.aLoginBonus)
            {
                
                _loc_3 = ResourceManager.getInstance().createMovieClip(getLoginBonusSheetPath(_loc_4), "logBoMap");
                _loc_6 = 0;
                while (_loc_6 < _loc_3.numChildren)
                {
                    
                    _loc_5 = _loc_3.getChildAt(_loc_6) as MovieClip;
                    if (_loc_5)
                    {
                        if (LoginBonusSheet.isLoginBonusGrid(_loc_5))
                        {
                            _loc_2.push(LoginBonusSheet.getLoginBonusGridPath(_loc_5));
                        }
                    }
                    _loc_6++;
                }
            }
            return _loc_2;
        }// end function

    }
}
