package employment
{

    public class EmploymentProbabilityTableContent extends Object
    {
        private var _rarity:int;
        private var _ratio:int;

        public function EmploymentProbabilityTableContent(param1:int, param2:int)
        {
            this._rarity = param1;
            this._ratio = param2;
            return;
        }// end function

        public function get rarity() : int
        {
            return this._rarity;
        }// end function

        public function get ratio() : int
        {
            return this._ratio;
        }// end function

    }
}
