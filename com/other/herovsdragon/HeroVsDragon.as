package herovsdragon
{
    import com.dango_itimi.events.core.*;
    import com.dango_itimi.events.mouse.*;
    import flash.display.*;
    import flash.events.*;
    import herovsdragon.game.*;

    public class HeroVsDragon extends Sprite
    {
        private var hitStopCount:int = 1;
        private var mainFunction:Function;
        private var keyChecker:KeyChecker;
        private var clickChecker:ClickChecker;
        private var dragChecker:DragChecker;
        private var dragCheckerForRight:DragChecker;
        private var game:Game;
        private static const HIT_STOP_COUNT_MAX:int = 2;

        public function HeroVsDragon()
        {
            this.mainFunction = this.waitForStageRecorgnized;
            addEventListener(Event.ENTER_FRAME, this.run);
            return;
        }// end function

        private function run(event:Event) : void
        {
            this.mainFunction();
            return;
        }// end function

        private function waitForStageRecorgnized() : void
        {
            if (stage)
            {
                this.initializeForGame();
            }
            return;
        }// end function

        private function initializeForGame() : void
        {
            this.keyChecker = new KeyChecker(stage);
            var _loc_1:* = MouseEventListener._instance;
            _loc_1.init(stage);
            this.clickChecker = _loc_1.createClickChecker();
            this.dragChecker = _loc_1.createDragChecker();
            var _loc_2:* = null;
            this.dragCheckerForRight = null;
            if (MouseEventListenerForRightClick.checkSupportedRightClick())
            {
                _loc_2 = MouseEventListenerForRightClick._instance;
                _loc_2.init(stage);
                this.dragCheckerForRight = _loc_2.createDragChecker();
            }
            this.game = new Game(this, this.keyChecker, this.clickChecker, this.dragChecker, this.dragCheckerForRight);
            this.mainFunction = this.runForGame;
            return;
        }// end function

        private function runForGame() : void
        {
            this.game.run();
            this.clickChecker.reset();
            if (this.game._isHitted)
            {
                this.game.resetHitted();
                this.hitStopCount = 0;
                this.mainFunction = this.stopHit;
            }
            return;
        }// end function

        private function stopHit() : void
        {
            var _loc_1:* = this;
            _loc_1.hitStopCount = this.hitStopCount + 1;
            if (++this.hitStopCount < HIT_STOP_COUNT_MAX)
            {
                return;
            }
            this.mainFunction = this.runForGame;
            return;
        }// end function

    }
}
