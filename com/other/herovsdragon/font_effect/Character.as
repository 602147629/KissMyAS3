package herovsdragon.font_effect
{
    import flash.display.*;
    import flash.geom.*;

    public class Character extends Object
    {
        private var mainFunction:Function;
        private var behind:Behind;
        private var front:Front;
        private var charCode:Number;
        private var motionGuide:MovieClip;
        private var layer:Sprite;
        private var startWaitingFrame:uint;
        private var waitCount:int;
        private var charPositionX:Number;

        public function Character(param1:String, param2:Number, param3:Class, param4:uint, param5:ColorTransform = null)
        {
            this.charPositionX = param2;
            this.startWaitingFrame = param4;
            this.motionGuide = new param3;
            this.motionGuide.stop();
            this.layer = new Sprite();
            this.layer.visible = false;
            this.setMotionGuideDataToLayer();
            this.front = new Front();
            this.behind = new Behind();
            if (param5)
            {
                this.behind.transform.colorTransform = param5;
            }
            this.charCode = param1.charCodeAt();
            this.behind.gotoAndStop(this.charCode);
            this.front.gotoAndStop(this.charCode);
            return;
        }// end function

        private function setMotionGuideDataToLayer() : void
        {
            this.layer.x = this.motionGuide.mc.x + this.charPositionX;
            this.layer.y = this.motionGuide.mc.y;
            this.layer.alpha = this.motionGuide.mc.alpha;
            this.layer.scaleX = this.motionGuide.mc.scaleX;
            this.layer.scaleY = this.motionGuide.mc.scaleY;
            return;
        }// end function

        public function getWidth() : Number
        {
            return this.behind.width;
        }// end function

        public function addChild(param1:Sprite) : void
        {
            this.layer.addChild(this.behind);
            this.layer.addChild(this.front);
            param1.addChild(this.layer);
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

        public function initializeForRun() : void
        {
            this.waitCount = 0;
            this.mainFunction = this.wait;
            return;
        }// end function

        private function wait() : void
        {
            var _loc_1:* = this;
            _loc_1.waitCount = this.waitCount + 1;
            if (++this.waitCount < this.startWaitingFrame)
            {
                return;
            }
            this.layer.visible = true;
            this.mainFunction = this.action;
            return;
        }// end function

        private function action() : void
        {
            this.motionGuide.nextFrame();
            this.setMotionGuideDataToLayer();
            if (this.motionGuide.currentFrame < this.motionGuide.totalFrames)
            {
                return;
            }
            this.mainFunction = this.end;
            return;
        }// end function

        private function end() : void
        {
            return;
        }// end function

    }
}
