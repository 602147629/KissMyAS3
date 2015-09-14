package employment
{

    public class EmploymentFeaturedPlayerData extends Object
    {
        private var _employmentType:int;
        private var _featuredType:int;
        private var _playerId:int;
        public static const FEATURED_TYPE_FEATURED:int = 0;
        public static const FEATURED_TYPE_NEW_COMER:int = 1;
        public static const FEATURED_TYPE_MORE_SR:int = 2;

        public function EmploymentFeaturedPlayerData(param1:int, param2:int, param3:int)
        {
            this._employmentType = param1;
            this._featuredType = param2;
            this._playerId = param3;
            return;
        }// end function

        public function get employmentType() : int
        {
            return this._employmentType;
        }// end function

        public function get featuredType() : int
        {
            return this._featuredType;
        }// end function

        public function get playerId() : int
        {
            return this._playerId;
        }// end function

    }
}
