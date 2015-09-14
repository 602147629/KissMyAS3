package script
{
    import asset.*;
    import item.*;
    import message.*;
    import network.*;
    import notice.*;
    import player.*;
    import popup.*;
    import quest.*;

    public class ScriptComPaymentEventEnd extends ScriptComBase
    {
        private var _bPopup:Boolean;

        public function ScriptComPaymentEventEnd()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            NetManager.getInstance().request(new NetTaskQuestPaymentEventEnd(this.cbConnect));
            return;
        }// end function

        override public function commandSkip() : int
        {
            return ScriptComConstant.COMMAND_SKIP_RESULT_DONT;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return false;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            return;
        }// end function

        public function cbConnect(param1:NetResult) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            NoticeManager.getInstance().crearSimpleNoticeById(QuestManager.getInstance().paymentEventNoticeId);
            var _loc_2:* = QuestManager.getInstance().aPaymentEventItem;
            if (_loc_2.length > 1)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.NOTICE_PAYMENT_EVENT_MESSAGE_03), this.cbPopupClose);
            }
            else
            {
                _loc_3 = _loc_2[0] as QuestRemunerationData;
                if (_loc_3 == null)
                {
                    _bCommandEnd = true;
                    return;
                }
                if (_loc_3.categoryId == CommonConstant.ITEM_KIND_CROWN)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.NOTICE_PAYMENT_EVENT_MESSAGE_05, _loc_3.num), this.cbPopupClose);
                }
                else if (_loc_3.categoryId == CommonConstant.ITEM_KIND_WARRIOR)
                {
                    _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.itemId);
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.NOTICE_PAYMENT_EVENT_MESSAGE_04, _loc_4.name), this.cbPopupClose);
                }
                else if (_loc_3.categoryId == CommonConstant.ITEM_KIND_ASSET && _loc_3.itemId == AssetId.ASSET_GACHA_POINT)
                {
                    _loc_5 = ItemManager.getInstance().getItemName(_loc_3.categoryId, _loc_3.itemId);
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.NOTICE_PAYMENT_EVENT_MESSAGE_02_GACHA_POINT, _loc_5, _loc_3.num), this.cbPopupClose);
                }
                else
                {
                    _loc_5 = "";
                    if (_loc_3.categoryId == CommonConstant.ITEM_KIND_ACCESSORIES)
                    {
                        _loc_6 = ItemManager.getInstance().getItemInformation(_loc_3.itemId);
                        if (_loc_6)
                        {
                            _loc_5 = _loc_6.name;
                        }
                    }
                    else if (_loc_3.categoryId == CommonConstant.ITEM_KIND_PAYMENT_ITEM)
                    {
                        _loc_7 = ItemManager.getInstance().getPaymentItemInformation(_loc_3.itemId);
                        if (_loc_7)
                        {
                            _loc_5 = _loc_7.name;
                        }
                    }
                    else if (_loc_3.categoryId == CommonConstant.ITEM_KIND_DESTINY_STONE)
                    {
                        _loc_5 = ItemManager.getInstance().getItemName(_loc_3.categoryId, _loc_3.itemId);
                    }
                    else if (_loc_3.categoryId == CommonConstant.ITEM_KIND_ASSET)
                    {
                        _loc_5 = ItemManager.getInstance().getItemName(_loc_3.categoryId, _loc_3.itemId);
                    }
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.NOTICE_PAYMENT_EVENT_MESSAGE_02, _loc_5, _loc_3.num), this.cbPopupClose);
                }
            }
            this._bPopup = true;
            return;
        }// end function

        public function cbPopupClose() : void
        {
            if (QuestManager.getInstance().bWarehousePaymentEventItem)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_SEND_STRAGE), function () : void
            {
                _bCommandEnd = true;
                _bPopup = false;
                return;
            }// end function
            );
                return;
            }
            _bCommandEnd = true;
            this._bPopup = false;
            return;
        }// end function

    }
}
