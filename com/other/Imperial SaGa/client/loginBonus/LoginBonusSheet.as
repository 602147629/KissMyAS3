package loginBonus
{
    import flash.display.*;
    import resource.*;
    import utility.*;

    public class LoginBonusSheet extends Object
    {
        private const _LABEL_SQUARE_GRADE_PREFIX:String = "grade";
        private const _LABEL_SQUARE_GRADE1:String;
        private const _LABEL_SQUARE_GRADE2:String;
        private const _LABEL_SQUARE_GRADE3:String;
        private const _LABEL_SQUARE_GRADE4:String;
        private const _LABEL_SQUARE_CLEAR_PREFIX:String = "clear";
        private var _aMcSquare:Array;
        private var _loginBonusPushStamp:LoginBonusPushStamp;
        private var _aPushStamp:Array;
        private var _aSheetBonus:Array;

        public function LoginBonusSheet(param1:MovieClip, param2:Array, param3:int, param4:String)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            this._LABEL_SQUARE_GRADE1 = this._LABEL_SQUARE_GRADE_PREFIX + "1";
            this._LABEL_SQUARE_GRADE2 = this._LABEL_SQUARE_GRADE_PREFIX + "2";
            this._LABEL_SQUARE_GRADE3 = this._LABEL_SQUARE_GRADE_PREFIX + "3";
            this._LABEL_SQUARE_GRADE4 = this._LABEL_SQUARE_GRADE_PREFIX + "4";
            this._aPushStamp = [];
            this._aSheetBonus = param2.concat();
            this._loginBonusPushStamp = null;
            this._aMcSquare = [];
            var _loc_5:* = 0;
            var _loc_10:* = [];
            _loc_8 = 0;
            while (_loc_8 < param1.numChildren)
            {
                
                _loc_7 = param1.getChildAt(_loc_8) as MovieClip;
                if (_loc_7 != null)
                {
                    if (isLoginBonusGrid(_loc_7))
                    {
                        _loc_14 = getLoginBonusGridInfo(_loc_7);
                        _loc_10.push({idx:_loc_14[1], mc:_loc_7});
                    }
                }
                _loc_8++;
            }
            if (_loc_10.length != param2.length)
            {
                Assert.print("ログインボーナスの報酬数とログインボーナスのグラフィックがあっていません");
            }
            _loc_10.sortOn("idx", Array.NUMERIC);
            _loc_8 = 0;
            while (_loc_8 < _loc_10.length)
            {
                
                _loc_7 = _loc_10[_loc_8].mc;
                if (_loc_7 != null)
                {
                    _loc_6 = ResourceManager.getInstance().createMovieClip(getLoginBonusGridPath(_loc_7), "GridMc");
                    _loc_7.addChild(_loc_6);
                    this._aMcSquare.push(_loc_6);
                }
                _loc_8++;
            }
            _loc_5 = 0;
            while (_loc_5 < param3)
            {
                
                _loc_12 = param2[_loc_5];
                _loc_13 = this._LABEL_SQUARE_CLEAR_PREFIX + _loc_12.grade;
                _loc_11 = this._aMcSquare[_loc_5];
                _loc_11.gotoAndStop(_loc_13);
                _loc_5++;
            }
            while (_loc_5 < _loc_10.length)
            {
                
                _loc_12 = param2[_loc_5];
                _loc_13 = this._LABEL_SQUARE_GRADE_PREFIX + _loc_12.grade;
                _loc_11 = this._aMcSquare[_loc_5];
                _loc_11.gotoAndStop(_loc_13);
                _loc_5++;
            }
            return;
        }// end function

        public function get aSheetBonus() : Array
        {
            return this._aSheetBonus;
        }// end function

        public function isStampAnimation() : Boolean
        {
            return this._loginBonusPushStamp != null;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aMcSquare)
            {
                
                if (_loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            this._aMcSquare = [];
            this._aSheetBonus = [];
            for each (_loc_2 in this._aPushStamp)
            {
                
                _loc_2.release();
            }
            this._aPushStamp = [];
            return;
        }// end function

        public function setMark(param1:int, param2:MovieClip) : void
        {
            var _loc_3:* = this._aMcSquare[param1];
            _loc_3.addChild(param2);
            return;
        }// end function

        public function setPushStamp(param1:int, param2:DisplayObject) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = this._aMcSquare[param1];
            switch(_loc_4.currentLabel)
            {
                case this._LABEL_SQUARE_GRADE1:
                {
                    _loc_3 = _loc_4.anmGrade1Mc;
                    break;
                }
                case this._LABEL_SQUARE_GRADE2:
                {
                    _loc_3 = _loc_4.anmGrade2Mc;
                    break;
                }
                case this._LABEL_SQUARE_GRADE3:
                {
                    _loc_3 = _loc_4.anmGrade3Mc;
                    break;
                }
                case this._LABEL_SQUARE_GRADE4:
                {
                    _loc_3 = _loc_4.anmGrade4Mc;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_3 != null)
            {
                this._loginBonusPushStamp = new LoginBonusPushStamp(_loc_3, param2);
                this._aPushStamp.push(this._loginBonusPushStamp);
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPushStamp)
            {
                
                _loc_2.control(param1);
            }
            if (this._loginBonusPushStamp != null)
            {
                if (this._loginBonusPushStamp.bEnd)
                {
                    this._loginBonusPushStamp = null;
                }
            }
            return;
        }// end function

        public static function getLoginBonusGridPath(param1:MovieClip) : String
        {
            var _loc_2:* = getLoginBonusGridInfo(param1);
            if (_loc_2)
            {
                return ResourcePath.LOGIN_SHEET_GRID_PATH + _loc_2[0] + ".swf";
            }
            return null;
        }// end function

        private static function getLoginBonusGridInfo(param1:MovieClip) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1)
            {
                _loc_2 = param1.name;
                _loc_3 = _loc_2.indexOf("_");
                if (_loc_3 != -1)
                {
                    _loc_4 = _loc_2.substr(0, _loc_3);
                    _loc_5 = _loc_2.substr((_loc_3 + 1));
                    return [_loc_4, _loc_5];
                }
            }
            return null;
        }// end function

        public static function isLoginBonusGrid(param1:MovieClip) : Boolean
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = param1.name.indexOf("_");
                if (_loc_2 != -1)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
