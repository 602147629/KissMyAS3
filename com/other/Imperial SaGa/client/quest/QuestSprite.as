package quest
{
    import flash.display.*;

    public class QuestSprite extends Sprite
    {
        private var _sqY:int;
        private var _priority:int;
        private static var _pieceSortRequest:Boolean;

        public function QuestSprite(param1:int, param2:int)
        {
            this._sqY = param2;
            this._priority = param1;
            _pieceSortRequest = true;
            return;
        }// end function

        public function setSortPos(param1:int) : void
        {
            if (this._sqY != param1)
            {
                this._sqY = param1;
                _pieceSortRequest = true;
            }
            return;
        }// end function

        public function setSortPriority(param1:int) : void
        {
            if (this._priority != param1)
            {
                this._priority = param1;
                _pieceSortRequest = true;
            }
            return;
        }// end function

        public static function checkPieceSortRequest() : Boolean
        {
            return _pieceSortRequest;
        }// end function

        public static function clearPieceSortRequest() : void
        {
            _pieceSortRequest = false;
            return;
        }// end function

        public static function displaySortCmp(param1:QuestSprite, param2:QuestSprite) : Boolean
        {
            if (param1._sqY > param2._sqY)
            {
                return true;
            }
            if (param1._sqY == param2._sqY)
            {
                if (param1._priority > param2._priority)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
