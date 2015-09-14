package facility
{
    import flash.display.*;
    import playerList.*;
    import sound.*;
    import status.*;
    import user.*;

    public class FacilityUpgradePlayerList extends PlayerListBase
    {
        private var _aMultiSelectedUniqueId:Array;
        private var _multiSelectMax:int;
        private var _isExpMax:Boolean;
        private var _cbSelectCountOver:Function;
        private var _cbExpOver:Function;
        private var _cbRemainPlayerNum:Function;
        private var _overlay:Shape;
        private static const _MULTI_SELECTED_ARRAY_KEY:String = "multi";

        public function FacilityUpgradePlayerList(param1:MovieClip, param2:Array, param3:int)
        {
            super(param1, param2);
            this._aMultiSelectedUniqueId = [];
            this._multiSelectMax = param3;
            this._isExpMax = false;
            this._cbSelectCountOver = null;
            this._cbExpOver = null;
            this._cbRemainPlayerNum = null;
            this._overlay = new Shape();
            this._overlay.graphics.beginFill(4473924);
            this._overlay.graphics.drawRect(0, 0, 486, 456);
            this._overlay.graphics.endFill();
            this._overlay.alpha = 0.5;
            _mcBase.addChild(this._overlay);
            this._overlay.visible = false;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._cbSelectCountOver = null;
            this._cbExpOver = null;
            this._cbRemainPlayerNum = null;
            return;
        }// end function

        override public function resetSelect() : void
        {
            var _loc_1:* = null;
            super.resetSelect();
            this._aMultiSelectedUniqueId = [];
            for each (_loc_1 in _aListPlayerDisplay)
            {
                
                if (_loc_1.bShow)
                {
                    _loc_1.playerDisplay.setSelect(false);
                    _loc_1.playerActionController.resetAction();
                }
            }
            return;
        }// end function

        override protected function onSelectPlayer(param1:int, param2:ListPlayerDisplay, param3:ListPlayerDisplay) : void
        {
            if (this._aMultiSelectedUniqueId[_MULTI_SELECTED_ARRAY_KEY + param2.playerDisplay.uniqueId] != undefined)
            {
                this._aMultiSelectedUniqueId[_MULTI_SELECTED_ARRAY_KEY + param2.playerDisplay.uniqueId] = undefined;
                SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                if (_cbPlayerUnselectFunc != null)
                {
                    _cbPlayerUnselectFunc(param1, param2.playerData);
                }
                return;
            }
            var _loc_4:* = this.getMultiSelectNum();
            if (this.getMultiSelectNum() >= this._multiSelectMax)
            {
                if (this._cbSelectCountOver != null)
                {
                    this._cbSelectCountOver(param1, param2.playerData);
                }
                return;
            }
            if (this._isExpMax)
            {
                if (this._cbExpOver != null)
                {
                    this._cbExpOver(param1, param2.playerData);
                }
                return;
            }
            if (UserDataManager.getInstance().checkRemainPlayerNum((_loc_4 + 1)) == false)
            {
                if (this._cbRemainPlayerNum != null)
                {
                    this._cbRemainPlayerNum(param1, param2.playerData);
                }
                return;
            }
            this._aMultiSelectedUniqueId[_MULTI_SELECTED_ARRAY_KEY + param2.playerDisplay.uniqueId] = param2.playerDisplay.uniqueId;
            SoundManager.getInstance().playSe(SoundId.SE_CHARA_SELECT);
            if (_cbPlayerSelectFunc != null)
            {
                _cbPlayerSelectFunc(param1, param2.playerData);
            }
            return;
        }// end function

        override protected function isSelectedPlayer(param1:ListPlayerDisplay) : Boolean
        {
            return this._aMultiSelectedUniqueId[_MULTI_SELECTED_ARRAY_KEY + param1.playerDisplay.uniqueId] != undefined;
        }// end function

        public function getMultiSelectNum() : int
        {
            var _loc_2:* = undefined;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aMultiSelectedUniqueId)
            {
                
                if (_loc_2 != undefined)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        public function getMultiSelectPlayerUniqueIdArray() : Array
        {
            var _loc_2:* = undefined;
            var _loc_1:* = [];
            for each (_loc_2 in this._aMultiSelectedUniqueId)
            {
                
                if (_loc_2 != undefined)
                {
                    _loc_1.push(_loc_2);
                }
            }
            return _loc_1;
        }// end function

        public function setSelectCountOverCallback(param1:Function) : void
        {
            this._cbSelectCountOver = param1;
            return;
        }// end function

        public function setExpOverCallback(param1:Function) : void
        {
            this._cbExpOver = param1;
            return;
        }// end function

        public function setRemainPlayerNumCallback(param1:Function) : void
        {
            this._cbRemainPlayerNum = param1;
            return;
        }// end function

        public function overlayVisible(param1:Boolean) : void
        {
            this._overlay.visible = param1;
            return;
        }// end function

        public function unselectPlayer(param1:int) : void
        {
            if (this._aMultiSelectedUniqueId[_MULTI_SELECTED_ARRAY_KEY + param1] != undefined)
            {
                this._aMultiSelectedUniqueId[_MULTI_SELECTED_ARRAY_KEY + param1] = undefined;
                SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                updateList();
            }
            return;
        }// end function

        public function setExpMaxState(param1:Boolean) : void
        {
            this._isExpMax = param1;
            return;
        }// end function

        public static function loadResource() : void
        {
            loadSoundResourceBase();
            PlayerSimpleStatus.loadResource();
            SoundManager.getInstance().loadSoundArray([SoundId.SE_CANCEL]);
            return;
        }// end function

    }
}
