package home
{
    import album.*;
    import button.*;
    import flash.display.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class Album extends Object
    {
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _isoMain:InStayOut;
        private var _returnBtn:ButtonBase;
        private var _albumList:AlbumList;
        private var _aPlayerAllId:Array;
        private var _aPlayerId:Array;
        private var _aUpdatePlayerUniqueId:Array;
        private var _bClose:Boolean;
        private var _resLoadEnd:Boolean;
        private var _netLoadEnd:Boolean;
        private var _loadEnd:Boolean;

        public function Album(param1:LayerHome, param2:MovieClip)
        {
            this._baseMc = param2;
            this._layer = param1;
            this._layer.getLayer(LayerHome.MAIN).addChild(this._baseMc);
            this._isoMain = new InStayOut(this._baseMc);
            this._aUpdatePlayerUniqueId = [];
            this._returnBtn = ButtonManager.getInstance().addButton(this._baseMc.returnBtnMc, this._cbButtonClick);
            TextControl.setIdText(this._baseMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            this._aPlayerAllId = PlayerManager.getInstance().getPlayerIdAllList();
            NetManager.getInstance().request(new NetTaskAlbumList(this.cbReceive));
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._isoMain == null || this._isoMain && this._isoMain.bOpened;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bClose;
        }// end function

        public function get bLoadEnd() : Boolean
        {
            return this._loadEnd;
        }// end function

        public function set bLoadEnd(param1:Boolean) : void
        {
            this._loadEnd = param1;
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            this._aPlayerId = param1.data.aPlayerId;
            this._netLoadEnd = true;
            return;
        }// end function

        private function cbReceiveEquipmentChange(param1:NetResult) : void
        {
            this._bClose = true;
            return;
        }// end function

        public function release() : void
        {
            if (this._isoMain != null)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._albumList)
            {
                this._albumList.release();
            }
            this._albumList = null;
            this._layer = null;
            this._baseMc = null;
            if (this._returnBtn != null)
            {
                ButtonManager.getInstance().removeButton(this._returnBtn);
                this._returnBtn = null;
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._albumList == null)
            {
                if (ResourceManager.getInstance().isLoaded() && this._netLoadEnd)
                {
                    this._albumList = new AlbumList(this._baseMc, this._aPlayerAllId, this._aPlayerId, this.cbStatusClose, this._returnBtn);
                    this._albumList.createAlbumList();
                }
            }
            else
            {
                this._albumList.control(param1);
                if (this._albumList.bListCreateEnd)
                {
                    this._albumList.resourceAlbumLoad();
                }
                else if (this._albumList.bResourceLoadEnd)
                {
                    this._albumList.updateAlbumList();
                    this._loadEnd = true;
                }
            }
            return;
        }// end function

        public function open() : void
        {
            if (this._isoMain.bClosed)
            {
                this._isoMain.setIn(this.cbIn);
            }
            return;
        }// end function

        public function cbIn() : void
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_ALBUM))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_ALBUM);
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._isoMain.bOpened)
            {
                this._isoMain.setOut(this.cbCloseEnd);
            }
            return;
        }// end function

        private function cbStatusClose(param1:int) : void
        {
            if (this._aUpdatePlayerUniqueId.indexOf(param1) == -1)
            {
                this._aUpdatePlayerUniqueId.push(param1);
            }
            return;
        }// end function

        private function _cbButtonClick(param1:int) : void
        {
            this.close();
            return;
        }// end function

        private function cbCloseEnd() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._aUpdatePlayerUniqueId.length == 0)
            {
                this._bClose = true;
            }
            else
            {
                _loc_1 = [];
                _loc_2 = UserDataManager.getInstance().userData.aPlayerPersonal;
                for each (_loc_3 in this._aUpdatePlayerUniqueId)
                {
                    
                    _loc_4 = new Object();
                    for each (_loc_5 in _loc_2)
                    {
                        
                        if (_loc_5.uniqueId == _loc_3)
                        {
                            _loc_4.uniqueId = _loc_3;
                            _loc_4.aSkill = _loc_5.aSetSkillId;
                            _loc_4.aItem = _loc_5.aSetItemId;
                            break;
                        }
                    }
                    _loc_1.push(_loc_4);
                }
                NetManager.getInstance().request(new NetTaskEquipmentChange(_loc_1, this.cbReceiveEquipmentChange));
            }
            return;
        }// end function

    }
}
