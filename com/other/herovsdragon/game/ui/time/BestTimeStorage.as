package herovsdragon.game.ui.time
{
    import flash.net.*;

    public class BestTimeStorage extends Object
    {
        private var sharedObject:SharedObject;

        public function BestTimeStorage()
        {
            this.sharedObject = SharedObject.getLocal("herovsdragon");
            return;
        }// end function

        public function recordPlayTime(param1:int) : void
        {
            this.sharedObject.data.playTime = param1;
            return;
        }// end function

        public function getBestPlayTime() : int
        {
            return this.sharedObject.data.playTime;
        }// end function

    }
}
