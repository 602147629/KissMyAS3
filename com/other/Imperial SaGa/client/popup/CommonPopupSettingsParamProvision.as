package popup
{

    public class CommonPopupSettingsParamProvision extends CommonPopupSettingsParamBase
    {
        public var aProvision:Array;

        public function CommonPopupSettingsParamProvision()
        {
            _clip = COMMON_POPUP_SETTINGS_PARAM_CLIP_FREE_ITEM;
            _type = COMMON_POPUP_SETTINGS_PARAM_TYPE_FREE_ITEM;
            this.aProvision = [];
            return;
        }// end function

    }
}
