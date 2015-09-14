package quest
{
    import flash.display.*;
    import flash.geom.*;

    public class QuestMapObjectBase extends Object
    {
        protected var _phase:int;
        protected var _layer:Sprite;
        protected var _bmp:Bitmap;
        protected var _backupPos:Point;
        protected var _vec:Point;
        protected var _lifeTime:Number;
        protected var _time:Number;
        protected var _bEnd:Boolean;
        static const _IN_TIME:Number = 0.3;
        static const _OUT_TIME:Number = 0.3;
        static const _PHASE_IN:int = 0;
        static const _PHASE_LIFE:int = 1;
        static const _PHASE_OUT:int = 2;
        static const _aResource:Array = [];

        public function QuestMapObjectBase(param1:DisplayObjectContainer, param2:Point, param3:Point, param4:Number)
        {
            this._layer = new Sprite();
            this._layer.x = param2.x;
            this._layer.y = param2.y;
            param1.addChild(this._layer);
            this._vec = param3;
            this._lifeTime = param4;
            this._time = 0;
            this._backupPos = param2.clone();
            this._bEnd = false;
            return;
        }// end function

        public function get backupPos() : Point
        {
            return this._backupPos;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._layer && this._layer.parent)
            {
                this._layer.parent.removeChild(this._layer);
            }
            this._layer = null;
            if (this._bmp)
            {
                if (this._bmp.bitmapData)
                {
                    this._bmp.bitmapData.dispose();
                }
                if (this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
            }
            this._bmp = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_IN:
                {
                    this.controlIn();
                    break;
                }
                case _PHASE_LIFE:
                {
                    this.controlLife();
                    break;
                }
                case _PHASE_OUT:
                {
                    this.controlOut();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function controlIn() : void
        {
            return;
        }// end function

        protected function controlLife() : void
        {
            return;
        }// end function

        protected function controlOut() : void
        {
            return;
        }// end function

        public function getPosition() : Point
        {
            return new Point(this._layer.x, this._layer.y);
        }// end function

    }
}
