package magicLaboratory
{
    import flash.display.*;
    import message.*;
    import player.*;
    import playerList.*;
    import user.*;
    import utility.*;

    public class MLearnReserveList extends Object
    {
        private var _baseMc:MovieClip;
        private var _isoMain:InStayOut;
        private var _reserveList:MLearnPlayerList;
        private var _overlay:Shape;

        public function MLearnReserveList(param1:MovieClip)
        {
            this._baseMc = param1;
            this._isoMain = new InStayOut(this._baseMc);
            this._reserveList = new MLearnPlayerList(this._baseMc.reserveListMc, this.createListPlayerData());
            this._reserveList.setNotDisplayPlayer(this.createNotDisplayList());
            this._reserveList.setPlayerSelectCallback(this.cbPlayerSelectFunc);
            this._reserveList.updateList();
            this._reserveList.setInformationBarMessage(MessageManager.getInstance().getMessage(MessageId.MAGIC_LEARN_PLAYER_LIST_INFORMATION));
            this._overlay = new Shape();
            this._overlay.graphics.beginFill(4473924);
            this._overlay.graphics.drawRect(0, 0, 486, 456);
            this._overlay.graphics.endFill();
            this._overlay.alpha = 0.5;
            this._baseMc.addChild(this._overlay);
            this.overlayVisible(false);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain.bEnd;
        }// end function

        public function get selectedUniqueId() : int
        {
            var _loc_1:* = null;
            if (this._reserveList)
            {
                _loc_1 = this._reserveList.getSelectedPlayerData();
                if (_loc_1)
                {
                    return _loc_1.personal.uniqueId;
                }
                return Constant.EMPTY_ID;
            }
            return Constant.EMPTY_ID;
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._reserveList)
            {
                this._reserveList.release();
            }
            this._reserveList = null;
            this._baseMc = null;
            return;
        }// end function

        public function overlayVisible(param1:Boolean) : void
        {
            this._overlay.visible = param1;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._reserveList.control(param1);
            return;
        }// end function

        public function resetPlayerListData() : void
        {
            this._reserveList.setPlayerList(this.createListPlayerData());
            return;
        }// end function

        public function open() : void
        {
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        public function close() : void
        {
            this._reserveList.setSelectEnable(false);
            this._isoMain.setOut();
            return;
        }// end function

        private function createListPlayerData() : Array
        {
            var _loc_3:* = null;
            var _loc_1:* = [];
            var _loc_2:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1.push(new ListPlayerData(_loc_3));
            }
            return _loc_1;
        }// end function

        private function createNotDisplayList() : Array
        {
            var _loc_3:* = null;
            var _loc_1:* = [];
            var _loc_2:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.isUseFacility() || UserDataManager.getInstance().userData.aFormationPlayerUniqueId.indexOf(_loc_3.uniqueId) != -1 || MagicLearnUtility.getLearnableSkillId(_loc_3.uniqueId).length == 0)
                {
                    _loc_1.push(_loc_3.uniqueId);
                }
            }
            return _loc_1;
        }// end function

        public function fixSelectPlayer() : void
        {
            this.resetSelectPlayer();
            this.setSelectEnable(false);
            return;
        }// end function

        public function resetSelectPlayer() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this.createNotDisplayList();
            for each (_loc_2 in MagicLabolatoryManager.getInstance().aLearningData)
            {
                
                _loc_1.push(_loc_2.uniqueId);
            }
            this._reserveList.setNotDisplayPlayer(_loc_1);
            this._reserveList.resetSelect();
            this._reserveList.updateList();
            this._reserveList.checkEmptyInformation();
            this.setSelectEnable(true);
            return;
        }// end function

        public function setSelectEnable(param1:Boolean) : void
        {
            this._reserveList.setSelectEnable(param1);
            this._reserveList.overlayVisible(!param1);
            return;
        }// end function

        private function cbIn() : void
        {
            this._reserveList.setSelectEnable(true);
            return;
        }// end function

        private function cbPlayerSelectFunc(param1:int, param2:ListPlayerData) : void
        {
            this._reserveList.setSelectEnable(false);
            return;
        }// end function

        private function cbRestEnd(param1:PlayerPersonal) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._reserveList)
            {
                _loc_2 = this.createNotDisplayList();
                for each (_loc_3 in MagicLabolatoryManager.getInstance().aLearningData)
                {
                    
                    _loc_2.push(_loc_3.uniqueId);
                }
                if (_loc_2.indexOf(param1.uniqueId) < 0)
                {
                    this._reserveList.removeNotDisplayPlayer(param1.uniqueId);
                    this._reserveList.updateList();
                    this._reserveList.checkEmptyInformation();
                    this._reserveList.setRestEndAction(param1.uniqueId);
                }
            }
            return;
        }// end function

    }
}
