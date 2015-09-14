package quest
{
    import flash.display.*;

    public class QuestEncountBase extends Object
    {
        protected var _baseSpr:Sprite;
        protected var _bEnd:Boolean;
        protected var _bAllEnd:Boolean;
        protected var _bBattleResourceComplete:Boolean;

        public function QuestEncountBase(param1:DisplayObjectContainer)
        {
            this._baseSpr = new Sprite();
            param1.addChild(this._baseSpr);
            this._bEnd = false;
            this._bAllEnd = false;
            this._bBattleResourceComplete = false;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function get bAllEnd() : Boolean
        {
            return this._bAllEnd;
        }// end function

        public function get bBattleResourceComplete() : Boolean
        {
            return this._bBattleResourceComplete;
        }// end function

        public function set bBattleResourceComplete(param1:Boolean) : void
        {
            this._bBattleResourceComplete = param1;
            return;
        }// end function

        public function release() : void
        {
            if (this._baseSpr.parent)
            {
                this._baseSpr.parent.removeChild(this._baseSpr);
            }
            this._baseSpr = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function setEncountOpen() : void
        {
            this._bEnd = false;
            this._bAllEnd = false;
            return;
        }// end function

        public function setEncountClose() : void
        {
            this._bEnd = false;
            this._bAllEnd = false;
            return;
        }// end function

    }
}
