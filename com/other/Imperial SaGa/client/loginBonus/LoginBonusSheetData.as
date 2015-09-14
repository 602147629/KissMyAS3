package loginBonus
{
    import user.*;

    public class LoginBonusSheetData extends Object
    {
        private var _getStampCount:int;
        private var _nowStampCount:int;
        private var _aGetBonus:Array;
        private var _aSheetBonus:Array;
        private var _aNextSheetBonus:Array;
        private var _bWarehouse:Boolean;
        private var _loginBonusId:int;
        private var _loginBonusType:int;
        private var _priority:int;
        private var _swfName:String;
        private var _caption:String;
        private var _message:String;

        public function LoginBonusSheetData()
        {
            this._aGetBonus = [];
            this._aSheetBonus = [];
            this._aNextSheetBonus = [];
            this._bWarehouse = false;
            this._loginBonusType = 0;
            this._swfName = null;
            this._caption = "";
            this._message = "";
            return;
        }// end function

        public function get getStampCount() : int
        {
            return this._getStampCount;
        }// end function

        public function get nowStampCount() : int
        {
            return this._nowStampCount;
        }// end function

        public function get aGetBonus() : Array
        {
            return this._aGetBonus.concat();
        }// end function

        public function get aSheetBonus() : Array
        {
            return this._aSheetBonus.concat();
        }// end function

        public function get aNextSheetBonus() : Array
        {
            return this._aNextSheetBonus.concat();
        }// end function

        public function get bWarehouse() : Boolean
        {
            return this._bWarehouse;
        }// end function

        public function get loginBonusId() : int
        {
            return this._loginBonusId;
        }// end function

        public function get loginBonusType() : int
        {
            return this._loginBonusType;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function get swfName() : String
        {
            return this._swfName;
        }// end function

        public function get getCrown() : int
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aGetBonus)
            {
                
                if (_loc_2 != null && _loc_2.type == CommonConstant.ITEM_KIND_CROWN)
                {
                    _loc_1 = _loc_1 + _loc_2.count;
                }
            }
            for each (_loc_3 in this._aNextSheetBonus)
            {
                
                if (_loc_3 != null && _loc_3.type == CommonConstant.ITEM_KIND_CROWN)
                {
                    _loc_1 = _loc_1 + _loc_3.count;
                }
            }
            return _loc_1;
        }// end function

        public function get caption() : String
        {
            return this._caption;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function get bMiniTitleEnable() : Boolean
        {
            return this._loginBonusType != CommonConstant.LOGINBONUS_TYPE_COMEBACK;
        }// end function

        public function get bStampEnable() : Boolean
        {
            return this._loginBonusType != CommonConstant.LOGINBONUS_TYPE_COMEBACK;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._getStampCount = param1.getStampCount;
            this._nowStampCount = param1.nowStampCount;
            this._aGetBonus = [];
            for each (_loc_2 in param1.aGetBonus)
            {
                
                _loc_5 = new LoginBonusRemuneration();
                _loc_5.setReceiveData(_loc_2);
                this._aGetBonus.push(_loc_5);
            }
            this._aSheetBonus = [];
            for each (_loc_3 in param1.aSheetBonus)
            {
                
                _loc_6 = new LoginBonusRemuneration();
                _loc_6.setReceiveData(_loc_3);
                this._aSheetBonus.push(_loc_6);
            }
            this._aNextSheetBonus = [];
            for each (_loc_4 in param1.aNextSheetBonus)
            {
                
                _loc_7 = new LoginBonusRemuneration();
                _loc_7.setReceiveData(_loc_4);
                this._aNextSheetBonus.push(_loc_7);
            }
            this._bWarehouse = GetItemInfo.checkAnyWarehouse(param1.getItemInfo);
            this._loginBonusId = param1.loginBonusId;
            this._loginBonusType = param1.loginBonusType;
            this._priority = param1.priority;
            this._swfName = param1.swfName;
            this._caption = param1.caption;
            this._message = param1.message;
            return;
        }// end function

    }
}
