package popup
{

    public class CommonPopupSettingsParamEmperorSelect extends CommonPopupSettingsParamBase
    {
        public var assetId:int;

        public function CommonPopupSettingsParamEmperorSelect()
        {
            _type = COMMON_POPUP_SETTINGS_PARAM_TYPE_EMPEROR_SELECT;
            this.assetId = Constant.EMPTY_ID;
            return;
        }// end function

    }
}
