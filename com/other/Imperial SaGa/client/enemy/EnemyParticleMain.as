package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class EnemyParticleMain extends Object
    {
        private var _parent:DisplayObjectContainer;
        private var _aParticle:Array;
        private var _waitTime:Number;
        private var _waitTimeSwing:Number;
        private var _setTime:Number;
        private var _setTimeHiSpeed:Number;
        private var _bHiSpeed:Boolean;
        private var _aBmpData:Array;
        private var _cbParticleCreate:Function;
        private var _cbControl:Function;

        public function EnemyParticleMain(param1:DisplayObjectContainer, param2:Function, param3:Number, param4:Bitmap, param5:Array)
        {
            var _loc_6:* = null;
            this._waitTimeSwing = 0;
            this._parent = param1;
            this._aParticle = [];
            this._aBmpData = [];
            this._setTime = param3;
            this._waitTime = this._setTime;
            this._setTimeHiSpeed = this._setTime * 0.3;
            this._cbParticleCreate = param2;
            this._cbControl = null;
            if (param4 != null)
            {
                for each (_loc_6 in param5)
                {
                    
                    this.copyBitmap(param4, _loc_6);
                }
            }
            return;
        }// end function

        public function set waitTimeSwing(param1:Number) : void
        {
            this._waitTimeSwing = param1;
            return;
        }// end function

        public function set bHiSpeed(param1:Boolean) : void
        {
            this._bHiSpeed = param1;
            return;
        }// end function

        public function setCallBackControl(param1:Function) : void
        {
            this._cbControl = param1;
            return;
        }// end function

        public function copyBitmap(param1:Bitmap, param2:ColorTransform) : void
        {
            var _loc_3:* = new Point(param1.width, param1.height);
            var _loc_4:* = new BitmapData(_loc_3.x, _loc_3.y, true, 0);
            new BitmapData(_loc_3.x, _loc_3.y, true, 0).draw(param1, param1.transform.matrix, param2);
            this._aBmpData.push(_loc_4);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aParticle)
            {
                
                _loc_1.release();
            }
            this._aParticle = [];
            for each (_loc_2 in this._aBmpData)
            {
                
                _loc_2.dispose();
            }
            this._aBmpData = [];
            this._parent = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._waitTime = this._waitTime - param1;
            if (this._waitTime <= 0)
            {
                this._waitTime = this._bHiSpeed == false ? (this._setTime) : (this._setTimeHiSpeed);
                if (this._waitTimeSwing != 0)
                {
                    this._waitTime = this._waitTime + Random.range(0, int(this._waitTimeSwing * 10000)) / 10000;
                }
                if (this._aBmpData.length > 0)
                {
                    _loc_3 = this._aBmpData[Random.range(0, (this._aBmpData.length - 1))];
                    _loc_4 = this._cbParticleCreate(this._parent, _loc_3);
                    if (_loc_4 != null)
                    {
                        this._aParticle.push(_loc_4);
                    }
                }
            }
            var _loc_2:* = this._aParticle.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_5 = this._aParticle[_loc_2];
                if (this._cbControl != null)
                {
                    this._cbControl(param1, _loc_5);
                }
                _loc_5.control(param1);
                if (_loc_5.bEnd)
                {
                    _loc_5.release();
                    _loc_5 = null;
                    this._aParticle.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

    }
}
