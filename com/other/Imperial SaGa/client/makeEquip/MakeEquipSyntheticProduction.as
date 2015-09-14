package makeEquip
{
    import button.*;
    import destinystone.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class MakeEquipSyntheticProduction extends MakeEquipBase
    {
        private var _aStoneImage:Array;
        private var _itemId:uint;
        private var _bResource:Boolean;
        private var animationMc:MovieClip;
        private var _isoAnimationMc:InStayOut;
        private var resultMc:MovieClip;
        private var _isoResultMc:InStayOut;
        private var Create_BgMc:MovieClip;
        private var _isoCreate_Bg:InStayOut;
        private var _mcWindow:MovieClip;
        private var _bWarehouse:Boolean;
        private var _bmp:Bitmap;
        private var _bStayTrigged:Boolean = false;

        public function MakeEquipSyntheticProduction(param1:DisplayObjectContainer, param2:int, param3:MovieClip, param4:uint, param5:Boolean)
        {
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            this._aStoneImage = [];
            this._itemId = param4;
            this._bWarehouse = param5 && this.bSuccess;
            this._mcWindow = param3;
            var _loc_6:* = "Create_Normal";
            var _loc_7:* = "Result_Fail";
            var _loc_8:* = Random.range(1, 10);
            if (this.bSuccess)
            {
                if (_loc_8 <= 7)
                {
                    _loc_7 = "Result_Success";
                    _loc_6 = "Create_Normal";
                }
                if (_loc_8 > 7)
                {
                    _loc_7 = "Result_Success";
                    _loc_6 = "Create_Special";
                }
            }
            this.Create_BgMc = ResourceManager.getInstance().createMovieClip(MakeEquipConstant.RESOURCE_ANIMATION_PATH, "Create_Bg");
            this._isoCreate_Bg = new InStayOut(this.Create_BgMc);
            this.animationMc = ResourceManager.getInstance().createMovieClip(MakeEquipConstant.RESOURCE_ANIMATION_PATH, _loc_6);
            this._isoAnimationMc = new InStayOut(this.animationMc);
            this.resultMc = ResourceManager.getInstance().createMovieClip(MakeEquipConstant.RESOURCE_ANIMATION_PATH, _loc_7);
            this._isoResultMc = new InStayOut(this.resultMc);
            param1.addChild(this.Create_BgMc);
            this.Create_BgMc.CreateNull.addChild(this.animationMc);
            this.Create_BgMc.ResultNull.addChild(this.resultMc);
            super(param1, "createResultMc", false);
            var _loc_9:* = MakeEquipConstant.aUseStone[1];
            var _loc_10:* = 0;
            while (_loc_10 < 3)
            {
                
                _loc_12 = ItemManager.getInstance().getDestinyStoneInformation(_loc_9[_loc_10]);
                _loc_13 = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_12.fileName);
                _loc_13.smoothing = true;
                _loc_10++;
            }
            var _loc_11:* = ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbReturn);
            ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbReturn).enterSeId = ButtonBase.SE_CANCEL_ID;
            _aButton.push(_loc_11);
            setButtonDisable(true);
            TextControl.setIdText(_mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            if (this.bSuccess)
            {
                _loc_14 = ItemManager.getInstance().getItemInformation(this._itemId);
                ResourceManager.getInstance().loadResource(ResourcePath.EQUIPMENT_IMG_PATH + _loc_14.fileName);
            }
            else
            {
                TextControl.setIdText(_mc.compoNameWindMc.textMc.textDt, MessageId.MAKE_EQUIP_CREATE_FAILURE);
                this._bResource = true;
                this.setOpne();
            }
            return;
        }// end function

        private function get bSuccess() : Boolean
        {
            return this._itemId > 0;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.release();
            if (this._bmp)
            {
                if (this._bmp.bitmapData != null)
                {
                    this._bmp.bitmapData.dispose();
                }
                if (this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
            }
            this._bmp = null;
            for each (_loc_1 in this._aStoneImage)
            {
                
                _loc_2 = _loc_1.bitmapData;
                if (_loc_2 != null)
                {
                    _loc_2.dispose();
                }
                if (_loc_1.parent != null)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            this._aStoneImage = [];
            return;
        }// end function

        private function setOpne() : void
        {
            this._isoCreate_Bg.setInLabel("start", function () : void
            {
                _isoAnimationMc.setInLabel("start");
                return;
            }// end function
            );
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var t:* = param1;
            if (this.animationMc.currentFrameLabel == "end")
            {
                this._isoAnimationMc.setOutLabel("end", function () : void
            {
                _isoResultMc.setInLabel("start");
                return;
            }// end function
            );
            }
            if (this.animationMc.currentFrameLabel == "play_se_01")
            {
                SoundManager.getInstance().playSe(SoundId.SE_LANDING1016B);
            }
            if (this.animationMc.currentFrameLabel == "play_se_02")
            {
                SoundManager.getInstance().playSe(SoundId.SE_RS3_OTHER_FLASH);
            }
            if (this.animationMc.currentFrameLabel == "play_se_03")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_WIND);
            }
            if (this.animationMc.currentFrameLabel == "play_se_04")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_STEAM);
            }
            if (this.animationMc.currentFrameLabel == "play_se_05")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_ANVIL);
            }
            if (this.animationMc.currentFrameLabel == "play_se_06")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_ANVIL);
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_ANVIL);
            }
            if (this.animationMc.currentFrameLabel == "play_se_07")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_ANVIL);
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_ANVIL);
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_WIND);
            }
            if (this.animationMc.currentFrameLabel == "play_se_08")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_ANVIL);
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_ANVIL);
                SoundManager.getInstance().playSe(SoundId.SE_REV_COMPOSE_STEAM);
            }
            if (this.resultMc.currentFrameLabel == "play_se_SE_COMPOSE_SUCSESS")
            {
                SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_SUCSESS);
            }
            if (this.resultMc.currentFrameLabel == "play_se_SE_COMPOSE_FALE")
            {
                SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_FALE);
            }
            if (this.resultMc.currentFrameLabel == "stay" && this._bStayTrigged == false)
            {
                this._bStayTrigged = true;
                _isoMain.setIn(this.cbIn);
            }
            if (_mc.isPlaying)
            {
                if (_mc.currentFrame == 30)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_START1016);
                }
                if (this.bSuccess && _mc.currentFrame == 106)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_SUCSESS);
                }
                if (!this.bSuccess && _mc.currentFrame == 120)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_FALE);
                }
            }
            if (this._bResource)
            {
                return;
            }
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            var itemInfo:* = ItemManager.getInstance().getItemInformation(this._itemId);
            this._bmp = ResourceManager.getInstance().createBitmap(ResourcePath.EQUIPMENT_IMG_PATH + itemInfo.fileName);
            this._bmp.smoothing = true;
            this.resultMc.itemIconMc.itemNull.addChild(this._bmp);
            TextControl.setText(_mc.compoNameWindMc.textMc.textDt, StringTools.format(MessageManager.getInstance().getMessage(MessageId.MAKE_EQUIP_CREATE_SUCCESS), itemInfo.name));
            this._bResource = true;
            this.setOpne();
            return;
        }// end function

        private function cbIn() : void
        {
            if (this._bWarehouse)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_SEND_STRAGE), function () : void
            {
                enableButton();
                return;
            }// end function
            );
            }
            else
            {
                this.enableButton();
            }
            return;
        }// end function

        private function cbReturn(param1:int) : void
        {
            close();
            this._isoResultMc.setOut();
            this._isoCreate_Bg.setOut();
            return;
        }// end function

        private function enableButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _aButton)
            {
                
                _loc_1.setDisable(false);
            }
            return;
        }// end function

    }
}
