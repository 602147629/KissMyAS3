package popup
{

    public class CommonPopupSettingsParamBase extends Object
    {
        protected var _clip:String;
        protected var _type:int;
        public static const COMMON_POPUP_SETTINGS_PARAM_CLIP_INFO:String = "InfoPopup";
        public static const COMMON_POPUP_SETTINGS_PARAM_CLIP_LARGE:String = "LargeInfoPopup";
        public static const COMMON_POPUP_SETTINGS_PARAM_CLIP_FREE_ITEM:String = "FreeItemPop";
        public static const COMMON_POPUP_SETTINGS_PARAM_CLIP_COOPERATE_CODE:String = "CampaignPop";
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_NORMAL:int = 0;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_REEL:int = 1;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_ITEM:int = 2;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_RETREAT:int = 3;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_CONSUME:int = 4;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_CHECK_BOX:int = 5;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_EMPEROR_SELECT:int = 6;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_TEXT_RED:int = 7;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_LARGE:int = 10;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_FREE_ITEM:int = 20;
        public static const COMMON_POPUP_SETTINGS_PARAM_TYPE_COOPERATE_CODE:int = 30;

        public function CommonPopupSettingsParamBase()
        {
            this._clip = COMMON_POPUP_SETTINGS_PARAM_CLIP_INFO;
            this._type = COMMON_POPUP_SETTINGS_PARAM_TYPE_NORMAL;
            return;
        }// end function

        public function get clip() : String
        {
            return this._clip;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

    }
}
