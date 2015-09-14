package quest
{
    import flash.display.*;
    import flash.events.*;
    import resource.*;

    public class QuestPieceHippopotamus extends QuestSprite
    {
        private var _sq:QuestSquare;
        private var _parent:DisplayObjectContainer;
        private var _squareId:int;
        private var _baseMc:MovieClip;
        private var _bShow:Boolean;
        private var _bVanish:Boolean;
        public static const ICON_TYPE_PAYMENT_EVENT_START:int = 1;
        public static const ICON_TYPE_PAYMENT_EVENT_NEXT:int = 2;
        public static const ICON_TYPE_PAYMENT_EVENT_DIVIDE:int = 3;

        public function QuestPieceHippopotamus(param1:DisplayObjectContainer, param2:QuestSquare, param3:int)
        {
            super(QuestConstant.PIECE_PRIORITY_HIPPOPOTAMUS, param2.y);
            param1.addChild(this);
            this._parent = param1;
            this._sq = param2;
            this._squareId = this._sq.id;
            this._bShow = true;
            this._bVanish = false;
            this._parent.addChild(this);
            this._baseMc = createMc(param3);
            this._baseMc.x = param2.x;
            this._baseMc.y = param2.y;
            this.addChild(this._baseMc);
            if (param3 == ICON_TYPE_PAYMENT_EVENT_NEXT)
            {
                this.alpha = 0;
                this._bShow = false;
            }
            this._baseMc.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        public function get squareId() : int
        {
            return this._squareId;
        }// end function

        public function get bVanish() : Boolean
        {
            return this._bVanish && this.visible == false;
        }// end function

        public function release() : void
        {
            if (this._baseMc)
            {
                this._baseMc.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            this._parent = null;
            return;
        }// end function

        public function setShow() : void
        {
            this._bShow = true;
            return;
        }// end function

        public function setVanish() : void
        {
            this._bShow = false;
            this._bVanish = true;
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = NaN;
            if (this._bVanish)
            {
                if (this.alpha > 0)
                {
                    _loc_2 = this.alpha - 0.05;
                    if (_loc_2 < 0)
                    {
                        _loc_2 = 0;
                    }
                    this.alpha = _loc_2;
                    if (this.alpha == 0)
                    {
                        this.visible = false;
                    }
                }
            }
            else if (this._bShow && this.alpha < 1)
            {
                _loc_2 = this.alpha + 0.05;
                if (_loc_2 > 1)
                {
                    _loc_2 = 1;
                }
                this.alpha = _loc_2;
                this.visible = true;
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.QUEST_PATH + "UI_QuestMap.swf";
        }// end function

        public static function createMc(param1:int) : MovieClip
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case ICON_TYPE_PAYMENT_EVENT_START:
                {
                    _loc_2 = "QuestMapKabaStartIcon";
                    break;
                }
                case ICON_TYPE_PAYMENT_EVENT_NEXT:
                {
                    _loc_2 = "QuestMapKabaNextIcon";
                    break;
                }
                case ICON_TYPE_PAYMENT_EVENT_DIVIDE:
                {
                }
                default:
                {
                    _loc_2 = "QuestMapKabaDivideIcon";
                    break;
                    break;
                }
            }
            return ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestMap.swf", _loc_2);
        }// end function

    }
}
