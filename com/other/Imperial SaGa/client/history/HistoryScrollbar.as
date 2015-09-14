package history
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class HistoryScrollbar extends Object
    {
        private var _baseMc:MovieClip;
        private var _marker:MovieClip;
        private var _topMax:Number;
        private var _bottomMax:Number;
        private var _bDisable:Boolean;
        private var _aButton:Array;
        private var _markerMinPos:Point;
        private var _markerMaxPos:Point;
        private static const MARKER_MIN_Y:Number = 100;
        public static const BUTTON_LIST_UP:int = 1;
        public static const BUTTON_LIST_DOWN:int = 2;
        public static const BUTTON_LIST_ALL_UP:int = 3;
        public static const BUTTON_LIST_ALL_DOWN:int = 4;

        public function HistoryScrollbar(param1:MovieClip, param2:Function)
        {
            this._baseMc = param1;
            this._marker = this._baseMc.barMc;
            this._markerMaxPos = new Point(this._marker.x, this._marker.y);
            this._markerMinPos = new Point(this._marker.x, MARKER_MIN_Y);
            this._bDisable = false;
            var _loc_3:* = new Gauge(this._baseMc.barGuid, 1, 0);
            this._aButton = [];
            var _loc_4:* = ButtonManager.getInstance().addButton(this._baseMc.upBtn, param2, BUTTON_LIST_DOWN);
            ButtonManager.getInstance().addButton(this._baseMc.upBtn, param2, BUTTON_LIST_DOWN).enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_4);
            _loc_4 = ButtonManager.getInstance().addButton(this._baseMc.downBtn, param2, BUTTON_LIST_UP);
            _loc_4.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_4);
            _loc_4 = ButtonManager.getInstance().addButton(this._baseMc.upBtn2, param2, BUTTON_LIST_ALL_DOWN);
            _loc_4.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_4);
            _loc_4 = ButtonManager.getInstance().addButton(this._baseMc.downBtn2, param2, BUTTON_LIST_ALL_UP);
            _loc_4.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_4);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = null;
            this._baseMc = null;
            this._marker = null;
            return;
        }// end function

        public function updateMarkerPos(param1:Number) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (this._bDisable == false)
            {
                _loc_2 = param1 / this._topMax;
                _loc_3 = (this._markerMaxPos.y - this._markerMinPos.y) * _loc_2 + this._markerMinPos.y;
                if (_loc_3 < this._markerMinPos.y)
                {
                    _loc_3 = this._markerMinPos.y;
                }
                if (_loc_3 > this._markerMaxPos.y)
                {
                    _loc_3 = this._markerMaxPos.y;
                }
                this._marker.y = _loc_3;
            }
            return;
        }// end function

        public function updateMax(param1:Number, param2:Number) : void
        {
            this._topMax = param1;
            this._bottomMax = param2;
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._marker.visible = param1 == false;
            this._bDisable = param1;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisable(param1);
            }
            return;
        }// end function

    }
}
