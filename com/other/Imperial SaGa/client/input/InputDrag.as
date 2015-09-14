package input
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class InputDrag extends InputBase
    {
        private var _cbDrag:Function;
        private var _cbMove:Function;
        private var _cbDrop:Function;
        private var _dragTarget:Object;
        private var _aMask:Array;
        private var _startPos:Point;

        public function InputDrag(param1:Object, param2:Object, param3:Function, param4:Function, param5:Function, param6:int = 0)
        {
            super(param1, param6);
            this._cbDrag = param3;
            this._cbMove = param4;
            this._cbDrop = param5;
            this._dragTarget = param2;
            this._aMask = [];
            this._startPos = null;
            return;
        }// end function

        public function release() : void
        {
            this._startPos = null;
            this._aMask = null;
            this._dragTarget = null;
            this._cbDrop = null;
            this._cbMove = null;
            this._cbDrag = null;
            return;
        }// end function

        public function addMaskObject(param1:Object) : void
        {
            this._aMask.push(param1);
            return;
        }// end function

        public function delMaskObject(param1:Object) : void
        {
            var _loc_2:* = this._aMask.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this._aMask.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function OnDrag(event:MouseEvent, param2:Point) : Boolean
        {
            if (_bEnable)
            {
                if (this.HitTest(this._dragTarget, param2) && this.MaskTest(param2) && ButtonManager.getInstance().isMouseOnDragBlockButton() == false)
                {
                    this._startPos = param2;
                    if (this._cbDrag != null)
                    {
                        this._cbDrag(event);
                    }
                    return true;
                }
            }
            return false;
        }// end function

        public function OnMove(event:MouseEvent) : void
        {
            if (_bEnable && this._cbMove != null)
            {
                this._cbMove(event);
                event.updateAfterEvent();
            }
            return;
        }// end function

        public function OnDrop(event:MouseEvent) : void
        {
            if (_bEnable)
            {
                this._startPos = null;
                if (this._cbDrop != null)
                {
                    this._cbDrop(event);
                }
            }
            return;
        }// end function

        public function get startPos() : Point
        {
            return this._startPos;
        }// end function

        protected function HitTest(param1:Object, param2:Point) : Boolean
        {
            if (param1 is DisplayObject)
            {
                return (param1 as DisplayObject).hitTestPoint(param2.x, param2.y);
            }
            return false;
        }// end function

        protected function MaskTest(param1:Point) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aMask)
            {
                
                if (this.HitTest(_loc_2, param1))
                {
                    return false;
                }
            }
            return true;
        }// end function

    }
}
