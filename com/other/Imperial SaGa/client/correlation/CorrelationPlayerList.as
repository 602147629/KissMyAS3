package correlation
{
    import button.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import playerList.*;
    import status.*;
    import user.*;
    import utility.*;

    public class CorrelationPlayerList extends PlayerListBase
    {
        private var _parent:DisplayObjectContainer;
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _fade:Fade;
        private var _closeBtn:ButtonBase;
        private var _cbClose:Function;

        public function CorrelationPlayerList(param1:DisplayObjectContainer, param2:MovieClip, param3:Array, param4:Function)
        {
            super(param2.reserveListMc, param3);
            _bEnableBalloonStatus = false;
            this._parent = param1;
            this._baseMc = param2;
            this._isoMc = new InStayOut(param2);
            this._fade = new Fade(this._parent, 0.5);
            this._fade.setFadeIn(0);
            this._closeBtn = ButtonManager.getInstance().addButton(param2.returnBtnMc, this.cbCloseButton);
            this._closeBtn.setDisableFlag(true);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(param2.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._parent.addChild(param2);
            this._cbClose = param4;
            setSelectEnable(false);
            setPlayerSelectEnable(false);
            setCaptionIdText(MessageId.CORRELATION_TITLE);
            return;
        }// end function

        override public function release() : void
        {
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            this._closeBtn = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        override protected function onSelectPlayer(param1:int, param2:ListPlayerDisplay, param3:ListPlayerDisplay) : void
        {
            super.onSelectPlayer(param1, param2, param3);
            var _loc_4:* = StatusManager.getInstance().getOwnItemList(UserDataManager.getInstance().userData.getOwnItem(CommonConstant.ITEM_KIND_ACCESSORIES), UserDataManager.getInstance().userData.aPlayerPersonal, param2.playerData.personal.uniqueId);
            StatusManager.getInstance().addStatusDetail(PlayerDetailStatus.STATUS_TYPE_NOT_CHANGE_EQUIPMENT, this._parent, null, param2.playerData.personal, _loc_4);
            return;
        }// end function

        public function open(param1:int) : void
        {
            var aPlayerPersonal:Array;
            var aListPlayerData:Array;
            var personal:PlayerPersonal;
            var playerId:* = param1;
            if (this._isoMc.bClosed)
            {
                aPlayerPersonal = UserDataManager.getInstance().userData.getCorrelationList(playerId);
                aListPlayerData;
                var _loc_3:* = 0;
                var _loc_4:* = aPlayerPersonal;
                while (_loc_4 in _loc_3)
                {
                    
                    personal = _loc_4[_loc_3];
                    aListPlayerData.push(new ListPlayerData(personal));
                }
                setPlayerList(aListPlayerData);
                updateList();
                this._closeBtn.setDisableFlag(false);
                this._fade.setFadeOut(Constant.FADE_OUT_TIME);
                this._isoMc.setIn(function () : void
            {
                setSelectEnable(true);
                setPlayerSelectEnable(true);
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._isoMc.bOpened)
            {
                setSelectEnable(false);
                setPlayerSelectEnable(false);
                this._closeBtn.setDisableFlag(true);
                this._fade.setFadeIn(Constant.FADE_IN_TIME);
                this._isoMc.setOut(this._cbClose);
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this.close();
            return;
        }// end function

        private function cbRestEnd(param1:PlayerPersonal) : void
        {
            updateList();
            setRestEndAction(param1.uniqueId);
            return;
        }// end function

        public static function loadResource() : void
        {
            loadSoundResourceBase();
            return;
        }// end function

    }
}
