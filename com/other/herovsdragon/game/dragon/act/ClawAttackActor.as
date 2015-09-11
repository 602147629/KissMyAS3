package herovsdragon.game.dragon.act
{
    import Box2D.Common.Math.*;
    import flash.display.*;

    public class ClawAttackActor extends Actor
    {

        public function ClawAttackActor()
        {
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            return;
        }// end function

        override protected function action() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2());
            if (view.currentFrameLabel == "claw_appeared")
            {
                soundEffectMap.playForClawAttack();
            }
            view.nextFrame();
            if (view.currentFrame == view.totalFrames)
            {
                mainFunction = finish;
            }
            return;
        }// end function

        public function getAttackHitArea() : Sprite
        {
            return view.attackHitArea;
        }// end function

    }
}
