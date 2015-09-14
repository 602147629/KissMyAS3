package popup
{

    public class CommonPopupSettingsParamCheckBox extends CommonPopupSettingsParamBase
    {
        public var bCheck:Boolean;
        public var checkText:String;

        public function CommonPopupSettingsParamCheckBox()
        {
            _type = COMMON_POPUP_SETTINGS_PARAM_TYPE_CHECK_BOX;
            this.bCheck = false;
            this.checkText = "";
            return;
        }// end function

    }
}
