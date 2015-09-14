package questSelect
{
    import area.*;
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class WorldMap extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _bmpMap:Bitmap;
        private var _aButton:Array;
        private var _selectAreaId:int;
        private var _overAreaId:int;
        private var _bEnable:Boolean;
        private static const BUTTON_ON:String = "onMouse";
        private static const BUTTON_OFF:String = "offMouse";

        public function WorldMap(param1:MovieClip, param2:Array)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this._aButton = new Array();
            this._mc = param1;
            this._bmpMap = ResourceManager.getInstance().createBitmap(getWorldMapPath());
            this._bmpMap.smoothing = true;
            this._mc.worldmapMc.worldmapMc.imageNull.addChild(this._bmpMap);
            this._isoMain = new InStayOut(this._mc);
            var _loc_3:* = [];
            var _loc_4:* = 1;
            while (_loc_4 <= this._mc.worldmapMc.worldmapMc.numChildren)
            {
                
                _loc_6 = this._mc.worldmapMc.worldmapMc.getChildByName("area" + _loc_4.toString() + "Mc");
                _loc_7 = this._mc.worldmapMc.worldmapMc.getChildByName("areaName" + _loc_4.toString() + "Mc");
                if (_loc_6 == null)
                {
                    break;
                }
                if (_loc_7 == null)
                {
                    break;
                }
                _loc_8 = new Object();
                _loc_8.areaId = _loc_4;
                _loc_8.mc = _loc_6;
                _loc_8.nameMc = _loc_7;
                _loc_3.push(_loc_8);
                _loc_4++;
            }
            for each (_loc_5 in _loc_3)
            {
                
                _loc_9 = null;
                for each (_loc_10 in param2)
                {
                    
                    if (_loc_5.areaId == _loc_10.areaId)
                    {
                        _loc_9 = _loc_10;
                        break;
                    }
                }
                this.setAare(_loc_5, _loc_9);
            }
            TextControl.setIdText(this._mc.worldmapMc.worldmapMc.worldmapTextMc.textDt, MessageId.AREA_MAP_INFORMATION);
            return;
        }// end function

        public function get selectAreaId() : int
        {
            return this._selectAreaId;
        }// end function

        public function get overAreaId() : int
        {
            return this._overAreaId;
        }// end function

        public function get bEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function isOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function isClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function isAnimetion() : Boolean
        {
            return this._isoMain.bAnimetion;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
                _loc_1.release();
            }
            this._aButton = null;
            if (this._bmpMap)
            {
                if (this._bmpMap.parent)
                {
                    this._bmpMap.parent.removeChild(this._bmpMap);
                }
            }
            this._bmpMap = null;
            if (this._isoMain != null)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            return;
        }// end function

        private function setAare(param1:Object, param2:AreaInformation) : void
        {
            var _loc_3:* = param1.mc;
            var _loc_4:* = param1.nameMc;
            if (_loc_3 == null || _loc_4 == null)
            {
                throw new Error("エリアのクラスが存在しません");
            }
            if (param2 == null)
            {
                _loc_3.visible = false;
                _loc_4.visible = false;
                return;
            }
            _loc_3.visible = true;
            _loc_4.visible = true;
            var _loc_5:* = AreaManager.getInstance().getArea(param2.areaId);
            if (AreaManager.getInstance().getArea(param2.areaId) == null)
            {
                throw new Error("取得したエリア情報が存在しません");
            }
            var _loc_6:* = param2.aQuest.length > 0;
            var _loc_7:* = new ButtonBase(_loc_3, _loc_6 ? (this.cbClick) : (null), this.cbMouseOver, this.cbMouseOut);
            new ButtonBase(_loc_3, _loc_6 ? (this.cbClick) : (null), this.cbMouseOver, this.cbMouseOut).bHitPixel = true;
            _loc_7.setId(param2.areaId);
            _loc_7.enterSeId = _loc_6 ? (ButtonBase.SE_DECIDE_ID) : (SoundId.SE_GACHA_DISABLE);
            this._aButton.push(_loc_7);
            TextControl.setText(_loc_4.cityNameTextMc.textDt, _loc_5.name);
            TextControl.setText(_loc_4.cityname2TextMc.textDt, _loc_5.englishName);
            _loc_4.mapNewMc.visible = param2.bNewQuest;
            _loc_4.mapEasyMc.visible = param2.bEasyArea && param2.bStoryArea == false;
            _loc_4.mapStoryMc.visible = param2.bStoryArea;
            return;
        }// end function

        public function setIn() : void
        {
            var _loc_1:* = null;
            if (this.isClose() == false)
            {
                return;
            }
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            this._selectAreaId = Constant.UNDECIDED;
            this._overAreaId = Constant.UNDECIDED;
            this._isoMain.setIn();
            SoundManager.getInstance().playSe(SoundId.SE_CARPET_ROLL);
            return;
        }// end function

        public function setOut() : void
        {
            var _loc_1:* = null;
            if (this.isOpen() == false)
            {
                return;
            }
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.getMoveClip().gotoAndStop(BUTTON_OFF);
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            this._overAreaId = Constant.UNDECIDED;
            this._isoMain.setOut();
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisableFlag(param1);
            }
            this._bEnable = param1;
            return;
        }// end function

        private function cbClick(param1:int) : void
        {
            this._selectAreaId = param1;
            return;
        }// end function

        private function cbMouseOver(param1:int) : void
        {
            this._overAreaId = param1;
            return;
        }// end function

        private function cbMouseOut(param1:int) : void
        {
            if (ButtonManager.getInstance().isMouseOn() == false)
            {
                this._overAreaId = Constant.UNDECIDED;
            }
            return;
        }// end function

        private static function getWorldMapPath() : String
        {
            return ResourcePath.QUEST_WORLD_MAP_PATH + "Worldmap_01.png";
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(getWorldMapPath());
            SoundManager.getInstance().loadSoundArray([SoundId.SE_GACHA_DISABLE]);
            return;
        }// end function

    }
}
