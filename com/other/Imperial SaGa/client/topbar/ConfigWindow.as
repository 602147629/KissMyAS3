package topbar
{
    import button.*;
    import flash.display.*;
    import input.*;
    import layer.*;
    import message.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class ConfigWindow extends Object
    {
        private var _layer:LayerMainProcess;
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _bgmMarker:ConfigSlider;
        private var _seMarker:ConfigSlider;
        private var _aImageButton:Array;
        private var _aBattleButton:Array;
        private var _aCallButton:Array;
        private var _aButton:Array;
        private var _bgmMuteBtn:SelectButton;
        private var _seMuteBtn:SelectButton;
        private var _closeBtn:ButtonBase;
        private var _cbCloseFc:Function;
        private static const BUTTON_BGM_MUTE:int = 1;
        private static const BUTTON_SE_MUTE:int = 2;
        private static const BUTTON_HIGH:int = 3;
        private static const BUTTON_MIDDLE:int = 4;
        private static const BUTTON_LOW:int = 5;
        private static const BUTTON_BATTLE_HIGH:int = 6;
        private static const BUTTON_BATTLE_NORMAL:int = 7;
        private static const BUTTON_CALL_HIGH:int = 8;
        private static const BUTTON_CALL_NORMAL:int = 9;
        public static const MARKER_TYPE_BGM:int = 1;
        public static const MARKER_TYPE_SE:int = 2;

        public function ConfigWindow(param1:LayerMainProcess, param2:Function)
        {
            ButtonManager.getInstance().seal([]);
            this._layer = param1;
            this._cbCloseFc = param2;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_option.swf", "optionTopMc");
            this._isoMc = new InStayOut(this._baseMc);
            TextControl.setIdText(this._baseMc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._bgmMarker = new ConfigSlider(this._baseMc.optionAnimMc.suradaSet1Mc, Main.GetApplicationData().userConfigData.bgmVolumeMag, MARKER_TYPE_BGM);
            this._seMarker = new ConfigSlider(this._baseMc.optionAnimMc.suradaSet2Mc, Main.GetApplicationData().userConfigData.seVolumeMag, MARKER_TYPE_SE);
            this.createButton();
            this.changeStageQualityButton(Main.GetApplicationData().userConfigData.stageQuality);
            this.changeBattleSpeedButton(Main.GetApplicationData().userConfigData.battleSpeed);
            this.changeCallSpeedButton(Main.GetApplicationData().userConfigData.callSpeed);
            this._baseMc.visible = false;
            this._layer.getLayer(LayerMainProcess.OPTION).addChild(this._baseMc);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.delButton();
            for each (_loc_1 in this._aImageButton)
            {
                
                _loc_1.release();
            }
            this._aImageButton = null;
            for each (_loc_2 in this._aBattleButton)
            {
                
                _loc_2.release();
            }
            this._aBattleButton = null;
            for each (_loc_3 in this._aCallButton)
            {
                
                _loc_3.release();
            }
            this._aCallButton = null;
            for each (_loc_4 in this._aButton)
            {
                
                _loc_4.release();
            }
            this._aButton = null;
            if (this._bgmMarker)
            {
                this._bgmMarker.release();
            }
            this._bgmMarker = null;
            if (this._seMarker)
            {
                this._seMarker.release();
            }
            this._seMarker = null;
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bgmMarker)
            {
                this._bgmMarker.control(param1);
            }
            if (this._seMarker)
            {
                this._seMarker.control(param1);
            }
            return;
        }// end function

        public function open() : void
        {
            if (this._isoMc.bWait || this._isoMc.bClosed)
            {
                this._baseMc.visible = true;
                this.addButton();
                this._isoMc.setIn();
                InputManager.getInstance().setDisable(true);
            }
            return;
        }// end function

        public function get bOpend() : Boolean
        {
            return this._isoMc.bOpened;
        }// end function

        private function createButton() : void
        {
            this._aBattleButton = [];
            this._aImageButton = [];
            this._aCallButton = [];
            this._aButton = [];
            this._closeBtn = new ButtonBase(this._baseMc.closeBtnMc, this.cbCloseButton);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._aButton.push(this._closeBtn);
            this._bgmMuteBtn = new SelectButton(this._baseMc.optionAnimMc.mute1Btn, this.cbButtonClick);
            this._bgmMuteBtn.setId(BUTTON_BGM_MUTE);
            this._bgmMuteBtn.setSelect(Main.GetApplicationData().userConfigData.bBgmMute);
            this._bgmMuteBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._bgmMarker.bMuteMarker(this._bgmMuteBtn.bSelect);
            this._aButton.push(this._bgmMuteBtn);
            this._seMuteBtn = new SelectButton(this._baseMc.optionAnimMc.mute2Btn, this.cbButtonClick);
            this._seMuteBtn.setId(BUTTON_SE_MUTE);
            this._seMuteBtn.setSelect(Main.GetApplicationData().userConfigData.bSeMute);
            this._seMarker.bMuteMarker(this._seMuteBtn.bSelect);
            this._aButton.push(this._seMuteBtn);
            var _loc_1:* = new SelectButton(this._baseMc.optionAnimMc.highBtn, this.cbButtonClick);
            _loc_1.setId(BUTTON_HIGH);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aImageButton.push(_loc_1);
            _loc_1 = new SelectButton(this._baseMc.optionAnimMc.middleBtn, this.cbButtonClick);
            _loc_1.setId(BUTTON_MIDDLE);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aImageButton.push(_loc_1);
            _loc_1 = new SelectButton(this._baseMc.optionAnimMc.lowBtn, this.cbButtonClick);
            _loc_1.setId(BUTTON_LOW);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aImageButton.push(_loc_1);
            _loc_1 = new SelectButton(this._baseMc.optionAnimMc.quickSpeed1Btn, this.cbButtonClick);
            _loc_1.setId(BUTTON_BATTLE_HIGH);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aBattleButton.push(_loc_1);
            _loc_1 = new SelectButton(this._baseMc.optionAnimMc.nomalSpeed1Btn, this.cbButtonClick);
            _loc_1.setId(BUTTON_BATTLE_NORMAL);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aBattleButton.push(_loc_1);
            _loc_1 = new SelectButton(this._baseMc.optionAnimMc.quickSpeed2Btn, this.cbButtonClick);
            _loc_1.setId(BUTTON_CALL_HIGH);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aCallButton.push(_loc_1);
            _loc_1 = new SelectButton(this._baseMc.optionAnimMc.nomalSpeed2Btn, this.cbButtonClick);
            _loc_1.setId(BUTTON_CALL_NORMAL);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aCallButton.push(_loc_1);
            return;
        }// end function

        private function addButton() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_1 in this._aImageButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            for each (_loc_2 in this._aBattleButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_2);
            }
            for each (_loc_3 in this._aCallButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_3);
            }
            for each (_loc_4 in this._aButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_4);
            }
            return;
        }// end function

        private function delButton() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_1 in this._aImageButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            for each (_loc_2 in this._aBattleButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_2);
            }
            for each (_loc_3 in this._aCallButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_3);
            }
            for each (_loc_4 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_4);
            }
            return;
        }// end function

        private function changeBgmMute() : void
        {
            this._bgmMuteBtn.setSelect(Main.GetApplicationData().userConfigData.bBgmMute == false);
            if (this._bgmMuteBtn.bSelect)
            {
                this._bgmMarker.bMuteMarker(true);
            }
            else
            {
                this._bgmMarker.bMuteMarker(false);
            }
            Main.GetApplicationData().userConfigData.bBgmMute = this._bgmMuteBtn.bSelect;
            return;
        }// end function

        private function changeSeMute() : void
        {
            this._seMuteBtn.setSelect(Main.GetApplicationData().userConfigData.bSeMute == false);
            if (this._seMuteBtn.bSelect)
            {
                this._seMarker.bMuteMarker(true);
                Main.GetApplicationData().userConfigData.bSeMute = this._seMuteBtn.bSelect;
            }
            else
            {
                this._seMarker.bMuteMarker(false);
                Main.GetApplicationData().userConfigData.bSeMute = this._seMuteBtn.bSelect;
                SoundManager.getInstance().playSe(ButtonBase.SE_CURSOR_ID);
            }
            return;
        }// end function

        private function changeStageQuality(param1:int) : void
        {
            var _loc_2:* = Main.GetApplicationData().userConfigData.stageQuality;
            switch(param1)
            {
                case BUTTON_HIGH:
                {
                    _loc_2 = UserConfigData.STAGE_QUALITY_HIGH;
                    break;
                }
                case BUTTON_MIDDLE:
                {
                    _loc_2 = UserConfigData.STAGE_QUALITY_MIDDLE;
                    break;
                }
                case BUTTON_LOW:
                {
                    _loc_2 = UserConfigData.STAGE_QUALITY_LOW;
                    break;
                }
                default:
                {
                    break;
                }
            }
            Main.GetApplicationData().userConfigData.stageQuality = _loc_2;
            this.changeStageQualityButton(_loc_2);
            return;
        }// end function

        private function changeStageQualityButton(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = Main.GetApplicationData().userConfigData.stageQuality;
            switch(param1)
            {
                case UserConfigData.STAGE_QUALITY_HIGH:
                {
                    _loc_2 = BUTTON_HIGH;
                    break;
                }
                case UserConfigData.STAGE_QUALITY_MIDDLE:
                {
                    _loc_2 = BUTTON_MIDDLE;
                    break;
                }
                case UserConfigData.STAGE_QUALITY_LOW:
                {
                    _loc_2 = BUTTON_LOW;
                    break;
                }
                default:
                {
                    break;
                }
            }
            for each (_loc_3 in this._aImageButton)
            {
                
                if (_loc_3.id == _loc_2)
                {
                    _loc_3.setSelect(true);
                    continue;
                }
                _loc_3.setSelect(false);
            }
            return;
        }// end function

        private function changeBattleSpeed(param1:int) : void
        {
            var _loc_2:* = Main.GetApplicationData().userConfigData.battleSpeed;
            switch(param1)
            {
                case BUTTON_BATTLE_HIGH:
                {
                    _loc_2 = UserConfigData.BATTLE_SPEED_QUICK;
                    break;
                }
                case BUTTON_BATTLE_NORMAL:
                {
                    _loc_2 = UserConfigData.BATTLE_SPEED_NORMAL;
                    break;
                }
                default:
                {
                    break;
                }
            }
            Main.GetApplicationData().userConfigData.battleSpeed = _loc_2;
            this.changeBattleSpeedButton(_loc_2);
            return;
        }// end function

        private function changeBattleSpeedButton(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = Main.GetApplicationData().userConfigData.battleSpeed;
            switch(param1)
            {
                case UserConfigData.BATTLE_SPEED_QUICK:
                {
                    _loc_2 = BUTTON_BATTLE_HIGH;
                    break;
                }
                case UserConfigData.BATTLE_SPEED_NORMAL:
                {
                    _loc_2 = BUTTON_BATTLE_NORMAL;
                    break;
                }
                default:
                {
                    break;
                }
            }
            for each (_loc_3 in this._aBattleButton)
            {
                
                if (_loc_3.id == _loc_2)
                {
                    _loc_3.setSelect(true);
                    continue;
                }
                _loc_3.setSelect(false);
            }
            return;
        }// end function

        private function changeCallSpeed(param1:int) : void
        {
            var _loc_2:* = Main.GetApplicationData().userConfigData.callSpeed;
            switch(param1)
            {
                case BUTTON_CALL_HIGH:
                {
                    _loc_2 = UserConfigData.CALL_SPEED_QUICK;
                    break;
                }
                case BUTTON_CALL_NORMAL:
                {
                    _loc_2 = UserConfigData.CALL_SPEED_NORMAL;
                    break;
                }
                default:
                {
                    break;
                }
            }
            Main.GetApplicationData().userConfigData.callSpeed = _loc_2;
            this.changeCallSpeedButton(_loc_2);
            return;
        }// end function

        private function changeCallSpeedButton(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = Main.GetApplicationData().userConfigData.callSpeed;
            switch(param1)
            {
                case UserConfigData.CALL_SPEED_QUICK:
                {
                    _loc_2 = BUTTON_CALL_HIGH;
                    break;
                }
                case UserConfigData.CALL_SPEED_NORMAL:
                {
                    _loc_2 = BUTTON_CALL_NORMAL;
                    break;
                }
                default:
                {
                    break;
                }
            }
            for each (_loc_3 in this._aCallButton)
            {
                
                if (_loc_3.id == _loc_2)
                {
                    _loc_3.setSelect(true);
                    continue;
                }
                _loc_3.setSelect(false);
            }
            return;
        }// end function

        private function cbButtonClick(param1:int) : void
        {
            switch(param1)
            {
                case BUTTON_BGM_MUTE:
                {
                    this.changeBgmMute();
                    break;
                }
                case BUTTON_SE_MUTE:
                {
                    this.changeSeMute();
                    break;
                }
                case BUTTON_HIGH:
                case BUTTON_MIDDLE:
                case BUTTON_LOW:
                {
                    this.changeStageQuality(param1);
                    break;
                }
                case BUTTON_BATTLE_HIGH:
                case BUTTON_BATTLE_NORMAL:
                {
                    this.changeBattleSpeed(param1);
                    break;
                }
                case BUTTON_CALL_HIGH:
                case BUTTON_CALL_NORMAL:
                {
                    this.changeCallSpeed(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            if (this._isoMc.bOpened)
            {
                ButtonManager.getInstance().unseal();
                Main.GetApplicationData().userConfigData.save();
                this.delButton();
                this._isoMc.setOut(this.cbSetOut);
                InputManager.getInstance().setDisable(false);
            }
            return;
        }// end function

        private function cbSetOut() : void
        {
            this._baseMc.visible = false;
            this._cbCloseFc();
            return;
        }// end function

    }
}
