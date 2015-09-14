package script
{
    import player.*;
    import user.*;

    public class ScriptChangeKeyword extends Object
    {

        public function ScriptChangeKeyword()
        {
            return;
        }// end function

        public static function changeKeyword(param1:String, param2:String) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            switch(param1)
            {
                case ScriptConstant.SCRIPT_COMMAND_NOW_EMPEROR:
                {
                    if (param2.indexOf(param1) >= 0)
                    {
                        _loc_3 = UserDataManager.getInstance().userData.emperorId;
                        _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3);
                        param2 = param2.replace(param1, _loc_4.name);
                    }
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return param2;
        }// end function

        public static function nowEmperorEventFileName() : String
        {
            var _loc_1:* = UserDataManager.getInstance().userData.emperorId;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(_loc_1);
            return _loc_2.cardFileName;
        }// end function

    }
}
