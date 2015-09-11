package herovsdragon.game.hero.act
{
    import Box2D.Common.Math.*;
    import flash.display.*;

    public class AttackActor extends Actor
    {

        public function AttackActor()
        {
            return;
        }// end function

        override protected function initializeActFree() : void
        {
            chunk._body.SetLinearVelocity(new b2Vec2());
            return;
        }// end function

        override protected function action() : void
        {
            if (view.nextAttackPt)
            {
                reserveNextAttack();
            }
            view.nextFrame();
            if (view.currentFrame == view.totalFrames)
            {
                mainFunction = end;
            }
            return;
        }// end function

        public function getBladeHitArea() : Sprite
        {
            return view.attackHitArea;
        }// end function

        public function isChangedNextAttack() : Boolean
        {
            if (_reservedAttack)
            {
            }
            return view.currentFrameLabel == "changeNextAttack";
        }// end function

    }
}
