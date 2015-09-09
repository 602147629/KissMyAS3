package com.bit101.components
{

    public class TextLink extends Component
    {

        public function TextLink()
        {
            return;
        }// end function

        public static function link(param1, param2, param3 = 39423)
        {
            var _loc_4:* = String(param3.toString(16));
            while (_loc_4.length < 6)
            {
                
                _loc_4 = "0" + _loc_4;
            }
            _loc_4 = "#" + _loc_4;
            return "<u><font color=\'" + _loc_4 + "\'><a href=\'event:" + param2 + "\'>" + param1 + "</a></font></u>";
        }// end function

    }
}
