package popup
{

    public class CommonPopupSettingsParamReel extends CommonPopupSettingsParamBase
    {
        public var reelNumDefault:int;
        public var reelNumMax:int;

        public function CommonPopupSettingsParamReel()
        {
            _type = COMMON_POPUP_SETTINGS_PARAM_TYPE_REEL;
            this.reelNumDefault = 1;
            this.reelNumMax = 99;
            return;
        }// end function

    }
}
