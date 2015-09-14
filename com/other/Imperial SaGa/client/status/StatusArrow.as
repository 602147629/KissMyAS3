package status
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class StatusArrow extends Object
    {
        private var _arrowNull:MovieClip;
        private var _arrow_width:int;
        private var _arrow_height:int;
        private var _mcArrow:MovieClip;
        private var _arrowShape:Shape;
        private var _arrowBmpData:BitmapData;
        private var _arrowTargetPos:Point;

        public function StatusArrow(param1:MovieClip, param2:String, param3:String, param4:int = 29, param5:int = 19)
        {
            this._arrowNull = param1;
            this._arrow_width = param4;
            this._arrow_height = param5;
            this._mcArrow = new MovieClip();
            this._mcArrow.mouseEnabled = false;
            this._mcArrow.mouseChildren = false;
            this._arrowShape = new Shape();
            this._mcArrow.addChild(this._arrowShape);
            this._arrowNull.addChild(this._mcArrow);
            this._arrowBmpData = ResourceManager.getInstance().createSwfInBitmap(param2, param3);
            this._arrowTargetPos = new Point();
            return;
        }// end function

        public function release() : void
        {
            if (this._arrowShape && this._arrowShape.parent)
            {
                this._arrowShape.parent.removeChild(this._arrowShape);
            }
            this._arrowShape = null;
            if (this._mcArrow && this._mcArrow.parent)
            {
                this._mcArrow.parent.removeChild(this._mcArrow);
            }
            this._mcArrow = null;
            this._arrowNull = null;
            return;
        }// end function

        public function setArrowTargetPosition(param1:Point) : void
        {
            this._arrowTargetPos = param1;
            this.drawArrow(this._arrowTargetPos);
            return;
        }// end function

        private function drawArrow(param1:Point) : void
        {
            if (this._arrowBmpData == null)
            {
                return;
            }
            var _loc_2:* = this._arrowShape.localToGlobal(new Point());
            var _loc_3:* = this._arrowShape.graphics;
            _loc_3.clear();
            _loc_3.lineStyle(0, 0, 0);
            var _loc_4:* = Math.atan2(_loc_2.y - param1.y, _loc_2.x - param1.x);
            var _loc_5:* = Math.sqrt(Math.pow(_loc_2.x - param1.x, 2) + Math.pow(_loc_2.y - param1.y, 2));
            var _loc_6:* = new Matrix();
            new Matrix().identity();
            _loc_6.translate(0, Math.ceil(this._arrow_height / 2));
            _loc_6.rotate(_loc_4);
            var _loc_7:* = new Matrix();
            new Matrix().identity();
            _loc_7.scale(_loc_5 / this._arrow_width, 1);
            _loc_7.rotate(_loc_4);
            _loc_7.translate(param1.x - _loc_2.x + _loc_6.tx, param1.y - _loc_2.y + _loc_6.ty);
            _loc_3.beginBitmapFill(this._arrowBmpData, _loc_7, true, true);
            _loc_3.moveTo(_loc_6.tx, _loc_6.ty);
            _loc_3.lineTo(-_loc_6.tx, -_loc_6.ty);
            _loc_3.lineTo(param1.x - _loc_2.x, param1.y - _loc_2.y);
            _loc_3.endFill();
            return;
        }// end function

        private function clearArrow() : void
        {
            var _loc_1:* = this._arrowShape.graphics;
            _loc_1.clear();
            return;
        }// end function

    }
}
