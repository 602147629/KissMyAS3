package employment
{

    public class EmploymentSpecialData extends Object
    {
        private var _price:int;

        public function EmploymentSpecialData(param1:int)
        {
            this._price = param1;
            return;
        }// end function

        public function get price() : uint
        {
            return this._price;
        }// end function

    }
}
