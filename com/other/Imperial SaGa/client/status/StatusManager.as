package status
{
    import flash.display.*;
    import item.*;
    import player.*;
    import resource.*;

    public class StatusManager extends Object
    {
        private var _aDetail:Array;
        private var _cbClose:Function;
        private var _callerDetailStatus:PlayerDetailStatus;
        private static var _instance:StatusManager = null;

        public function StatusManager()
        {
            return;
        }// end function

        public function get aDetailLength() : int
        {
            return this._aDetail.length;
        }// end function

        public function get callerDetailStatus() : PlayerDetailStatus
        {
            return this._callerDetailStatus;
        }// end function

        public function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Correlation.swf");
            return;
        }// end function

        public function init() : void
        {
            this._aDetail = [];
            this._callerDetailStatus = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aDetail)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        public function addStatusDetail(param1:int, param2:DisplayObjectContainer, param3:Function = null, param4:PlayerPersonal = null, param5:Array = null, param6:int = 0) : void
        {
            var _loc_8:* = null;
            if (param3 != null)
            {
                this._cbClose = param3;
            }
            var _loc_7:* = new PlayerDetailStatus(param1, param2, this.cbCloseDetailStatus, param4, param5);
            if (param6 != Constant.EMPTY_ID && param4 == null)
            {
                _loc_7.setStatusByPlayerId(param6);
            }
            this._aDetail.push(_loc_7);
            if (this._aDetail.length > 1)
            {
                _loc_8 = this._aDetail[0];
                _loc_8.close();
            }
            else
            {
                _loc_7.open();
            }
            return;
        }// end function

        private function cbCloseDetailStatus(param1:int = 0) : void
        {
            var _loc_3:* = null;
            this._callerDetailStatus = this._aDetail.shift();
            var _loc_2:* = this._callerDetailStatus != null ? (this._callerDetailStatus.bUpdate) : (false);
            if (this._cbClose != null)
            {
                this._cbClose(param1, _loc_2);
            }
            if (this._callerDetailStatus != null)
            {
                this._callerDetailStatus.release();
            }
            this._callerDetailStatus = null;
            if (this._aDetail.length > 0)
            {
                _loc_3 = this._aDetail[0];
                _loc_3.open();
            }
            else
            {
                this._cbClose = null;
            }
            return;
        }// end function

        public function getOwnItemList(param1:Array, param2:Array, param3:int = 0) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_4:* = [];
            for each (_loc_5 in param1)
            {
                
                _loc_6 = 0;
                for each (_loc_7 in param2)
                {
                    
                    if (param3 == Constant.EMPTY_ID || _loc_7.uniqueId != param3)
                    {
                        for each (_loc_10 in _loc_7.aSetItemId)
                        {
                            
                            if (_loc_5.itemId == _loc_10)
                            {
                                _loc_6++;
                            }
                        }
                    }
                }
                _loc_8 = _loc_5.num - _loc_6;
                _loc_9 = 0;
                while (_loc_9 < _loc_8)
                {
                    
                    _loc_4.push(new OwnItemData(_loc_5.itemId, _loc_5.itemCategory, _loc_8));
                    _loc_9++;
                }
            }
            return _loc_4;
        }// end function

        public static function getInstance() : StatusManager
        {
            if (_instance == null)
            {
                _instance = new StatusManager;
            }
            return _instance;
        }// end function

    }
}
