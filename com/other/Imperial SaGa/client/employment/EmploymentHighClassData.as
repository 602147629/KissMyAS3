package employment
{

    public class EmploymentHighClassData extends Object
    {
        private var _price:int;
        private var _boxPrice:int;
        private var _bBoxFirstBonus:Boolean;

        public function EmploymentHighClassData(param1:int)
        {
            this._price = param1;
            this._boxPrice = this._price * 10;
            this._bBoxFirstBonus = false;
            return;
        }// end function

        public function get price() : uint
        {
            return this._price;
        }// end function

        public function get boxPrice() : int
        {
            return this._boxPrice;
        }// end function

        public function get bBoxFirstBonus() : Boolean
        {
            return this._bBoxFirstBonus;
        }// end function

        public function set bBoxFirstBonus(param1:Boolean) : void
        {
            this._bBoxFirstBonus = param1;
            return;
        }// end function

    }
}
