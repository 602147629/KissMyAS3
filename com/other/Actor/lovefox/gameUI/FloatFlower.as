package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;

    public class FloatFlower extends Sprite
    {
        private var _sprite:Sprite;
        private var _flowerarr:Array;
        private var _posxV:Number = 0;
        private var _posyV:Number = 0;
        private var bmpf:Bitmap;
        private var _posxVinit:Number;

        public function FloatFlower()
        {
            this._flowerarr = [];
            this._sprite = new Sprite();
            return;
        }// end function

        public function addflowertostage(param1:Number = 100, param2:Number = 10)
        {
            this.bmpf = new Bitmap();
            var _loc_3:* = Math.round(Math.random() * 100);
            var _loc_4:* = 2;
            if (_loc_3 < 40)
            {
                _loc_4 = 1;
            }
            else if (_loc_3 < 70)
            {
                _loc_4 = 2;
            }
            else if (_loc_3 < 96)
            {
                _loc_4 = 3;
            }
            else if (_loc_3 <= 98)
            {
                _loc_4 = 4;
            }
            else if (_loc_3 <= 100)
            {
                _loc_4 = 5;
            }
            this.bmpf.bitmapData = GiveFlower.getBmpd("flower" + (_loc_4 - 1));
            this._sprite.addChild(this.bmpf);
            this._sprite.x = param1;
            this._sprite.y = param2;
            this._posxVinit = param1;
            var _loc_5:* = Math.round(Math.random() * 360) - 180;
            this._posxV = Math.cos(_loc_5) * 2;
            var _loc_6:* = Math.random() * 2 + 2;
            this._posyV = _loc_6;
            this._sprite.addEventListener(Event.ENTER_FRAME, this.down);
            Config.ui._layer1.addChild(this._sprite);
            return;
        }// end function

        private function down(event:Event) : void
        {
            this._sprite.x = this._sprite.x + this._posxV;
            this._sprite.y = this._sprite.y + this._posyV;
            if (this._sprite.y > Config.stage.stageHeight)
            {
                this.flowerdispose();
            }
            return;
        }// end function

        private function flowerdispose()
        {
            this._sprite.removeEventListener(Event.ENTER_FRAME, this.down);
            if (this.bmpf.hasOwnProperty("bitmapData"))
            {
                this.bmpf = null;
            }
            while (this._sprite.numChildren > 0)
            {
                
                this._sprite.removeChildAt((this._sprite.numChildren - 1));
            }
            Config.ui._layer1.removeChild(this._sprite);
            return;
        }// end function

    }
}
