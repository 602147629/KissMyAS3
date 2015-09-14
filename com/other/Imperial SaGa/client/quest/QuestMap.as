package quest
{
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class QuestMap extends Object
    {
        private var TITLE_WAIT:Number = 1;
        private var _layer:LayerQuestMap;
        private var _mc:MovieClip;
        private var _bgBmp:Bitmap;
        private var _isoMap:InStayOut;
        private var _isoTitle:InStayOut;
        private var _isoIndication:InStayOut;
        private var _aSquare:Array;
        private var _aLine:Array;
        private var _mapSize:Rectangle;
        private var _titleWait:Number = 0;
        private var _bTitleDisp:Boolean;

        public function QuestMap(param1:MovieClip, param2:LayerQuestMap)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            this._layer = param2;
            this._mc = param1;
            this._isoMap = new InStayOut(this._mc);
            this._isoTitle = new InStayOut(this._mc.questTitleMc);
            this._isoIndication = new InStayOut(this._mc.indicationMc);
            this._mc.indicationMc.menuBtnMc.visible = false;
            var _loc_3:* = QuestManager.getInstance().questData;
            this._bgBmp = ResourceManager.getInstance().createBitmap(ResourcePath.QUEST_MAP_PATH + _loc_3.fileName);
            this._layer.getLayer(LayerQuestMap.BG).addChild(this._bgBmp);
            this._mapSize = new Rectangle(0, 0, this._bgBmp.width, this._bgBmp.height);
            this._aLine = [];
            var _loc_4:* = QuestManager.getInstance().questData.aSquare;
            for each (_loc_5 in _loc_4)
            {
                
                _loc_7 = _loc_5.aConnectionId;
                _loc_8 = new Point(_loc_5.x, _loc_5.y);
                for each (_loc_9 in _loc_7)
                {
                    
                    _loc_10 = String(_loc_5.id + "_" + _loc_9);
                    _loc_11 = QuestManager.getInstance().getSquare(_loc_9);
                    if (_loc_11 != null)
                    {
                        _loc_12 = new Point(_loc_11.x, _loc_11.y);
                        _loc_13 = new QuestMapRoute(this._layer.getLayer(LayerQuestMap.BG), _loc_8, _loc_12);
                        this._aLine[_loc_10] = _loc_13;
                    }
                }
            }
            this._aSquare = [];
            for each (_loc_6 in _loc_3.aSquare)
            {
                
                _loc_14 = new QuestMapSquare(this._layer.getLayer(LayerQuestMap.BG), this._layer.getLayer(LayerQuestMap.PIECE), _loc_6.id);
                this._aSquare.push(_loc_14);
            }
            TextControl.setText(this._mc.questTitleMc.questTitleTextMc2.textDt, _loc_3.title);
            TextControl.setText(this._mc.questTitleMc.questTitleTextMc.textDt, _loc_3.title);
            this._mc.indicationMc.miniQuestTitleMc.visible = false;
            return;
        }// end function

        public function get bTitleDisp() : Boolean
        {
            return this._bTitleDisp;
        }// end function

        public function get bWait() : Boolean
        {
            return this._isoMap.bWait;
        }// end function

        public function get miniTitleNullPos() : Point
        {
            return this._mc.indicationMc.miniTitleNull.localToGlobal(new Point());
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            for each (_loc_1 in this._aSquare)
            {
                
                _loc_1.release();
            }
            this._aSquare = [];
            if (this._bgBmp)
            {
                this._bgBmp.bitmapData.dispose();
                if (this._bgBmp.parent)
                {
                    this._bgBmp.parent.removeChild(this._bgBmp);
                }
            }
            this._bgBmp = null;
            this._isoIndication.release();
            this._isoIndication = null;
            this._isoMap.release();
            this._isoMap = null;
            this._isoTitle.release();
            this._isoTitle = null;
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._titleWait > 0)
            {
                this._titleWait = this._titleWait - param1;
                if (this._titleWait <= 0)
                {
                    this._isoTitle.setOut(this.cbIsoTitleOut);
                }
            }
            return;
        }// end function

        public function setMapOpen(param1:Function) : void
        {
            this._isoMap.setIn(param1);
            return;
        }// end function

        public function setMapClose(param1:Function) : void
        {
            this._isoMap.setOut(param1);
            return;
        }// end function

        public function setTitleOpen() : void
        {
            this._isoTitle.setIn(this.cbIsoTitleIn);
            this._bTitleDisp = true;
            return;
        }// end function

        private function cbIsoTitleIn() : void
        {
            this._titleWait = this.TITLE_WAIT;
            return;
        }// end function

        private function cbIsoTitleOut() : void
        {
            this._bTitleDisp = false;
            return;
        }// end function

        public function setInformationOpen() : void
        {
            this._isoIndication.setIn();
            return;
        }// end function

        public function getMapOffsetY() : Number
        {
            var _loc_1:* = this._mc.questMapMc;
            return _loc_1.y;
        }// end function

        public function getMapSize() : Rectangle
        {
            return this._mapSize;
        }// end function

        public function getSquare(param1:int) : QuestMapSquare
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aSquare)
            {
                
                if (_loc_2.squareId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getLine(param1:String) : QuestMapRoute
        {
            var _loc_2:* = this._aLine[param1];
            return _loc_2;
        }// end function

        public function sortPieceLayer() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_1:* = this._layer.getLayer(LayerQuestMap.PIECE);
            var _loc_2:* = _loc_1.numChildren;
            var _loc_3:* = 0;
            while (_loc_3 < (_loc_2 - 1))
            {
                
                _loc_4 = _loc_1.getChildAt(_loc_3) as QuestSprite;
                if (_loc_4 == null)
                {
                }
                else
                {
                    _loc_5 = _loc_3 + 1;
                    while (_loc_5 < _loc_2)
                    {
                        
                        _loc_6 = _loc_1.getChildAt(_loc_5) as QuestSprite;
                        if (_loc_6 == null)
                        {
                        }
                        else if (QuestSprite.displaySortCmp(_loc_4, _loc_6))
                        {
                            _loc_1.swapChildrenAt(_loc_3, _loc_5);
                            _loc_4 = _loc_6;
                        }
                        _loc_5++;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        public static function getSoundIdArray() : Array
        {
            return [];
        }// end function

        public static function getResourceName() : String
        {
            return "UI_QuestMap.swf";
        }// end function

    }
}
