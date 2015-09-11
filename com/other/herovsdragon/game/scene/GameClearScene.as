package herovsdragon.game.scene
{
    import flash.display.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import herovsdragon.game.scene.view.*;

    public class GameClearScene extends GameScene
    {
        private var twitterBtn:SimpleButton;
        private var playTimeTxt:TextField;
        private var bestTimeTxt:TextField;
        private var playTimeStr:String;
        private var bestTimeStr:String;

        public function GameClearScene()
        {
            viewClass = GameClear;
            retryBtn = (view as GameClear).retryBtn;
            this.twitterBtn = (view as GameClear).twitterBtn;
            this.playTimeTxt = (view as GameClear).playTimeTxt;
            this.bestTimeTxt = (view as GameClear).bestTimeTxt;
            return;
        }// end function

        public function setPlayTimeStr(param1:String, param2:String) : void
        {
            this.playTimeStr = param1;
            this.bestTimeStr = param2;
            return;
        }// end function

        override public function initializePlay() : void
        {
            this.twitterBtn.visible = false;
            this.playTimeTxt.visible = false;
            this.bestTimeTxt.visible = false;
            super.initializePlay();
            return;
        }// end function

        override protected function initializeForViewedScene() : void
        {
            this.twitterBtn.visible = true;
            this.playTimeTxt.visible = true;
            this.bestTimeTxt.visible = true;
            this.playTimeTxt.text = this.playTimeStr;
            this.bestTimeTxt.text = this.bestTimeStr;
            super.initializeForViewedScene();
            return;
        }// end function

        override protected function viewScene() : void
        {
            if (clickChecker._target == this.twitterBtn)
            {
                this.checkTwitterBtn();
            }
            super.viewScene();
            return;
        }// end function

        private function checkTwitterBtn() : void
        {
            if (clickChecker._target != this.twitterBtn)
            {
                return;
            }
            var _loc_1:* = "CLEAR TIME " + this.playTimeStr;
            var _loc_2:* = " [HERO vs DRAGON]";
            _loc_1 = _loc_1 + (_loc_2 + "http://www.dango-itimi.com/hero_vs_dragon/");
            navigateToURL(new URLRequest("http://twitter.com/home?status=" + escapeMultiByte(_loc_1)), "_blank");
            return;
        }// end function

        override protected function finishForViewedScene() : void
        {
            this.twitterBtn.visible = false;
            this.playTimeTxt.visible = false;
            this.bestTimeTxt.visible = false;
            super.finishForViewedScene();
            return;
        }// end function

    }
}
