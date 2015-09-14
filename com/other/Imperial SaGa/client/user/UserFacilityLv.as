package user
{

    public class UserFacilityLv extends Object
    {

        public function UserFacilityLv()
        {
            return;
        }// end function

        public static function getFacilityLv(param1:int) : int
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = 0;
                    break;
                }
                case 1:
                {
                    _loc_2 = 1;
                    break;
                }
                case 2:
                {
                    _loc_2 = 2;
                    break;
                }
                case 3:
                {
                    _loc_2 = 3;
                    break;
                }
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                {
                    _loc_2 = 4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
