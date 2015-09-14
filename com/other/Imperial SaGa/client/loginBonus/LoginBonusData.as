package loginBonus
{

    public class LoginBonusData extends Object
    {
        private var _aLoginBonus:Array;

        public function LoginBonusData()
        {
            this._aLoginBonus = [];
            return;
        }// end function

        public function get aLoginBonus() : Array
        {
            return this._aLoginBonus;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aLoginBonus = [];
            for each (_loc_2 in param1.aLoginBonus)
            {
                
                _loc_3 = new LoginBonusSheetData();
                _loc_3.setReceiveData(_loc_2);
                this._aLoginBonus.push(_loc_3);
            }
            return;
        }// end function

    }
}
