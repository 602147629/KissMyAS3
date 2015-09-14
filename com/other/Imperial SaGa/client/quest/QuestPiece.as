package quest
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import resource.*;
    import sound.*;

    public class QuestPiece extends Sprite
    {
        private var _mcAnime:MovieClip;
        private var _mcPiece:DisplayObject;
        private var _bmpShadow:Bitmap;
        private var _beforeLabel:String;
        private var _bMoveing:Boolean;
        private var _cbUnitMoveEnd:Function;
        private var _moveFrameCount:int;
        private var _targetPoint:Point;
        private var _vec:Point;
        private var _bFall:Boolean;
        private var _bLand:Boolean;
        protected var _bVanish:Boolean;
        private var _landSeId:int;
        private static const _LABEL_STOP:String = "stop";
        private static const _LABEL_START:String = "start";
        private static const _LABEL_JUMP:String = "jump";
        private static const _LABEL_LAND:String = "land";
        private static const _LABEL_END:String = "end";

        public function QuestPiece(param1:DisplayObjectContainer, param2:DisplayObject = null)
        {
            this._targetPoint = new Point();
            this._vec = new Point();
            param1.addChild(this);
            this._bmpShadow = ResourceManager.getInstance().createEmbedBitmap("_classPieceShadow");
            this._bmpShadow.x = (-this._bmpShadow.width) * 0.5;
            this._bmpShadow.y = (-this._bmpShadow.height) * 0.5;
            addChild(this._bmpShadow);
            this._mcAnime = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "Piece_ani.swf", "piece_ani");
            this._mcAnime.gotoAndStop(_LABEL_STOP);
            addChild(this._mcAnime);
            if (param2 == null)
            {
            }
            else
            {
                this._mcPiece = param2;
            }
            this._mcAnime.pieceaniMc.addChild(this._mcPiece);
            var _loc_3:* = this.getFrameLabel(this._mcAnime, _LABEL_JUMP);
            var _loc_4:* = this.getFrameLabel(this._mcAnime, _LABEL_LAND);
            this._moveFrameCount = _loc_4.frame - _loc_3.frame;
            addEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._bMoveing = false;
            this._bFall = false;
            this._landSeId = SoundId.SE_STEP;
            return;
        }// end function

        public function setPieceShadow(param1:Boolean) : void
        {
            this._bmpShadow.visible = param1;
            return;
        }// end function

        public function get bMoveing() : Boolean
        {
            return this._bMoveing;
        }// end function

        public function get bLand() : Boolean
        {
            return this._bLand;
        }// end function

        public function get bVanish() : Boolean
        {
            return this._bVanish && this.visible == false;
        }// end function

        public function setLandSeId(param1:int) : void
        {
            this._landSeId = param1;
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            this._bLand = false;
            if (this._bMoveing)
            {
                _loc_2 = transform.matrix;
                if (this._bFall)
                {
                    _loc_2.translate(this._vec.x, this._vec.y);
                    transform.matrix = _loc_2;
                    var _loc_4:* = this.getShadowScale(this._mcAnime.pieceaniMc.y);
                    this._bmpShadow.scaleY = this.getShadowScale(this._mcAnime.pieceaniMc.y);
                    this._bmpShadow.scaleX = _loc_4;
                    this._bmpShadow.alpha = _loc_3;
                    if (y > this._targetPoint.y)
                    {
                        this._mcAnime.gotoAndPlay(_LABEL_LAND);
                        this._bFall = false;
                    }
                }
                switch(this._mcAnime.currentLabel)
                {
                    case _LABEL_STOP:
                    {
                        break;
                    }
                    case _LABEL_START:
                    {
                        if (this._beforeLabel != _LABEL_START)
                        {
                            if (this._vec.x > 0)
                            {
                                this.setReverse(true);
                            }
                            if (this._vec.x < 0)
                            {
                                this.setReverse(false);
                            }
                        }
                        break;
                    }
                    case _LABEL_JUMP:
                    {
                        _loc_2.translate(this._vec.x, this._vec.y);
                        transform.matrix = _loc_2;
                        _loc_3 = this.getShadowScale(this._mcAnime.pieceaniMc.y);
                        this._bmpShadow.scaleX = _loc_3;
                        this._bmpShadow.scaleY = _loc_3;
                        this._bmpShadow.alpha = _loc_3;
                        break;
                    }
                    case _LABEL_LAND:
                    {
                        if (this._beforeLabel != _LABEL_LAND)
                        {
                            this._bLand = true;
                            SoundManager.getInstance().playSe(this._landSeId);
                        }
                        _loc_2.tx = this._targetPoint.x;
                        _loc_2.ty = this._targetPoint.y;
                        transform.matrix = _loc_2;
                        this._bmpShadow.scaleX = 1;
                        this._bmpShadow.scaleY = 1;
                        this._bmpShadow.alpha = 1;
                        break;
                    }
                    case _LABEL_END:
                    {
                        this._bMoveing = false;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this._beforeLabel = this._mcAnime.currentLabel;
            this.disappear();
            return;
        }// end function

        private function getShadowScale(param1:int) : Number
        {
            var _loc_2:* = 1 + param1 / 128 * 0.5;
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
            }
            return _loc_2;
        }// end function

        private function getFrameLabel(param1:MovieClip, param2:String) : FrameLabel
        {
            var _loc_3:* = null;
            for each (_loc_3 in param1.currentLabels)
            {
                
                if (_loc_3.name == param2)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function release() : void
        {
            if (this._mcPiece.parent)
            {
                this._mcPiece.parent.removeChild(this._mcPiece);
            }
            this._mcPiece = null;
            if (this._mcAnime.parent)
            {
                this._mcAnime.parent.removeChild(this._mcAnime);
            }
            this._mcAnime = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            if (this._bmpShadow.parent)
            {
                this._bmpShadow.parent.removeChild(this._bmpShadow);
            }
            this._bmpShadow = null;
            removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        public function setMovePos(param1:int, param2:int) : void
        {
            this._bMoveing = true;
            this._mcAnime.gotoAndPlay(_LABEL_START);
            this._targetPoint.x = param1;
            this._targetPoint.y = param2;
            this._vec.x = (this._targetPoint.x - x) / this._moveFrameCount;
            this._vec.y = (this._targetPoint.y - y) / this._moveFrameCount;
            return;
        }// end function

        public function setPos(param1:int, param2:int) : void
        {
            this._mcAnime.gotoAndStop(_LABEL_STOP);
            var _loc_3:* = this.transform.matrix;
            _loc_3.translate(param1, param2);
            this.transform.matrix = _loc_3;
            return;
        }// end function

        public function setFall(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._bFall = true;
            this._bMoveing = true;
            this._mcAnime.gotoAndStop(_LABEL_STOP);
            var _loc_5:* = transform.matrix;
            transform.matrix.tx = param1;
            _loc_5.ty = param2;
            transform.matrix = _loc_5;
            this._targetPoint.x = param3;
            this._targetPoint.y = param4;
            this._vec.x = 0;
            this._vec.y = 70;
            return;
        }// end function

        public function setVanish() : void
        {
            this._bVanish = true;
            return;
        }// end function

        public function setReverse(param1:Boolean) : void
        {
            this.scaleX = param1 == true ? (-1) : (1);
            return;
        }// end function

        protected function disappear() : void
        {
            var _loc_1:* = NaN;
            if (this._bVanish && this.alpha > 0)
            {
                _loc_1 = this.alpha;
                _loc_1 = _loc_1 - 0.05;
                if (_loc_1 < 0)
                {
                    _loc_1 = 0;
                }
                this.alpha = _loc_1;
                if (this.alpha == 0)
                {
                    this.visible = false;
                }
            }
            return;
        }// end function

        public static function getResourcePathList() : Array
        {
            var _loc_1:* = [ResourcePath.QUEST_PATH + "Piece_ani.swf"];
            return _loc_1;
        }// end function

        public static function getSoundId() : int
        {
            return SoundId.SE_STEP;
        }// end function

    }
}
