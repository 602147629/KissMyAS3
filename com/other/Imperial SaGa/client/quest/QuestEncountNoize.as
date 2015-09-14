package quest
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import sound.*;

    public class QuestEncountNoize extends QuestEncountBase
    {
        private const _PHASE_NONE:int = 0;
        private const _PHASE_NOISE_START:int = 1;
        private const _PHASE_NOISE_END:int = 2;
        private const _PHASE_CIRCLE_START:int = 3;
        private const _PHASE_CIRCLE_END:int = 4;
        private const _PHASE_END:int = 5;
        private const _PHASE_STOP:int = 99;
        private const _EFFECT_START_TIME:Number = 0.7;
        private const _EFFECT_END_TIME:Number = 1;
        private const _PILE:int = 1;
        private const SCALE_X:Number = 10;
        private const SCALE_Y:Number = 16;
        private const OFFSET_Y:Number = 10;
        private var _noize_Data:BitmapData;
        private var _noize_Draw_Data:BitmapData;
        private var _bitmapData:BitmapData;
        private var _blendSpr:Sprite;
        private var _mainSpr:Sprite;
        private var _battleSpr:Sprite;
        private var _bitmap:Bitmap;
        private var _filter:DisplacementMapFilter;
        private var _phase:int;
        private var _baseX:int;
        private var _baseY:int;
        private var _frame:int;
        private var _imgW:Number;
        private var _imgH:Number;
        private var _scaleX:Number;
        private var _scaleY:Number;
        private var _time:Number;
        private var _waitTime:Number;
        private var _offSet:Array;
        private var _sprBackGround:Sprite;
        private var _rand:int;

        public function QuestEncountNoize(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:DisplayObjectContainer)
        {
            this._sprBackGround = new Sprite();
            var _loc_4:* = this._sprBackGround.graphics;
            this._sprBackGround.graphics.beginFill(0, 1);
            _loc_4.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            super(param1);
            this._phase = this._PHASE_NONE;
            this._offSet = [new Point()];
            this._mainSpr = param2 as Sprite;
            this._battleSpr = param3 as Sprite;
            this._imgW = Constant.SCREEN_WIDTH;
            this._imgH = Constant.SCREEN_HEIGHT;
            this._baseX = 64;
            this._baseY = 64;
            this._bitmapData = new BitmapData(this._imgW, this._imgH, true, 0);
            this._bitmapData.draw(this._mainSpr);
            this._noize_Data = new BitmapData(this._baseX, this._baseY, true, 0);
            var _loc_5:* = new Matrix();
            new Matrix().scale(5, 5);
            this._noize_Draw_Data = new BitmapData(this._imgW, this._imgH, true, 0);
            this._noize_Draw_Data.draw(this._noize_Data, _loc_5);
            this._bitmap = new Bitmap(this._bitmapData);
            _baseSpr.addChild(this._bitmap);
            this._scaleY = 0;
            this._filter = new DisplacementMapFilter(this._noize_Draw_Data, new Point(0, 0), BitmapDataChannel.RED, BitmapDataChannel.GREEN, 1, 1, DisplacementMapFilterMode.WRAP);
            this._rand = Math.floor(Math.random() * 65535);
            this._blendSpr = new Sprite();
            this._blendSpr.blendMode = BlendMode.ALPHA;
            this._blendSpr.scaleX = 0;
            this._blendSpr.scaleY = 0;
            this._blendSpr.x = Constant.SCREEN_WIDTH_HALF;
            this._blendSpr.y = Constant.SCREEN_HEIGHT_HALF;
            var _loc_6:* = this._blendSpr.graphics;
            this._blendSpr.graphics.beginFill(16777215, 0.01);
            _loc_6.drawCircle(0, 0, Constant.SCREEN_WIDTH);
            _baseSpr.addChild(this._blendSpr);
            this._waitTime = 0;
            this._time = 0;
            this._frame = 0;
            this.setNoiseStart();
            return;
        }// end function

        override public function release() : void
        {
            if (this._bitmapData)
            {
                this._bitmapData.dispose();
            }
            this._bitmapData = null;
            if (this._noize_Data)
            {
                this._noize_Data.dispose();
            }
            this._noize_Data = null;
            if (this._noize_Draw_Data)
            {
                this._noize_Draw_Data.dispose();
            }
            this._noize_Draw_Data = null;
            if (this._bitmap && this._bitmap.parent)
            {
                this._bitmap.parent.removeChild(this._bitmap);
            }
            this._bitmap = null;
            if (this._blendSpr && this._blendSpr.parent)
            {
                _baseSpr.filters = [];
                this._blendSpr.parent.removeChild(this._blendSpr);
            }
            this._blendSpr = null;
            if (this._sprBackGround)
            {
                if (this._sprBackGround.parent)
                {
                    this._sprBackGround.parent.removeChild(this._sprBackGround);
                }
            }
            this._sprBackGround = null;
            this._battleSpr = null;
            this._mainSpr = null;
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (_bAllEnd)
            {
                return;
            }
            switch(this._phase)
            {
                case this._PHASE_NOISE_START:
                {
                    this._time = this._time + param1;
                    if (this._time >= this._waitTime)
                    {
                        this._time = this._waitTime;
                        _bEnd = true;
                    }
                    this.controlNoiseStart(param1);
                    if (_bEnd && _bBattleResourceComplete)
                    {
                        this.setCircleStart();
                        SoundManager.getInstance().playSe(SoundId.SE_RS3_SYSTEM_ENCOUNTER);
                    }
                    break;
                }
                case this._PHASE_NOISE_END:
                {
                    if (this._scaleY <= 0)
                    {
                        _bEnd = true;
                    }
                    this.controlNoiseEnd(param1);
                    if (_bEnd)
                    {
                        _bAllEnd = true;
                        this._phase = this._PHASE_END;
                    }
                    break;
                }
                case this._PHASE_CIRCLE_START:
                {
                    this._time = this._time + param1;
                    if (this._time >= this._waitTime)
                    {
                        this._time = this._waitTime;
                        _bEnd = true;
                        _bAllEnd = true;
                        this.setStop();
                    }
                    else
                    {
                        this.controlCircleStart(param1);
                    }
                    break;
                }
                case this._PHASE_CIRCLE_END:
                {
                    this._time = this._time - param1;
                    if (this._time <= 0)
                    {
                        this._time = 0;
                        _bEnd = true;
                        _bAllEnd = true;
                    }
                    else
                    {
                        this.controlCircleEnd(param1);
                    }
                    break;
                }
                case this._PHASE_STOP:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setStop() : void
        {
            this._phase = this._PHASE_STOP;
            return;
        }// end function

        override public function setEncountOpen() : void
        {
            super.setEncountOpen();
            this.setNoiseStart();
            return;
        }// end function

        override public function setEncountClose() : void
        {
            super.setEncountClose();
            this.setCircleEnd();
            if (this._sprBackGround && this._sprBackGround.parent)
            {
                this._sprBackGround.parent.removeChild(this._sprBackGround);
            }
            this._sprBackGround = null;
            return;
        }// end function

        public function setNoiseStart() : void
        {
            this._waitTime = this._EFFECT_START_TIME;
            this._time = 0;
            this._phase = this._PHASE_NOISE_START;
            _baseSpr.blendMode = BlendMode.NORMAL;
            return;
        }// end function

        private function controlNoiseStart(param1:Number) : void
        {
            this._scaleY = this._scaleY + 200 * param1;
            if (this._scaleY >= 100)
            {
                this._scaleY = 100;
            }
            var _loc_2:* = new Matrix();
            _loc_2.scale(Constant.SCREEN_WIDTH / this._baseX, Constant.SCREEN_HEIGHT / this._baseY);
            this._offSet[0].y = this._offSet[0].y + 10;
            this._noize_Data.perlinNoise(this._baseX, this._baseY, 1, this._rand, false, true, 2, false, this._offSet);
            this._noize_Draw_Data.draw(this._noize_Data, _loc_2);
            this._filter.mapBitmap = this._noize_Draw_Data;
            this._filter.scaleY = this._scaleY;
            _baseSpr.filters = [this._filter];
            return;
        }// end function

        private function setNoiseEnd() : void
        {
            this._waitTime = this._EFFECT_START_TIME;
            this._time = 0;
            this._phase = this._PHASE_NOISE_END;
            _baseSpr.blendMode = BlendMode.NORMAL;
            return;
        }// end function

        private function controlNoiseEnd(param1:Number) : void
        {
            this._offSet[0].x = this._offSet[0].x + 0;
            if (this._offSet[0].y > 0)
            {
                this._offSet[0].y = this._offSet[0].y - this.OFFSET_Y;
            }
            else
            {
                this._offSet[0].y = 0;
            }
            if (this._scaleY > 0)
            {
                this._scaleY = this._scaleY - this.SCALE_Y;
            }
            else
            {
                this._scaleX = 0;
                this._scaleY = 0;
            }
            var _loc_2:* = new Matrix();
            _loc_2.scale(5, 5);
            this._noize_Data.perlinNoise(this._baseX, this._baseY, 1, 1, false, false, 3, false, this._offSet);
            this._noize_Draw_Data.draw(this._noize_Data, _loc_2);
            this._filter.mapBitmap = this._noize_Draw_Data;
            this._filter.scaleX = this._scaleX;
            this._filter.scaleY = this._scaleY;
            _baseSpr.filters = [this._filter];
            return;
        }// end function

        private function setCircleStart() : void
        {
            this._blendSpr.blendMode = BlendMode.ALPHA;
            _bEnd = false;
            this._waitTime = this._EFFECT_END_TIME;
            this._time = 0;
            this._phase = this._PHASE_CIRCLE_START;
            _baseSpr.blendMode = BlendMode.LAYER;
            return;
        }// end function

        private function controlCircleStart(param1:Number) : void
        {
            var _loc_2:* = this._time / this._waitTime;
            var _loc_3:* = this._time / this._waitTime;
            this._blendSpr.scaleX = _loc_2;
            this._blendSpr.scaleY = _loc_3;
            return;
        }// end function

        private function setCircleEnd() : void
        {
            _baseSpr.filters = [];
            this._bitmapData.draw(this._battleSpr);
            this._bitmap.bitmapData = this._bitmapData;
            this._blendSpr.blendMode = BlendMode.ALPHA;
            this._bitmap.mask = this._blendSpr;
            this._battleSpr.visible = false;
            _bEnd = false;
            this._waitTime = this._EFFECT_END_TIME;
            this._time = this._EFFECT_END_TIME;
            this._phase = this._PHASE_CIRCLE_END;
            _baseSpr.blendMode = BlendMode.LAYER;
            return;
        }// end function

        private function controlCircleEnd(param1:Number) : void
        {
            var _loc_2:* = this._time / this._waitTime;
            var _loc_3:* = this._time / this._waitTime;
            this._blendSpr.scaleX = _loc_2;
            this._blendSpr.scaleY = _loc_3;
            return;
        }// end function

    }
}
