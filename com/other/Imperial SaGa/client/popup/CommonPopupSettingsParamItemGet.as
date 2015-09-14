package popup
{

    public class CommonPopupSettingsParamItemGet extends CommonPopupSettingsParamBase
    {
        public var itemCategory:int;
        public var itemId:int;
        public var itemName:String;
        public var itemNum:int;

        public function CommonPopupSettingsParamItemGet()
        {
            _type = COMMON_POPUP_SETTINGS_PARAM_TYPE_ITEM;
            this.itemCategory = CommonConstant.ITEM_KIND_ACCESSORIES;
            this.itemId = Constant.EMPTY_ID;
            this.itemName = "";
            this.itemNum = 1;
            return;
        }// end function

    }
}
