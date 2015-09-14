package quest
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;

    public class QuestMapDarkness extends QuestMapObjectBase
    {
        public var _index:int;
        private var _maxHeight:Number;
        private static const OBJECT_VEC_X:Number = 0.2;
        private static const OBJECT_VEC_Y:Number = -2.5;
        private static const OBJECT_MOVE:Number = 0.1;
        private static const OBJECT_SCALE:Number = 0.01;

        public function QuestMapDarkness(param1:DisplayObjectContainer, param2:int, param3:Number)
        {
            super(param1, new Point(Math.random() * Constant.SCREEN_WIDTH, Math.random() * param3), new Point(Math.random() - OBJECT_VEC_X, OBJECT_VEC_Y), 10);
            this._maxHeight = param3;
            var _loc_4:* = new Sprite();
            new Sprite().graphics.beginFill(1048592);
            _loc_4.graphics.drawCircle(0, 0, 9);
            _loc_4.graphics.endFill();
            var _loc_5:* = new BitmapData(9, 9, true, 0);
            new BitmapData(9, 9, true, 0).draw(_loc_4);
            _bmp = new Bitmap(_loc_5);
            _layer.addChild(_bmp);
            this._index = param2;
            var _loc_6:* = new BlurFilter(4, 4, 1);
            _bmp.filters = [_loc_6];
            _bmp.scaleX = 1 / (OBJECT_SCALE * this._index + 1);
            _bmp.scaleY = 1 / (OBJECT_SCALE * this._index + 1);
            _phase = _PHASE_LIFE;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            return;
        }// end function

        override protected function controlLife() : void
        {
            if (_layer)
            {
                _layer.x = _layer.x + _vec.x / (OBJECT_MOVE * this._index + 1);
                _layer.y = _layer.y + _vec.y / (OBJECT_MOVE * this._index + 1);
                if (_layer.y < 0)
                {
                    _layer.x = _backupPos.x;
                    _layer.y = this._maxHeight;
                }
            }
            return;
        }// end function

    }
}
