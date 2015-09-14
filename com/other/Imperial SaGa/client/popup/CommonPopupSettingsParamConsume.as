package popup
{

    public class CommonPopupSettingsParamConsume extends CommonPopupSettingsParamBase
    {
        public var assetId:int;

        public function CommonPopupSettingsParamConsume()
        {
            _type = COMMON_POPUP_SETTINGS_PARAM_TYPE_CONSUME;
            this.assetId = Constant.EMPTY_ID;
            return;
        }// end function

    }
}
