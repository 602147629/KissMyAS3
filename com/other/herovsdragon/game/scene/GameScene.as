package herovsdragon.game.scene
{
    import com.dango_itimi.events.mouse.*;
    import flash.display.*;

    public class GameScene extends Object
    {
        protected var retryBtn:SimpleButton;
        private var mainFunction:Function;
        protected var viewClass:Class;
        protected var view:MovieClip;
        private var selectedRetry:Boolean;
        static var viewContainer:Sprite;
        static var clickChecker:ClickChecker;

        public function GameScene()
        {
            this.view = new this.viewClass();
            this.view.stop();
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        public function checkFinished() : Boolean
        {
            return this.mainFunction == this.end;
        }// end function

        protected function end() : void
        {
            trace("attention", this);
            return;
        }// end function

        public function initializePlay() : void
        {
            this.selectedRetry = false;
            this.retryBtn.visible = false;
            viewContainer.addChild(this.view);
            this.view.gotoAndStop(1);
            this.mainFunction = this.playToViewText;
            return;
        }// end function

        private function playToViewText() : void
        {
            this.view.nextFrame();
            if (this.view.currentLabel == "view")
            {
                this.initializeForViewedScene();
            }
            return;
        }// end function

        protected function initializeForViewedScene() : void
        {
            this.retryBtn.visible = true;
            this.mainFunction = this.viewScene;
            return;
        }// end function

        protected function viewScene() : void
        {
            if (clickChecker._target == this.retryBtn)
            {
                this.finishForViewedScene();
                this.selectedRetry = true;
            }
            return;
        }// end function

        protected function finishForViewedScene() : void
        {
            this.retryBtn.visible = false;
            this.mainFunction = this.playToEnd;
            return;
        }// end function

        private function playToEnd() : void
        {
            this.view.nextFrame();
            if (this.view.currentFrame != this.view.totalFrames)
            {
                return;
            }
            viewContainer.removeChild(this.view);
            this.mainFunction = this.end;
            return;
        }// end function

        public function get _selectedRetry() : Boolean
        {
            return this.selectedRetry;
        }// end function

        public static function initializeOnce(param1:ClickChecker, param2:Sprite) : void
        {
            GameScene.clickChecker = param1;
            GameScene.viewContainer = param2;
            return;
        }// end function

    }
}
