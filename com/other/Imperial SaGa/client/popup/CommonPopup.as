package popup
{
    import asset.*;
    import button.*;
    import flash.display.*;
    import input.*;
    import item.*;
    import material.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import utility.*;

    public class CommonPopup extends Object
    {
        private var _bUse:Boolean;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _fade:Fade;
        private var _btnLeft:ButtonBase;
        private var _btnCenter:ButtonBase;
        private var _btnRight:ButtonBase;
        private var _cbPopupClose:Function;
        private var _bBtnReverse:Boolean;
        private var _cooperate:CommonPopupCooperateCode;
        private var _provision:CommonPopupProvision;
        private var _reel:CommonPopupReel;
        private var _btnCheck:ButtonBase;
        public static const POPUP_TYPE_NORMAL:int = 0;
        public static const POPUP_TYPE_NAVI:int = 1;
        public static const POPUP_TYPE_NAVI_SEKISHUSAI:int = 2;
        public static const POPUP_TYPE_NAVI_EMERALD:int = 3;
        public static const POPUP_TYPE_NAVI_NORA:int = 4;
        public static const POPUP_TYPE_NAVI_FULBRIGHT:int = 5;
        private static var _instance:CommonPopup = null;

        public function CommonPopup()
        {
            this._mcBase = null;
            this._fade = null;
            this._btnLeft = null;
            this._btnCenter = null;
            this._btnRight = null;
            this._cbPopupClose = null;
            this._isoMain = null;
            this._bUse = false;
            this._cooperate = null;
            this._provision = null;
            this._reel = null;
            this._btnCheck = null;
            return;
        }// end function

        public function get bUse() : Boolean
        {
            return this._bUse;
        }// end function

        private function release() : void
        {
            if (this._btnCheck)
            {
                ButtonManager.getInstance().removeButton(this._btnCheck);
            }
            this._btnCheck = null;
            if (this._reel)
            {
                this._reel.release();
            }
            this._reel = null;
            if (this._provision)
            {
                this._provision.release();
            }
            this._provision = null;
            if (this._cooperate)
            {
                this._cooperate.release();
            }
            this._cooperate = null;
            ButtonManager.getInstance().removeButton(this._btnLeft);
            ButtonManager.getInstance().removeButton(this._btnCenter);
            ButtonManager.getInstance().removeButton(this._btnRight);
            this._btnLeft = null;
            this._btnCenter = null;
            this._btnRight = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            this._bUse = false;
            ButtonManager.getInstance().unseal();
            InputManager.getInstance().setDisable(false);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        public function loadResource(param1:Array = null) : void
        {
            var _loc_2:* = 0;
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf");
            if (param1 == null)
            {
                param1 = [POPUP_TYPE_NAVI];
            }
            for each (_loc_2 in param1)
            {
                
                switch(_loc_2)
                {
                    case POPUP_TYPE_NAVI:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.NAVI_CHARACTER_PATH);
                        break;
                    }
                    case POPUP_TYPE_NAVI_SEKISHUSAI:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_sekishusai.png");
                        break;
                    }
                    case POPUP_TYPE_NAVI_EMERALD:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_emerald.png");
                        break;
                    }
                    case POPUP_TYPE_NAVI_NORA:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_nora.png");
                        break;
                    }
                    case POPUP_TYPE_NAVI_FULBRIGHT:
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_fulbright.png");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            SoundManager.getInstance().loadSoundArray([SoundId.SE_POPUP]);
            return;
        }// end function

        public function openYesNoPopup(param1:int, param2:String, param3:Function, param4:String = null, param5:String = null, param6:Boolean = false, param7:DisplayObjectContainer = null) : void
        {
            if (param4 == null)
            {
                param4 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_YES);
            }
            if (param5 == null)
            {
                param5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_NO);
            }
            this.openPopup(param7, param1, [param2], param3, param4, param5, param6, false);
            return;
        }// end function

        public function openAlertPopup(param1:int, param2:String, param3:Function, param4:String = null, param5:Boolean = false, param6:DisplayObjectContainer = null) : void
        {
            if (param4 == null)
            {
                param4 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            this.openPopup(param6, param1, [param2], param3, param4, null, param5, false);
            return;
        }// end function

        public function openEmperorReturnAlertPopup(param1:int, param2:String, param3:Function, param4:String = null) : void
        {
            var _loc_5:* = new CommonPopupSettingsParamTextRed();
            if (param4 == null)
            {
                param4 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            this.openPopup(null, param1, [param2], param3, param4, null, false, false, _loc_5);
            return;
        }// end function

        public function openNoticePopup(param1:int, param2:String, param3:String, param4:Function, param5:String = null, param6:Boolean = false) : void
        {
            var _loc_7:* = new CommonPopupSettingsParamLarge();
            if (param5 == null)
            {
                param5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            this.openPopup(null, param1, [param2, param3], param4, param5, null, param6, false, _loc_7, false);
            return;
        }// end function

        public function openReelPopup(param1:String, param2:Function, param3:int = 1, param4:int = 99, param5:DisplayObjectContainer = null) : void
        {
            var _loc_6:* = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_DECIDE);
            var _loc_7:* = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_QUIT);
            var _loc_8:* = new CommonPopupSettingsParamReel();
            new CommonPopupSettingsParamReel().reelNumDefault = param3;
            _loc_8.reelNumMax = param4;
            this.openPopup(param5, POPUP_TYPE_NORMAL, [param1], param2, _loc_6, _loc_7, false, false, _loc_8);
            return;
        }// end function

        public function openItemPopup(param1:String, param2:int, param3:int, param4:String, param5:int, param6:String, param7:String, param8:Function) : void
        {
            var _loc_9:* = new CommonPopupSettingsParamItemGet();
            new CommonPopupSettingsParamItemGet().itemCategory = param2;
            _loc_9.itemId = param3;
            _loc_9.itemName = param4;
            _loc_9.itemNum = param5;
            if (param6 == null)
            {
                param6 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_OK);
            }
            this.openPopup(null, POPUP_TYPE_NORMAL, [param1], param8, param6, param7, false, false, _loc_9);
            return;
        }// end function

        public function openProvisionPopup(param1:int, param2:String, param3:Array, param4:Function, param5:String = null) : void
        {
            var _loc_6:* = new CommonPopupSettingsParamProvision();
            new CommonPopupSettingsParamProvision().aProvision = param3;
            if (param5 == null)
            {
                param5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            this.openPopup(null, param1, [param2], param4, param5, null, false, false, _loc_6);
            return;
        }// end function

        public function openCooperateCodePopup(param1:int, param2:String, param3:Array, param4:Function, param5:String = null) : void
        {
            var _loc_6:* = new CommonPopupSettingsParamCooperateCode();
            new CommonPopupSettingsParamCooperateCode().aCodeInfo = param3;
            if (param5 == null)
            {
                param5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            this.openPopup(null, param1, [param2], param4, param5, null, false, false, _loc_6);
            return;
        }// end function

        public function openRetreatPopup(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Function) : void
        {
            var _loc_7:* = new CommonPopupSettingsParamRetreat();
            this.openPopup(null, param1, [param2, param3], param6, param4, param5, false, false, _loc_7);
            return;
        }// end function

        public function openPaymentPopup(param1:int, param2:String, param3:Function, param4:String = null, param5:String = null, param6:DisplayObjectContainer = null) : void
        {
            if (param4 == null)
            {
                param4 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_YES);
            }
            if (param5 == null)
            {
                param5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_NO);
            }
            this.openPopup(param6, param1, [param2], param3, param4, param5, false, true);
            return;
        }// end function

        public function openConsumePopup(param1:int, param2:int, param3:String, param4:Function, param5:String = null, param6:String = null) : void
        {
            if (param5 == null)
            {
                param5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_YES);
            }
            if (param6 == null)
            {
                param6 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_NO);
            }
            var _loc_7:* = new CommonPopupSettingsParamConsume();
            new CommonPopupSettingsParamConsume().assetId = param2;
            this.openPopup(null, param1, [param3], param4, param5, param6, false, false, _loc_7);
            return;
        }// end function

        public function openCheckBoxPopup(param1:int, param2:String, param3:Boolean, param4:String, param5:Function, param6:String = null) : void
        {
            var _loc_7:* = new CommonPopupSettingsParamCheckBox();
            new CommonPopupSettingsParamCheckBox().bCheck = param3;
            _loc_7.checkText = param4;
            if (param6 == null)
            {
                param6 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            this.openPopup(null, param1, [param2], param5, param6, null, false, false, _loc_7);
            return;
        }// end function

        public function openEmperorSelectnAlertPopup(param1:int, param2:String, param3:String, param4:Function, param5:String = null, param6:Boolean = false) : void
        {
            var _loc_7:* = new CommonPopupSettingsParamEmperorSelect();
            if (param5 == null)
            {
                param5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            this.openPopup(null, param1, [param2, param3], param4, param5, null, param6, false, _loc_7);
            return;
        }// end function

        public function openTutorialPopup(param1:int, param2:Array, param3:Array, param4:Function) : void
        {
            var popupType:* = param1;
            var aMsgId:* = param2;
            var aBtnMsgId:* = param3;
            var cbPopupClose:* = param4;
            var popupFunc:* = function (param1:int = 0) : void
            {
                var count:* = param1;
                count = (count + 1);
                openPopup(null, popupType, [MessageManager.getInstance().getMessage(aMsgId[(count - 1)])], count < aMsgId.length ? (function () : void
                {
                    popupFunc(count);
                    return;
                }// end function
                ) : (cbPopupClose), MessageManager.getInstance().getMessage(aBtnMsgId[(count - 1)]));
                return;
            }// end function
            ;
            this.popupFunc();
            return;
        }// end function

        public function openTutorialPopup_StringArray(param1:int, param2:Array, param3:Array, param4:Function) : void
        {
            var popupType:* = param1;
            var aMsg:* = param2;
            var aBtnMsgId:* = param3;
            var cbPopupClose:* = param4;
            var popupFunc:* = function (param1:int = 0) : void
            {
                var count:* = param1;
                count = (count + 1);
                openPopup(null, popupType, [aMsg[(count - 1)]], count < aMsg.length ? (function () : void
                {
                    popupFunc(count);
                    return;
                }// end function
                ) : (cbPopupClose), MessageManager.getInstance().getMessage(aBtnMsgId[(count - 1)]));
                return;
            }// end function
            ;
            this.popupFunc();
            return;
        }// end function

        private function openPopup(param1:DisplayObjectContainer, param2:int, param3:Array, param4:Function, param5:String, param6:String = null, param7:Boolean = false, param8:Boolean = false, param9:CommonPopupSettingsParamBase = null, param10:Boolean = true) : void
        {
            var mc:MovieClip;
            var mcBtnYes:MovieClip;
            var positiveBtnSymbol:String;
            var negativeBtnSymbol:String;
            var mcBtnCenter:MovieClip;
            var mcBtnLeft:MovieClip;
            var mcBtnRight:MovieClip;
            var reelSettings:CommonPopupSettingsParamReel;
            var itemSettings:CommonPopupSettingsParamItemGet;
            var fileName:String;
            var bitmap:Bitmap;
            var mcNull:MovieClip;
            var consumeSettings:CommonPopupSettingsParamConsume;
            var checkBoxSettings:CommonPopupSettingsParamCheckBox;
            var provisionSettings:CommonPopupSettingsParamProvision;
            var cooperateCodeSettings:CommonPopupSettingsParamCooperateCode;
            var itemInfo:ItemInformation;
            var mtrlInfo:MaterialInformation;
            var paymentItemInfo:PaymentItemInformation;
            var playerInfo:PlayerInformation;
            var assetInfo:AssetInformation;
            var naviCharaBmp:Bitmap;
            var layer:* = param1;
            var popupType:* = param2;
            var aMsg:* = param3;
            var cbPopupClose:* = param4;
            var positiveBtnText:* = param5;
            var negativeBtnText:* = param6;
            var btnReverse:* = param7;
            var bPaymentBtn:* = param8;
            var settings:* = param9;
            var bFade:* = param10;
            if (this._bUse)
            {
                this.release();
                this._cbPopupClose = null;
            }
            if (layer == null)
            {
                layer = Main.GetProcess();
            }
            if (settings == null)
            {
                settings = new CommonPopupSettingsParamBase();
            }
            this._bBtnReverse = btnReverse;
            if (bFade)
            {
                this._fade = new Fade(layer);
                this._fade.maxAlpha = 0.5;
                this._fade.setFadeOut(0.5);
            }
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf", settings.clip);
            layer.addChild(this._mcBase);
            var i:int;
            while (i < this._mcBase.numChildren)
            {
                
                mc = this._mcBase.getChildAt(i) as MovieClip;
                if (mc)
                {
                    mc.mouseEnabled = false;
                    mc.mouseChildren = false;
                }
                i = (i + 1);
            }
            var cbFunc:* = this.cbBtn;
            if (settings.type == CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_FREE_ITEM)
            {
                cbFunc = this.cbBtn_FreeItem;
            }
            if (settings.type == CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_COOPERATE_CODE)
            {
                cbFunc = this.cbBtn_CooperateCode;
            }
            var aBtn:Array;
            if (this._mcBase.YesBtnMc)
            {
                mcBtnYes = this._mcBase.YesBtnMc;
                this._btnCenter = ButtonManager.getInstance().addButton(mcBtnYes, cbFunc, 1);
                this._btnCenter.enterSeId = this._bBtnReverse ? (ButtonBase.SE_CANCEL_ID) : (ButtonBase.SE_DECIDE_ID);
                TextControl.setText(mcBtnYes.textMc.textDt, positiveBtnText);
                aBtn.push(this._btnCenter);
            }
            else
            {
                positiveBtnSymbol = bPaymentBtn ? ("Btn3Mc") : ("Btn2Mc");
                negativeBtnSymbol;
                if (negativeBtnText == null)
                {
                    mcBtnCenter = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf", this._bBtnReverse ? (negativeBtnSymbol) : (positiveBtnSymbol));
                    (this._mcBase.btnLayout1Mc as MovieClip).addChild(mcBtnCenter);
                    this._btnCenter = ButtonManager.getInstance().addButton(mcBtnCenter, cbFunc, 1);
                    this._btnCenter.enterSeId = this._bBtnReverse ? (ButtonBase.SE_CANCEL_ID) : (ButtonBase.SE_DECIDE_ID);
                    TextControl.setText(mcBtnCenter.textMc.textDt, positiveBtnText);
                    aBtn.push(this._btnCenter);
                }
                else
                {
                    mcBtnLeft = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf", !this._bBtnReverse ? (positiveBtnSymbol) : (negativeBtnSymbol));
                    (this._mcBase.btnLayout2Mc as MovieClip).addChild(mcBtnLeft);
                    this._btnLeft = ButtonManager.getInstance().addButton(mcBtnLeft, cbFunc, !this._bBtnReverse ? (0) : (2));
                    TextControl.setText(mcBtnLeft.textMc.textDt, !this._bBtnReverse ? (positiveBtnText) : (negativeBtnText));
                    this._btnLeft.enterSeId = this._bBtnReverse ? (ButtonBase.SE_CANCEL_ID) : (ButtonBase.SE_DECIDE_ID);
                    aBtn.push(this._btnLeft);
                    mcBtnRight = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf", this._bBtnReverse ? (positiveBtnSymbol) : (negativeBtnSymbol));
                    (this._mcBase.btnLayout3Mc as MovieClip).addChild(mcBtnRight);
                    this._btnRight = ButtonManager.getInstance().addButton(mcBtnRight, cbFunc, this._bBtnReverse ? (0) : (2));
                    TextControl.setText(mcBtnRight.textMc.textDt, this._bBtnReverse ? (positiveBtnText) : (negativeBtnText));
                    this._btnRight.enterSeId = this._bBtnReverse ? (ButtonBase.SE_DECIDE_ID) : (ButtonBase.SE_CANCEL_ID);
                    aBtn.push(this._btnRight);
                }
            }
            ButtonManager.getInstance().seal(aBtn);
            InputManager.getInstance().setDisable(true);
            switch(settings.type)
            {
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_NORMAL:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("text");
                    TextControl.setText(this._mcBase.infoDisplayMc.popupTextMc.textDt, aMsg[0]);
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_REEL:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("shop");
                    reelSettings = settings as CommonPopupSettingsParamReel;
                    this._reel = new CommonPopupReel(this._mcBase.infoDisplayMc.popupSetItemNumMc.setItemNumMc, reelSettings.reelNumDefault, reelSettings.reelNumMax);
                    TextControl.setText(this._mcBase.infoDisplayMc.popupSetItemNumMc.textMc.textDt, aMsg[0]);
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_ITEM:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("storage");
                    itemSettings = settings as CommonPopupSettingsParamItemGet;
                    if (itemSettings.itemName == null)
                    {
                        itemSettings.itemName = "";
                        if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_ACCESSORIES)
                        {
                            itemInfo = ItemManager.getInstance().getItemInformation(itemSettings.itemId);
                            if (itemInfo)
                            {
                                itemSettings.itemName = itemInfo.name;
                            }
                        }
                        else if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_CROWN)
                        {
                            itemSettings.itemName = itemSettings.itemNum + MessageManager.getInstance().getMessage(MessageId.COMMON_MONEY);
                        }
                        else if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_DESTINY_STONE)
                        {
                            mtrlInfo = ItemManager.getInstance().getMaterialInformation(itemSettings.itemId);
                            if (mtrlInfo)
                            {
                                itemSettings.itemName = mtrlInfo.name;
                            }
                        }
                        else if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_PAYMENT_ITEM)
                        {
                            paymentItemInfo = ItemManager.getInstance().getPaymentItemInformation(itemSettings.itemId);
                            if (paymentItemInfo)
                            {
                                itemSettings.itemName = paymentItemInfo.name;
                            }
                        }
                        else if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_WARRIOR)
                        {
                            playerInfo = PlayerManager.getInstance().getPlayerInformation(itemSettings.itemId);
                            if (playerInfo)
                            {
                                itemSettings.itemName = playerInfo.name;
                            }
                        }
                        else if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_ASSET)
                        {
                            assetInfo = ItemManager.getInstance().getAssetInformation(itemSettings.itemId);
                            if (assetInfo)
                            {
                                itemSettings.itemName = assetInfo.name;
                            }
                        }
                    }
                    TextControl.setText(this._mcBase.infoDisplayMc.storageReceiptTextMc.itemNameMc.textDt, itemSettings.itemName);
                    TextControl.setText(this._mcBase.infoDisplayMc.storageReceiptTextMc.textMc.textDt, aMsg[0]);
                    if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_ACCESSORIES || itemSettings.itemCategory == CommonConstant.ITEM_KIND_DESTINY_STONE || itemSettings.itemCategory == CommonConstant.ITEM_KIND_PAYMENT_ITEM || itemSettings.itemCategory == CommonConstant.ITEM_KIND_ASSET)
                    {
                        (this._mcBase.infoDisplayMc.storageReceiptTextMc.itemNumMc as MovieClip).visible = true;
                        TextControl.setText(this._mcBase.infoDisplayMc.storageReceiptTextMc.itemNumMc.textDt, "x" + itemSettings.itemNum);
                    }
                    else
                    {
                        (this._mcBase.infoDisplayMc.storageReceiptTextMc.itemNumMc as MovieClip).visible = false;
                    }
                    fileName;
                    if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_ACCESSORIES || itemSettings.itemCategory == CommonConstant.ITEM_KIND_CROWN || itemSettings.itemCategory == CommonConstant.ITEM_KIND_PAYMENT_ITEM || itemSettings.itemCategory == CommonConstant.ITEM_KIND_DESTINY_STONE || itemSettings.itemCategory == CommonConstant.ITEM_KIND_ASSET)
                    {
                        fileName = ItemManager.getInstance().getItemPng(itemSettings.itemCategory, itemSettings.itemId);
                    }
                    else if (itemSettings.itemCategory == CommonConstant.ITEM_KIND_WARRIOR)
                    {
                        fileName = ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_WARRIOR, itemSettings.itemId);
                    }
                    bitmap = ResourceManager.getInstance().createBitmap(fileName);
                    bitmap.smoothing = true;
                    bitmap.scaleX = 0.4;
                    bitmap.scaleY = 0.4;
                    bitmap.x = bitmap.x - bitmap.width / 2;
                    bitmap.y = bitmap.y - bitmap.height / 2;
                    mcNull = this._mcBase.infoDisplayMc.storageReceiptTextMc.itemNull as MovieClip;
                    if (mcNull.numChildren > 0)
                    {
                        mcNull.removeChildren(0, (mcNull.numChildren - 1));
                    }
                    mcNull.addChild(bitmap);
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_RETREAT:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("retreat");
                    TextControl.setText(this._mcBase.infoDisplayMc.retreatTextMc.retreatText1Mc.textDt, aMsg[0]);
                    TextControl.setText(this._mcBase.infoDisplayMc.retreatTextMc.retreatText2Mc.textDt, aMsg[1]);
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_CONSUME:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("training");
                    consumeSettings = settings as CommonPopupSettingsParamConsume;
                    TextControl.setText(this._mcBase.infoDisplayMc.trainingTextMc.textMc.textDt, aMsg[0]);
                    this.setIconBmp(this._mcBase.infoDisplayMc.trainingTextMc.itemNull, AssetListManager.getInstance().getAssetPng(consumeSettings.assetId), false);
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_CHECK_BOX:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("checkbox");
                    checkBoxSettings = settings as CommonPopupSettingsParamCheckBox;
                    TextControl.setText(this._mcBase.infoDisplayMc.checkboxTextMc.infoTextMc.textDt, aMsg[0]);
                    TextControl.setText(this._mcBase.infoDisplayMc.checkboxTextMc.checkTextMc.textDt, checkBoxSettings.checkText);
                    this._btnCheck = ButtonManager.getInstance().addButton(this._mcBase.infoDisplayMc.checkboxTextMc.checkBoxBtn, this.cbCheckBtn);
                    this._btnCheck.enterSeId = ButtonBase.SE_DECIDE_ID;
                    this._btnCheck.getMoveClip().checkMc.visible = checkBoxSettings.bCheck;
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_EMPEROR_SELECT:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("emperorSelect");
                    TextControl.setText(this._mcBase.infoDisplayMc.emperorSelectTextMc.text1Mc.textDt, aMsg[0]);
                    TextControl.setText(this._mcBase.infoDisplayMc.emperorSelectTextMc.text2Mc.textDt, aMsg[1] != null ? (aMsg[1]) : (""));
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_TEXT_RED:
                {
                    this._mcBase.infoDisplayMc.gotoAndStop("textRed");
                    TextControl.setText(this._mcBase.infoDisplayMc.popupTextRedMc.textDt, aMsg[0]);
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_LARGE:
                {
                    TextControl.setText(this._mcBase.WindowMc.Text1Mc.textDt, aMsg[0]);
                    TextControl.setText(this._mcBase.WindowMc.Text2Mc.textDt, aMsg[1] != null ? (aMsg[1]) : (""));
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_FREE_ITEM:
                {
                    provisionSettings = settings as CommonPopupSettingsParamProvision;
                    this._provision = new CommonPopupProvision(this._mcBase, aMsg[0], provisionSettings.aProvision);
                    this._provision.setNaviCharaBmp(this.createNaviCharaBmp(popupType));
                    break;
                }
                case CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_TYPE_COOPERATE_CODE:
                {
                    cooperateCodeSettings = settings as CommonPopupSettingsParamCooperateCode;
                    this._cooperate = new CommonPopupCooperateCode(this._mcBase, aMsg[0], cooperateCodeSettings.aCodeInfo);
                    this._cooperate.setNaviCharaBmp(this.createNaviCharaBmp(popupType));
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (settings.clip == CommonPopupSettingsParamBase.COMMON_POPUP_SETTINGS_PARAM_CLIP_INFO)
            {
                (this._mcBase.popupNaviCharaBGMc as MovieClip).visible = false;
                naviCharaBmp = this.createNaviCharaBmp(popupType);
                if (naviCharaBmp)
                {
                    (this._mcBase.popupNaviCharaBGMc as MovieClip).visible = true;
                    (this._mcBase.popupBGMc as MovieClip).visible = false;
                    this._mcBase.popupNaviCharaBGMc.infoBalloonTextMc.visible = false;
                    (this._mcBase.popupNaviCharaBGMc.naviCharaNull as MovieClip).addChild(naviCharaBmp);
                }
            }
            this._cbPopupClose = cbPopupClose;
            SoundManager.getInstance().playSe(SoundId.SE_POPUP);
            this.btnEnable(false);
            this._isoMain = new InStayOut(this._mcBase);
            this._isoMain.setIn(function () : void
            {
                btnEnable(true);
                if (_btnCenter && TutorialManager.getInstance().isTutorial())
                {
                    TutorialManager.getInstance().setTutorialArrow(_btnCenter.getMoveClip(), _provision != null ? (TutorialManager.TUTORIAL_ARROW_DIRECTION_LEFT) : (TutorialManager.TUTORIAL_ARROW_DIRECTION_UP));
                }
                return;
            }// end function
            );
            this._bUse = true;
            return;
        }// end function

        private function setIconBmp(param1:MovieClip, param2:String, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            if (param1.numChildren > 0)
            {
                param1.removeChildren(0, (param1.numChildren - 1));
            }
            if (param2 != "")
            {
                _loc_4 = ResourceManager.getInstance().createBitmap(param2);
                _loc_4.smoothing = true;
                if (param3)
                {
                    _loc_4.scaleX = 0.4;
                    _loc_4.scaleY = 0.4;
                    _loc_4.x = _loc_4.x - _loc_4.width / 2;
                    _loc_4.y = _loc_4.y - _loc_4.height / 2;
                }
                param1.addChild(_loc_4);
            }
            return;
        }// end function

        private function createNaviCharaBmp(param1:int) : Bitmap
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case POPUP_TYPE_NAVI:
                {
                    _loc_2 = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
                    break;
                }
                case POPUP_TYPE_NAVI_SEKISHUSAI:
                {
                    _loc_2 = ResourceManager.getInstance().createBitmap(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_sekishusai.png");
                    break;
                }
                case POPUP_TYPE_NAVI_EMERALD:
                {
                    _loc_2 = ResourceManager.getInstance().createBitmap(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_emerald.png");
                    break;
                }
                case POPUP_TYPE_NAVI_NORA:
                {
                    _loc_2 = ResourceManager.getInstance().createBitmap(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_nora.png");
                    break;
                }
                case POPUP_TYPE_NAVI_FULBRIGHT:
                {
                    _loc_2 = ResourceManager.getInstance().createBitmap(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_fulbright.png");
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2)
            {
                _loc_2.smoothing = true;
                _loc_2.x = -_loc_2.width / 2;
                _loc_2.y = -_loc_2.height;
            }
            return _loc_2;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            if (this._btnLeft)
            {
                this._btnLeft.setDisable(!param1);
            }
            if (this._btnCenter)
            {
                this._btnCenter.setDisable(!param1);
            }
            if (this._btnRight)
            {
                this._btnRight.setDisable(!param1);
            }
            if (this._btnCheck)
            {
                this._btnCheck.setDisable(!param1);
            }
            return;
        }// end function

        private function cbCheckBtn(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._btnCheck)
            {
                _loc_2 = this._btnCheck.getMoveClip().checkMc;
                _loc_2.visible = _loc_2.visible == false;
            }
            return;
        }// end function

        private function cbBtn(param1:int) : void
        {
            var id:* = param1;
            TutorialManager.getInstance().hideTutorialArrow();
            this.btnEnable(false);
            if (this._fade)
            {
                this._fade.setFadeIn(0.5);
            }
            this._isoMain.setOut(function () : void
            {
                var _loc_1:* = _cbPopupClose;
                _cbPopupClose = null;
                var _loc_2:* = _reel != null;
                var _loc_3:* = _loc_2 ? (_reel.num) : (0);
                var _loc_4:* = _btnCheck != null;
                var _loc_5:* = _btnCheck != null ? (_btnCheck.getMoveClip().checkMc.visible) : (false);
                release();
                if (_loc_1 != null)
                {
                    if (!_loc_2 && !_loc_4)
                    {
                        if (id == 0)
                        {
                            null._loc_1(!_bBtnReverse);
                        }
                        else if (id == 1)
                        {
                            null._loc_1();
                        }
                        else if (id == 2)
                        {
                            null._loc_1(_bBtnReverse);
                        }
                    }
                    else if (_loc_2)
                    {
                        if (id == 0)
                        {
                            null._loc_1(!_bBtnReverse, _loc_3);
                        }
                        else if (id == 1)
                        {
                            null._loc_1(_loc_3);
                        }
                        else if (id == 2)
                        {
                            null._loc_1(_bBtnReverse, _loc_3);
                        }
                    }
                    else if (id == 0)
                    {
                        null._loc_1(!_bBtnReverse, _loc_5);
                    }
                    else if (id == 1)
                    {
                        null._loc_1(_loc_5);
                    }
                    else if (id == 2)
                    {
                        null._loc_1(_bBtnReverse, _loc_5);
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbBtn_FreeItem(param1:int) : void
        {
            if (this._provision == null || this._provision.isEmpty())
            {
                return this.cbBtn(param1);
            }
            this._provision.nextItem();
            return;
        }// end function

        private function cbBtn_CooperateCode(param1:int) : void
        {
            if (this._cooperate == null || this._cooperate.isEmpty())
            {
                return this.cbBtn(param1);
            }
            this._cooperate.nextItem();
            return;
        }// end function

        public static function getInstance() : CommonPopup
        {
            if (_instance == null)
            {
                _instance = new CommonPopup;
            }
            return _instance;
        }// end function

        public static function isUse() : Boolean
        {
            return _instance && _instance.bUse;
        }// end function

    }
}
