package layer
{
    import flash.display.*;

    public class LayerBase extends Sprite
    {
        private var _aLayer:Array;

        public function LayerBase(param1:int)
        {
            this._aLayer = new Array();
            this.createLayer(param1);
            return;
        }// end function

        private function createLayer(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < param1)
            {
                
                _loc_3 = new Sprite();
                this._aLayer.push(_loc_3);
                addChild(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (this._aLayer != null)
            {
                _loc_1 = this._aLayer.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = this._aLayer[_loc_1];
                    _loc_2.removeChildren();
                    if (_loc_2.parent)
                    {
                        _loc_2.parent.removeChild(_loc_2);
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            this._aLayer = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function getLayer(param1:int) : Sprite
        {
            return this._aLayer[param1];
        }// end function

    }
}
